import 'package:flutter/material.dart';
import 'package:rc_rtc_tolotanana/models/edition.dart';
import 'package:rc_rtc_tolotanana/models/patient.dart';
import 'package:rc_rtc_tolotanana/views/pages/add_patient_view.dart';
import 'package:rc_rtc_tolotanana/views/tiles/patient_tile.dart';
import 'package:rc_rtc_tolotanana/views/widgets/custom_appbar.dart';

import '../../services/database_client.dart';

class EditionDetailsView extends StatefulWidget {
  final Edition edition;

  const EditionDetailsView({super.key, required this.edition});

  @override
  State<EditionDetailsView> createState() => _EditionDetailsViewState();
}

class _EditionDetailsViewState extends State<EditionDetailsView> {
  List<Patient> patients = [];

  @override
  void initState() {
    getPatients();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          titleString: '${widget.edition.year} - ${widget.edition.city}',
          buttonTitle: '+',
          callback: addNewItem),
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1),
          itemBuilder: ((context, index) =>
              PatientTile(patient: patients[index])),
          itemCount: patients.length),
    );
  }

  addNewItem() {
    final next = AddPatientView(editionId: widget.edition.id);
    print('Edition id: ${widget.edition.id}');
    Navigator.push(context, MaterialPageRoute(builder: (context) => next))
        .then((value) => getPatients());
  }

  getPatients() async {
    DatabaseClient().patientFromEdition(widget.edition.id).then((patients) {
      setState(() {
        this.patients = patients;
      });
      print('Patients: ${patients.length}');
    });
  }
}
