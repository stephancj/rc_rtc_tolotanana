import 'package:flutter/material.dart';

class AddDialog extends StatelessWidget {
  final TextEditingController yearCtrl;
  final TextEditingController cityCtrl;
  VoidCallback onCancel;
  VoidCallback onValidate;

  AddDialog(
      {super.key,
      required this.yearCtrl,
      required this.cityCtrl,
      required this.onCancel,
      required this.onValidate});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Ajouter une liste"),
      content: Column(children: [
        TextField(
          controller: yearCtrl,
          decoration: const InputDecoration(hintText: "Année de l'édition"),
          keyboardType: TextInputType.number,
        ),
        TextField(
          controller: cityCtrl,
          decoration: const InputDecoration(hintText: "Ville de l'édition"),
          keyboardType: TextInputType.text,
        ),
      ]),
      actions: [
        TextButton(
            onPressed: onCancel,
            child: const Text(
              "Annuler",
              style: TextStyle(color: Colors.red),
            )),
        TextButton(
            onPressed: onValidate,
            child: const Text(
              "Valider",
              style: TextStyle(color: Colors.green),
            ))
      ],
    );
  }
}
