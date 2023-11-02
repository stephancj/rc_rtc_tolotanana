import 'package:flutter/material.dart';
import 'package:rc_rtc_tolotanana/components/operation_chart.dart';
import 'package:rc_rtc_tolotanana/models/edition.dart';
import 'package:rc_rtc_tolotanana/models/patient.dart';
import 'package:rc_rtc_tolotanana/views/pages/add_patient_view.dart';
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
            titleString: 'Statistiques',
            buttonTitle: '+',
            callback: addNewItem),
        body:
            // GridView.builder(
            //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //         crossAxisCount: 2),
            //     itemBuilder: ((context, index) =>
            //         // PatientTile(patient: patients[index])),
            //         EditionMenu(
            //           title: 'Patients',
            //           imageUrl:
            //               'https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/Resturant%20Image%20(1).png?alt=media&token=461162b1-686b-4b0e-a3ee-fae1cb8b5b33',
            //           number: patients.length,
            //         )),
            //     itemCount: patients.length),
            SingleChildScrollView(
                child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Row(
              children: [
                Text(
                  '${widget.edition.year} - ${widget.edition.city}',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const Spacer()
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                    child: SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                  child: const Card(
                    color: Colors.white,
                    elevation: 2,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nombre de patients',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '100',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          Text('patients total'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text('Hommes'),
                                  Text('50'),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text('Femmes'),
                                  Text('50'),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 6,
                        width: double.infinity,
                        child: const Card(
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.check_circle),
                                Text('100',
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold)),
                                Text('Aptes à operer')
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 6,
                        width: double.infinity,
                        child: const Card(
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.warning),
                                Text('100',
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold)),
                                Text('Inaptes pour operation')
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(children: [
              Text(
                'Ages',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              Spacer()
            ]),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.5),
                  border: Border.all(color: Colors.grey)),
              height: 75,
              child: const ListTile(
                leading: Icon(Icons.person),
                title: Text('Minimum'),
                subtitle: Text('Age le plus jeune'),
                trailing: Text('50', style: TextStyle(fontSize: 24)),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.5),
                  border: Border.all(color: Colors.grey)),
              height: 75,
              child: const ListTile(
                leading: Icon(Icons.person),
                title: Text('Moyenne'),
                subtitle: Text('La moyenne d\'age'),
                trailing: Text(
                  '50',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.5),
                  border: Border.all(color: Colors.grey)),
              height: 75,
              child: const ListTile(
                leading: Icon(Icons.person),
                title: Text('Maximum'),
                subtitle: Text('Age le plus vieux'),
                trailing: Text(
                  '50',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Text(
                  'Opérations',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Voir tout',
                      style: TextStyle(color: Colors.blueAccent),
                    )),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const OperationChart()
          ]),
        )));
  }

  addNewItem() {
    final next = AddPatientView(editionId: widget.edition.id);
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
