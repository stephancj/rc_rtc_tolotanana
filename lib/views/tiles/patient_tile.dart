import 'package:flutter/material.dart';
import 'package:rc_rtc_tolotanana/models/patient.dart';

class PatientTile extends StatelessWidget {
  final Patient patient;
  const PatientTile({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(patient.lastname,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24)),
        ],
      ),
    );
  }
}
