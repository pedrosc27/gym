import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym/domain/models/nutriologa_datos.dart';
import 'package:gym/domain/models/receta.dart';
import 'package:gym/ui/pages/nutriologa/nutriologa_datos.dart';
import 'package:gym/ui/pages/nutriologa/nutriologa_provider.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';

import 'package:gym/ui/global_widgets/input_text.dart';
import 'package:gym/ui/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as p;

class CrearDatosNutriologa extends StatefulWidget {
  const CrearDatosNutriologa({super.key});

  @override
  State<CrearDatosNutriologa> createState() => _CrearDatosNutriologa();
}

class _CrearDatosNutriologa extends State<CrearDatosNutriologa> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late String usuario;
  var peso = TextEditingController();
  var grasaImpidencia = TextEditingController();
  var masaImpidencia = TextEditingController();
  var cintura = TextEditingController();
  var perimetroAbdominal = TextEditingController();
  var cadera = TextEditingController();
  var pBrazoRelajado = TextEditingController();
  var pBrazoContraido = TextEditingController();
  var pMuslo = TextEditingController();
  var pPierna = TextEditingController();
  var plBiceps = TextEditingController();
  var plTriceps = TextEditingController();
  var pSubescapular = TextEditingController();
  var pIleocretal = TextEditingController();
  var pSupraespinal = TextEditingController();
  var pAbdominal = TextEditingController();
  var plMuslo = TextEditingController();
  var plPierna = TextEditingController();
  var porcentajeGrasa = TextEditingController();

  @override
  void initState() {
    super.initState();
    final entrenadorProvider = context.read<NutriologaProvider>();
    usuario = entrenadorProvider.user;
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final entrenadorProvider = context.watch<NutriologaProvider>();

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          "Ingrese Medidas del Usuario",
          style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'NeoMedium',
              fontWeight: FontWeight.w700),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: primary,
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            DateTime now = DateTime.now();
            final datosUsuario = NutriologaDatosModel(
                peso: peso.text,
                grasaImpidencia: grasaImpidencia.text,
                masaImpidencia: masaImpidencia.text,
                cintura: cintura.text,
                perimetroAbdominal: perimetroAbdominal.text,
                cadera: cadera.text,
                pBrazoRelajado: pBrazoRelajado.text,
                pBrazoContraido: pBrazoContraido.text,
                pMuslo: pMuslo.text,
                pPierna: pPierna.text,
                plBiceps: plBiceps.text,
                plTriceps: plTriceps.text,
                pSubescapular: pSubescapular.text,
                pIleocretal: pIleocretal.text,
                pSupraespinal: pSupraespinal.text,
                pAbdominal: pAbdominal.text,
                plMuslo: plMuslo.text,
                plPierna: plPierna.text,
                porcentajeGrasa: porcentajeGrasa.text,
                usuario: usuario,
                mes: now.month.toString(),
                year: now.year.toString(),
                timestamp: Timestamp.now());

            final personRef = FirebaseFirestore.instance
                .collection("datosnutriologa")
                .withConverter<NutriologaDatosModel>(
                  fromFirestore: (snapshots, _) {
                    final person =
                        NutriologaDatosModel.fromJson(snapshots.data()!);
                    //final newPerson = person.copyWith(id: snapshots.id);
                    return person;
                  },
                  toFirestore: (person, _) => person.toJson(),
                );
            final result = await personRef.add(datosUsuario);

            print(result);

            const snackBar = SnackBar(
              content: Text(
                "Se agrego la información del usuario correctamente",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontFamily: 'NeoRegular',
                    fontWeight: FontWeight.w700),
              ),
            );

            // Find the ScaffoldMessenger in the widget tree
            // and use it to show a SnackBar.
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            await Future.delayed(Duration(seconds: 3));
            //Navigator.pop(context);
          }
        },
        icon: const Icon(Icons.save),
        label: const Text(
          "Guardar Medidas",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontFamily: 'NeoRegular',
              fontWeight: FontWeight.w700),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 25.0,
                  ),
                  const Text(
                    "Peso (kg)",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: 'NeoRegular',
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  InputText(
                    controller: peso,
                    label: 'Nombre (kg)',
                    prefix: Icons.numbers,
                    type: TextInputType.number,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Este campo no puede estar vacío';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  const Text(
                    "Grasa por impedancia (%)",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: 'NeoRegular',
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  InputText(
                    controller: grasaImpidencia,
                    label: 'Grasa por impedancia (%)',
                    prefix: Icons.numbers,
                    type: TextInputType.number,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Este campo no puede estar vacío';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  const Text(
                    "Masa muscular por impedancia (Kg)",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: 'NeoRegular',
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  InputText(
                    controller: masaImpidencia,
                    label: 'Masa muscular por impedancia (Kg)',
                    prefix: Icons.numbers,
                    type: TextInputType.number,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Este campo no puede estar vacío';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  const Text(
                    "Cintura (Cm)",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: 'NeoRegular',
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  InputText(
                    controller: cintura,
                    label: 'Cintura (Cm)',
                    prefix: Icons.numbers,
                    type: TextInputType.number,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Este campo no puede estar vacío';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  const Text(
                    "Perímetro abdominal (Cm)",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: 'NeoRegular',
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  InputText(
                    controller: perimetroAbdominal,
                    label: 'Perímetro abdominal: Centímetros Cm',
                    prefix: Icons.numbers,
                    type: TextInputType.number,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Este campo no puede estar vacío';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  const Text(
                    "Cadera (Cm)",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: 'NeoRegular',
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  InputText(
                    controller: cadera,
                    label: 'Cadera (Cm)',
                    prefix: Icons.numbers,
                    type: TextInputType.number,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Este campo no puede estar vacío';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  const Text(
                    "Perímetro Brazo Relajado (Cm)",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: 'NeoRegular',
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  InputText(
                    controller: pBrazoRelajado,
                    label: 'Perímetro Brazo Relajado (Cm)',
                    prefix: Icons.numbers,
                    type: TextInputType.number,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Este campo no puede estar vacío';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  const Text(
                    "Perímetro Brazo Relajado (Cm)",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: 'NeoRegular',
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  InputText(
                    controller: pBrazoContraido,
                    label: 'Perímetro Brazo Contraído (Cm)',
                    prefix: Icons.numbers,
                    type: TextInputType.number,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Este campo no puede estar vacío';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  const Text(
                    "Perímetro Muslo (Cm)",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: 'NeoRegular',
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  InputText(
                    controller: pMuslo,
                    label: 'Perímetro Muslo (Cm)',
                    prefix: Icons.numbers,
                    type: TextInputType.number,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Este campo no puede estar vacío';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  const Text(
                    "Perímetro Pierna (Cm)",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: 'NeoRegular',
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  InputText(
                    controller: pPierna,
                    label: 'Perímetro Pierna (Cm)',
                    prefix: Icons.numbers,
                    type: TextInputType.number,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Este campo no puede estar vacío';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  const Text(
                    "Pliegues de bíceps (Mm)",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: 'NeoRegular',
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  InputText(
                    controller: plBiceps,
                    label: 'Pliegues de bíceps (Mm)',
                    prefix: Icons.numbers,
                    type: TextInputType.number,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Este campo no puede estar vacío';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  const Text(
                    "Pliegues de tríceps (Mm)",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: 'NeoRegular',
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  InputText(
                    controller: plTriceps,
                    label: 'Pliegues de tríceps (Mm)',
                    prefix: Icons.numbers,
                    type: TextInputType.number,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Este campo no puede estar vacío';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  const Text(
                    "Pliegues subescapular (Mm)",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: 'NeoRegular',
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  InputText(
                    controller: pSubescapular,
                    label: 'Pliegues subescapular (Mm)',
                    prefix: Icons.numbers,
                    type: TextInputType.number,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Este campo no puede estar vacío';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  const Text(
                    "Pliegue ileocretal (Mm)",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: 'NeoRegular',
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  InputText(
                    controller: pIleocretal,
                    label: 'Pliegue ileocretal (Mm)',
                    prefix: Icons.numbers,
                    type: TextInputType.number,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Este campo no puede estar vacío';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  const Text(
                    "Pliegues supraespinal (Mm)",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: 'NeoRegular',
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  InputText(
                    controller: pSupraespinal,
                    label: 'Pliegues supraespinal (Mm)',
                    prefix: Icons.numbers,
                    type: TextInputType.number,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Este campo no puede estar vacío';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  const Text(
                    "Pliegue abdominal (Mm)",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: 'NeoRegular',
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  InputText(
                    controller: pAbdominal,
                    label: 'Pliegue abdominal (Mm)',
                    prefix: Icons.numbers,
                    type: TextInputType.number,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Este campo no puede estar vacío';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  const Text(
                    "Pliegue muslo (Mm)",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: 'NeoRegular',
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  InputText(
                    controller: plMuslo,
                    label: 'Pliegue muslo (Mm)',
                    prefix: Icons.numbers,
                    type: TextInputType.number,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Este campo no puede estar vacío';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  const Text(
                    "Pliegue pierna (Mm)",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: 'NeoRegular',
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  InputText(
                    controller: plPierna,
                    label: 'Pliegue pierna (Mm)',
                    prefix: Icons.numbers,
                    type: TextInputType.number,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Este campo no puede estar vacío';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  const Text(
                    "Porcentaje de grasa (Mm)",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: 'NeoRegular',
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  InputText(
                    controller: porcentajeGrasa,
                    label: 'Porcentaje de grasa (Mm)',
                    prefix: Icons.numbers,
                    type: TextInputType.number,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Este campo no puede estar vacío';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 105.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
