import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym/domain/models/receta.dart';
import 'package:gym/ui/pages/nutriologa/nutriologa_provider.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';

import 'package:gym/ui/global_widgets/input_text.dart';
import 'package:gym/ui/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as p;

class CrearDieta extends StatefulWidget {
  const CrearDieta({super.key});

  @override
  State<CrearDieta> createState() => _CrearDieta();
}

class _CrearDieta extends State<CrearDieta> {
  File? _image;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late String usuario;
  var nombre = TextEditingController();
  var descripcion = TextEditingController();
  List<String> list = <String>[
    'Al Despertar',
    'Almuerzo',
    'Medio Día',
    'Comida',
    'Media Tarde',
    'Cena',
    'Pre-entreno',
    'Post-Entreno'
  ];
  String dia = 'Al Despertar';

  List<String> listaDietas = <String>[
    'Batido de proteína en agua con plátano',
    'Huevo con jamon en salsa roja o verde',
    'Alambre de pollo gratinado',
    'Filete de pescado en salsa de tomate roja o verde',
    'Sandwich de crema de cacahuate y nutella',
    'Mango manila',
    'Tacos de asada',
    'Pollo con Arroz',
    'Waffles Proteicos',
    'Arrachera, Arroz y Verduras',
    'Bowl de Avena',
    'Otros',
  ];
  String dietaValor = 'Bowl de Avena';
  String alertDietas = "";


  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: degradado,
            title: const Text(
              'Agregar nueva opción',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontFamily: 'NeoRegular',
                  fontWeight: FontWeight.w700),
            ),
            content: TextField(
              style: TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintStyle:  TextStyle(
                  fontSize: 16,

                  color: Colors.white,
                  fontFamily: 'NeoRegular',
                  fontWeight: FontWeight.w400),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: primary),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: primary),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  alertDietas = value;
                });
              },
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                  child: const Text('Cancelar' ,style: TextStyle(color: primary),)),
              TextButton(
                  onPressed: () {
                    if (alertDietas != "") {
                      listaDietas.add(alertDietas);
                      setState(() {
                        dietaValor = alertDietas;
                      });
                    }
                    Navigator.pop(context);
                  },
                  child: const Text('Guardar' ,style: TextStyle(color: primary),))
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    final entrenadorProvider = context.read<NutriologaProvider>();
    usuario = entrenadorProvider.user;
  }

  Future _pickimage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    File? img = File(image.path);
    setState(() {
      _image = img;
    });
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
          "Agregar Dieta",
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
            if (_image != null) {
              DateTime now = DateTime.now();
              print(nombre.text);
              print(descripcion.text);
              print(dia);
              print(entrenadorProvider.user);
              print(_image!.path);

              final firebase_storage.FirebaseStorage storage =
                  firebase_storage.FirebaseStorage.instance;
              final respuesta = await storage
                  .ref(now.hour.toString() +
                      now.day.toString() +
                      now.microsecond.toString() +
                      now.minute.toString() +
                      now.second.toString() +
                      now.month.toString() +
                      usuario)
                  .putFile(_image!);

              print(respuesta.metadata!.fullPath);
              print(respuesta.state.toString());
              final path = _image!.path;

              final extension = p.extension(path); // '.dart'
              print("path: $extension");

              if (respuesta.state.toString() == "TaskState.success") {
                final receta = Receta(
                    nombre: dietaValor,
                    descripcion: descripcion.text,
                    horario: dia,
                    imagen: now.hour.toString() +
                        now.day.toString() +
                        now.microsecond.toString() +
                        now.minute.toString() +
                        now.second.toString() +
                        now.month.toString() +
                        usuario,
                    mes: now.month.toString(),
                    year: now.year.toString(),
                    usuario: usuario);
                final personRef = FirebaseFirestore.instance
                    .collection("recetas")
                    .withConverter<Receta>(
                      fromFirestore: (snapshots, _) {
                        final person = Receta.fromJson(snapshots.data()!);
                        //final newPerson = person.copyWith(id: snapshots.id);
                        return person;
                      },
                      toFirestore: (person, _) => person.toJson(),
                    );
                final result = await personRef.add(receta);

                print(result);

                const snackBar = SnackBar(
                  content: Text(
                    "Se agrego una nueva Receta a la dieta",
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
                Navigator.pop(context);
              }
              //Navigator.pop(context);
            } else {
              const snackBar = SnackBar(
                content: Text(
                  "Debes elegir una imagen",
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
            }
          }
        },
        icon: const Icon(Icons.save),
        label: const Text(
          "Guardar Dieta",
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
                    "Nombre de la Dieta",
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
                  Container(
                    padding: EdgeInsets.only(top: 6, left: 8, right: 8),
                    width: double.infinity,
                    height: 55,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        color: degradado),
                    child: DropdownButton<String>(
                      dropdownColor: degradado,
                      value: dietaValor,
                      isExpanded: true,
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: primary,
                      ),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontFamily: 'NeoRegular',
                      ),
                      underline: const SizedBox(
                        height: 2,
                      ),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        if (value == "Otros") {
                          _displayTextInputDialog(context);
                        } else {
                          setState(() {
                            dietaValor = value!;
                          });
                        }
                      },
                      items: listaDietas.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  
                  const SizedBox(
                    height: 15.0,
                  ),
                  const Text(
                    "Descripción",
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
                    controller: descripcion,
                    lines: 5,
                    label: 'Descripción',
                    prefix: Icons.text_format,
                    type: TextInputType.multiline,
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
                    "Elige el Horario",
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
                  Container(
                    padding: EdgeInsets.only(top: 6, left: 8, right: 8),
                    width: double.infinity,
                    height: 55,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        color: degradado),
                    child: DropdownButton<String>(
                      dropdownColor: degradado,
                      value: dia,
                      isExpanded: true,
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: primary,
                      ),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontFamily: 'NeoRegular',
                      ),
                      underline: const SizedBox(
                        height: 2,
                      ),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          dia = value!;
                        });
                      },
                      items: list.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  const Text(
                    "Elige una Imagen",
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
                  GestureDetector(
                      onTap: (() async {
                        _pickimage();
                      }),
                      child: _image == null
                          ? Container(
                              width: double.infinity,
                              height: 160,
                              color: degradado,
                              child: Center(
                                child: IconButton(
                                  iconSize: 60,
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.add,
                                    color: primary,
                                  ),
                                ),
                              ),
                            )
                          : Image.file(_image!)),

                  const SizedBox(
                    height: 45.0,
                  ),
                  //Image.asset("assets/images/abdomen/Crunch con Polea .GIF")
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
