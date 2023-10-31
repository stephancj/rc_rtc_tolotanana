import 'package:flutter/material.dart';
import 'package:rc_rtc_tolotanana/models/edition.dart';
import 'package:rc_rtc_tolotanana/models/patient.dart';
import 'package:rc_rtc_tolotanana/views/pages/add_patient_view.dart';
import 'package:rc_rtc_tolotanana/views/tiles/patient_tile.dart';
import 'package:rc_rtc_tolotanana/views/widgets/custom_appbar.dart';

import '../../services/database_client.dart';

class ItemListView extends StatefulWidget {
  final Edition edition;

  const ItemListView({super.key, required this.edition});

  @override
  State<ItemListView> createState() => _ItemListViewState();
}

class _ItemListViewState extends State<ItemListView> {
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
          titleString: '${widget.edition.city}  ${widget.edition.year}',
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
    final next = AddPatientView(listId: widget.edition.id);
    Navigator.push(context, MaterialPageRoute(builder: (context) => next))
        .then((value) => getPatients());
  }

  getPatients() async {
    DatabaseClient().patientFromEdition(widget.edition.id).then((patients) {
      setState(() {
        this.patients = patients;
      });
    });
  }
}
