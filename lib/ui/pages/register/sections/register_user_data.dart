import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym/data/preferences.dart';
import 'package:gym/domain/models/datos_usuario.dart';
import 'package:gym/domain/repository/users_repository.dart';
import 'package:gym/ui/global_widgets/button.dart';
import 'package:gym/ui/global_widgets/input_text.dart';
import 'package:gym/ui/pages/preload/preload.dart';
import 'package:gym/ui/pages/register/register_provider.dart';
import 'package:gym/ui/pages/register/sections/register_goal.dart';

import 'package:gym/ui/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterUserData extends StatefulWidget {
  const RegisterUserData._();
  static Widget init() => ChangeNotifierProvider(
        lazy: false,
        create: (context) => RegisterProvider(
          personRepository: context.read<UserRepository>(),
        ),
        child: const RegisterUserData._(),
      );

  @override
  State<RegisterUserData> createState() => _RegisterUserData();
}

class _RegisterUserData extends State<RegisterUserData> {
  int valorActual = 1;
  var nombreController = TextEditingController();
  var apellidoController = TextEditingController();
  var edadController = TextEditingController();
  var estaturaController = TextEditingController();
  var pesoController = TextEditingController();
  var discapacidadController = TextEditingController();
  var alergiaController = TextEditingController();
  var deporteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final SharedPreferences prefs = LocalStorage.prefs;
    return Container(
      color: Colors.black,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            "Datos Generales",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontFamily: 'NeoMedium',
                fontWeight: FontWeight.w700),
          ),
        ),
        backgroundColor: Colors.black,
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
                    "Nombre",
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
                    controller: nombreController,
                    label: 'Nombre',
                    prefix: Icons.text_format,
                    type: TextInputType.text,
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
                    "Apellido",
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
                    controller: apellidoController,
                    label: 'Nombre',
                    prefix: Icons.text_format,
                    type: TextInputType.text,
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
                    "Edad",
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
                    controller: edadController,
                    label: 'Edad',
                    prefix: Icons.date_range,
                    type: TextInputType.number,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Este campo no puede estar vacío';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  const Text(
                    "Sexo",
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: (() {
                          setState(() {
                            valorActual = 1;
                          });
                        }),
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: valorActual == 1
                                  ? primary
                                  : Color(0xFF1c1e21),
                              style: BorderStyle.solid,
                              width: 3.0,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20.0)),
                            color: Color(0xFF1c1e21),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.man,
                                color: valorActual == 1
                                    ? primary
                                    : Colors.blueGrey,
                                size: 60,
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                "Masculino",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: valorActual == 1
                                        ? primary
                                        : Colors.blueGrey,
                                    fontFamily: 'NeoRegular',
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (() {
                          setState(() {
                            valorActual = 2;
                          });
                        }),
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: valorActual == 2
                                  ? Colors.pink
                                  : Color(0xFF1c1e21),
                              style: BorderStyle.solid,
                              width: 3.0,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20.0)),
                            color: Color(0xFF1c1e21),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.woman,
                                color: valorActual == 2
                                    ? Colors.pink
                                    : Colors.blueGrey,
                                size: 60,
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                "Femenino",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: valorActual == 2
                                        ? Colors.pink
                                        : Colors.blueGrey,
                                    fontFamily: 'NeoRegular',
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  const Text(
                    "Estatura (CM)",
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
                    controller: estaturaController,
                    label: 'Nombre',
                    prefix: Icons.height,
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
                    "Peso (KG)",
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
                    controller: pesoController,
                    label: 'Peso',
                    prefix: Icons.balance,
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
                    "¿Padece alguna discapacidad?",
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
                    controller: discapacidadController,
                    label: '¿Padece alguna discapacidad?',
                    prefix: Icons.man,
                    type: TextInputType.text,
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
                    "¿Padece alguna alergía?",
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
                    controller: alergiaController,
                    label: '¿Padece alguna alergía?',
                    prefix: Icons.health_and_safety,
                    type: TextInputType.text,
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
                    "¿Practica algún deporte o actividad física?",
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
                    controller: deporteController,
                    label: "¿Practica algún deporte o actividad física?",
                    prefix: Icons.fitness_center,
                    type: TextInputType.text,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Este campo no puede estar vacío';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  ButtomCustom(
                    color: primary,
                    texto: "Siguiente",
                    onSubmit: () async {
                      if (formKey.currentState!.validate()) {
                        final emailnew = LocalStorage.prefs.getString("email");

                        final genero =
                            valorActual == 1 ? "Masculino" : "Femenino";
                        print(genero);

                        final goal = LocalStorage.prefs.getString("goal");
                        print(goal);
                        final datosUsuario = DatosUsuario(
                            nombre: nombreController.text,
                            apellido: apellidoController.text,
                            edad: edadController.text,
                            sexo: genero,
                            estatura: estaturaController.text,
                            peso: pesoController.text,
                            discapacidad: discapacidadController.text,
                            alergia: alergiaController.text,
                            deporte: deporteController.text,
                            email: emailnew!,
                            goal: goal!);
                        final setName = LocalStorage.prefs
                            .setString("nombre", nombreController.text);
                        final datosUsuarioRef = FirebaseFirestore.instance
                            .collection('datos')
                            .withConverter<DatosUsuario>(
                              fromFirestore: (snapshots, _) {
                                final person =
                                    DatosUsuario.fromJson(snapshots.data()!);
                                //final newPerson = person.copyWith(id: snapshots.id);
                                return person;
                              },
                              toFirestore: (person, _) => person.toJson(),
                            );
                        final result = await datosUsuarioRef.add(datosUsuario);
                        print(result);
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => PreLoadPage()),
                            (Route<dynamic> route) => false);
                        // Navigator.of(context).push(MaterialPageRoute(
                        //   builder: (_) => RegisterGoal.init()));
                      }
                    },
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}
