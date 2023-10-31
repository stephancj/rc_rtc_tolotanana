import 'package:flutter/material.dart';
import 'package:rc_rtc_tolotanana/models/patient.dart';
import 'package:rc_rtc_tolotanana/views/widgets/add_textfield.dart';
import 'package:rc_rtc_tolotanana/views/widgets/custom_appbar.dart';

import '../../services/database_client.dart';

class AddPatientView extends StatefulWidget {
  final int listId;
  const AddPatientView({super.key, required this.listId});

  @override
  State<AddPatientView> createState() => _AddPatientViewState();
}

class _AddPatientViewState extends State<AddPatientView> {
  late TextEditingController nameController;
  late TextEditingController firstNameController;
  late TextEditingController ageController;
  late TextEditingController sexeController;
  late TextEditingController adresseController;
  late TextEditingController telephoneController;
  late TextEditingController typeOperationController;
  late TextEditingController typeAnesthesieController;
  late TextEditingController observationController;
  late TextEditingController commentaireController;
  late TextEditingController dateNaissanceController;

  @override
  void initState() {
    nameController = TextEditingController();
    firstNameController = TextEditingController();
    ageController = TextEditingController();
    sexeController = TextEditingController();
    adresseController = TextEditingController();
    telephoneController = TextEditingController();
    typeOperationController = TextEditingController();
    typeAnesthesieController = TextEditingController();
    observationController = TextEditingController();
    commentaireController = TextEditingController();
    dateNaissanceController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    firstNameController.dispose();
    ageController.dispose();
    sexeController.dispose();
    adresseController.dispose();
    telephoneController.dispose();
    typeOperationController.dispose();
    typeAnesthesieController.dispose();
    observationController.dispose();
    commentaireController.dispose();
    dateNaissanceController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          titleString: 'Ajout de patient',
          buttonTitle: 'Valider',
          callback: addPressed),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AddTextfield(
                    hint: "Nom de famille", controller: nameController),
                AddTextfield(
                    hint: "Prénom(s)", controller: firstNameController),
                AddTextfield(hint: "Age", controller: ageController),
                AddTextfield(hint: "Sexe", controller: sexeController),
                AddTextfield(hint: "Adresse", controller: adresseController),
                AddTextfield(
                    hint: "Téléphone", controller: telephoneController),
                AddTextfield(
                    hint: "Type d'operation",
                    controller: typeOperationController),
                AddTextfield(
                    hint: "Type d'anesthesie",
                    controller: typeAnesthesieController),
                AddTextfield(
                    hint: "Observation", controller: observationController),
                AddTextfield(
                    hint: "Commentaire", controller: commentaireController),
                AddTextfield(
                    hint: "Date de naissance",
                    controller: dateNaissanceController),
              ],
            ))
          ],
        ),
      ),
    );
  }

  //Ajout d'un patient
  addPressed() {
    FocusScope.of(context).requestFocus(FocusNode());
    // si nom est vide, ne rien faire
    if (nameController.text.isEmpty) return;
    Map<String, dynamic> map = {'patient': widget.listId};
    map['lastname'] = nameController.text;
    map['firstname'] = firstNameController.text;
    map['age'] = ageController.text;
    map['sexe'] = sexeController.text;
    map['adresse'] = adresseController.text;
    map['telephone'] = telephoneController.text;
    map['typeOperation'] = typeOperationController.text;
    map['typeAnesthesie'] = typeAnesthesieController.text;
    map['observation'] = observationController.text;
    map['commentaire'] = commentaireController.text;
    map['dateNaissance'] = dateNaissanceController.text;

    // map['name'] = nameController.text;
    // if (shopController.text.isNotEmpty) map['shop'] = shopController.text;
    // double price = double.tryParse(priceController.text) ?? 0.0;
    // map['price'] = price;
    // if (imagePath != null) map['image'] = imagePath;
    Patient patient = Patient.fromMap(map);
    DatabaseClient().upsert(patient).then((value) => Navigator.pop(context));
  }
}
