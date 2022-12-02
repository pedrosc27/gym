import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gym/domain/models/rutina.dart';
import 'package:gym/ui/global_widgets/input_text.dart';
import 'package:gym/ui/pages/rutina_entrenador/crear_rutina_provider.dart';
import 'package:gym/ui/utils/colors.dart';
import 'package:provider/provider.dart';

class CrearRutinaDia extends StatefulWidget {
  const CrearRutinaDia({super.key});

  @override
  State<CrearRutinaDia> createState() => _CrearRutinaDiaState();
}

class _CrearRutinaDiaState extends State<CrearRutinaDia> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late String usuario;
  var nombre = TextEditingController();
  var repeticiones = TextEditingController();
  var descripcion = TextEditingController();
  List<String> list = <String>[
    'Lunes',
    'Martes',
    'Miercoles',
    'Jueves',
    'Viernes'
  ];
  String dia = 'Lunes';
  List<String> listDescripcion = <String>[
    'Curl de Bíceps',
    'Curl con Barra',
    'Jalón con Polea',
    'Sentadilla Hack',
    'Sentadilla Libre',
    'Press de Pecho',
    'Press Militar',
    'Jalón de Espalda',
    'Laterales con Mancuerna',
    'Remo con Barra',
    'Otros'
  ];
  String descripcionValor = 'Curl de Bíceps';
  String alertDescripcion = "";

  List<String> listRepeticiones = <String>[
    '3X10',
    '3X12',
    '3X15',
    '4x10',
    '4X12',
    '4X15',
    'Otros'
  ];
  String repeticionesValor = '3X10';
  String alertRepeticiones= "";  

  late String imagenActual;
  @override
  void initState() {
    super.initState();
    final entrenadorProvider = context.read<RutinaEntrenadorProvider>();
    usuario = entrenadorProvider.user;
    imagenActual = entrenadorProvider.imagen;
  }

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
                  alertDescripcion = value;
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
                    if (alertDescripcion != "") {
                      listDescripcion.add(alertDescripcion);
                      setState(() {
                        descripcionValor = alertDescripcion;
                      });
                    }
                    Navigator.pop(context);
                  },
                  child: const Text('Guardar' ,style: TextStyle(color: primary),))
            ],
          );
        });
  }
  Future<void> _displayTextInputDialog2(BuildContext context) async {
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
                  alertRepeticiones = value;
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
                    if (alertDescripcion != "") {
                      listRepeticiones.add(alertRepeticiones);
                      setState(() {
                        repeticionesValor = alertRepeticiones;
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
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final entrenadorProvider = context.watch<RutinaEntrenadorProvider>();
    imagenActual = entrenadorProvider.imagen;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          "Agrega una Rutina",
          style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'NeoMedium',
              fontWeight: FontWeight.w700),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: primary,
        onPressed: () {
          if (formKey.currentState!.validate()) {
            if (imagenActual != "sin imagen") {
              final nuevoDia = Dia(
                  descripcion: descripcionValor,
                  duracion: 'duracion',
                  imagen: imagenActual,
                  nombreRutina: nombre.text,
                  repeticiones: repeticionesValor,
                  video: "video",
                  terminada: false);

              if (dia == 'Lunes') entrenadorProvider.setLunes(nuevoDia);
              if (dia == 'Martes') entrenadorProvider.setMartes(nuevoDia);
              if (dia == 'Miercoles') entrenadorProvider.setMiercoles(nuevoDia);
              if (dia == 'Jueves') entrenadorProvider.setJueves(nuevoDia);
              if (dia == 'Viernes') entrenadorProvider.setViernes(nuevoDia);

              Navigator.pop(context);
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
          "Guardar Rutina",
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
                    "Nombre de la Rutina",
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
                    controller: nombre,
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
                  Container(
                    padding: EdgeInsets.only(top: 6, left: 8, right: 8),
                    width: double.infinity,
                    height: 55,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        color: degradado),
                    child: DropdownButton<String>(
                      dropdownColor: degradado,
                      value: descripcionValor,
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
                            descripcionValor = value!;
                          });
                        }
                      },
                      items: listDescripcion
                          .map<DropdownMenuItem<String>>((String value) {
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
                    "Repeticiones",
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
                      value: repeticionesValor,
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
                          _displayTextInputDialog2(context);
                        } else {
                          setState(() {
                            repeticionesValor = value!;
                          });
                        }
                      },
                      items: listRepeticiones
                          .map<DropdownMenuItem<String>>((String value) {
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
                    "Elige el Día",
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
                      onTap: (() {
                        showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (BuildContext context) {
                              return StatefulBuilder(
                                builder: (BuildContext context,
                                    StateSetter setState) {
                                  return SingleChildScrollView(
                                    child: Container(
                                      color: Colors.black,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          const SizedBox(
                                            height: 32,
                                          ),
                                          Container(
                                            padding:
                                                const EdgeInsets.only(left: 16),
                                            child: const Text(
                                              "Abdomen",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                  fontFamily: 'NeoRegular',
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                          GridView.count(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            crossAxisCount: 3,
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 4,
                                                        color: imagenActual ==
                                                                "abdomen/Crunch con Polea .GIF"
                                                            ? primary
                                                            : Colors.black)),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      final changeImagen =
                                                          entrenadorProvider
                                                              .setImagen(
                                                                  "abdomen/Crunch con Polea .GIF");
                                                      Navigator.pop(context);
                                                    },
                                                    child: Image.asset(
                                                        "assets/images/abdomen/Crunch con Polea .GIF")),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 4,
                                                        color: imagenActual ==
                                                                "abdomen/Crunch Cruzado .GIF"
                                                            ? primary
                                                            : Colors.black)),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      final changeImagen =
                                                          entrenadorProvider
                                                              .setImagen(
                                                                  "abdomen/Crunch Cruzado .GIF");
                                                      Navigator.pop(context);
                                                    },
                                                    child: Image.asset(
                                                        "assets/images/abdomen/Crunch Cruzado .GIF")),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 4,
                                                        color: imagenActual ==
                                                                "abdomen/Crunch en Banca.GIF"
                                                            ? primary
                                                            : Colors.black)),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      final changeImagen =
                                                          entrenadorProvider
                                                              .setImagen(
                                                                  "abdomen/Crunch en Banca.GIF");
                                                      Navigator.pop(context);
                                                    },
                                                    child: Image.asset(
                                                        "assets/images/abdomen/Crunch en Banca.GIF")),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 4,
                                                        color: imagenActual ==
                                                                "abdomen/crunch-con-maquina.GIF"
                                                            ? primary
                                                            : Colors.black)),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      final changeImagen =
                                                          entrenadorProvider
                                                              .setImagen(
                                                                  "abdomen/crunch-con-maquina.GIF");
                                                      Navigator.pop(context);
                                                    },
                                                    child: Image.asset(
                                                        "assets/images/abdomen/crunch-con-maquina.GIF")),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 4,
                                                        color: imagenActual ==
                                                                "abdomen/Crunches .GIF"
                                                            ? primary
                                                            : Colors.black)),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      final changeImagen =
                                                          entrenadorProvider
                                                              .setImagen(
                                                                  "abdomen/Crunches .GIF");
                                                      Navigator.pop(context);
                                                    },
                                                    child: Image.asset(
                                                        "assets/images/abdomen/Crunches .GIF")),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 4,
                                                        color: imagenActual ==
                                                                "abdomen/Elevación Intercalada .GIF"
                                                            ? primary
                                                            : Colors.black)),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      final changeImagen =
                                                          entrenadorProvider
                                                              .setImagen(
                                                                  "abdomen/Elevación Intercalada .GIF");
                                                      Navigator.pop(context);
                                                    },
                                                    child: Image.asset(
                                                        "assets/images/abdomen/Elevación Intercalada .GIF")),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 4,
                                                        color: imagenActual ==
                                                                "abdomen/elevacion-piernas.GIF"
                                                            ? primary
                                                            : Colors.black)),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      final changeImagen =
                                                          entrenadorProvider
                                                              .setImagen(
                                                                  "abdomen/elevacion-piernas.GIF");
                                                      Navigator.pop(context);
                                                    },
                                                    child: Image.asset(
                                                        "assets/images/abdomen/elevacion-piernas.GIF")),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            padding:
                                                const EdgeInsets.only(left: 16),
                                            child: const Text(
                                              "Brazo",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                  fontFamily: 'NeoRegular',
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                          GridView.count(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            crossAxisCount: 3,
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 4,
                                                        color: imagenActual ==
                                                                "brazo/biceps/Curl Biceps Barra.GIF"
                                                            ? primary
                                                            : Colors.black)),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      final changeImagen =
                                                          entrenadorProvider
                                                              .setImagen(
                                                                  "brazo/biceps/Curl Biceps Barra.GIF");
                                                      Navigator.pop(context);
                                                    },
                                                    child: Image.asset(
                                                        "assets/images/brazo/biceps/Curl Biceps Barra.GIF")),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 4,
                                                        color: imagenActual ==
                                                                "brazo/biceps/Curl Biceps.GIF"
                                                            ? primary
                                                            : Colors.black)),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      final changeImagen =
                                                          entrenadorProvider
                                                              .setImagen(
                                                                  "brazo/biceps/Curl Biceps.GIF");
                                                      Navigator.pop(context);
                                                    },
                                                    child: Image.asset(
                                                        "assets/images/brazo/biceps/Curl Biceps.GIF")),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 4,
                                                        color: imagenActual ==
                                                                "brazo/biceps/Curl Concentrado.GIF"
                                                            ? primary
                                                            : Colors.black)),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      final changeImagen =
                                                          entrenadorProvider
                                                              .setImagen(
                                                                  "brazo/biceps/Curl Concentrado.GIF");
                                                      Navigator.pop(context);
                                                    },
                                                    child: Image.asset(
                                                        "assets/images/brazo/biceps/Curl Concentrado.GIF")),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 4,
                                                        color: imagenActual ==
                                                                "brazo/biceps/Curl Concentrado.GIF"
                                                            ? primary
                                                            : Colors.black)),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      final changeImagen =
                                                          entrenadorProvider
                                                              .setImagen(
                                                                  "brazo/biceps/Curl Concentrado.GIF");
                                                      Navigator.pop(context);
                                                    },
                                                    child: Image.asset(
                                                        "assets/images/brazo/biceps/Curl Concentrado.GIF")),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 4,
                                                        color: imagenActual ==
                                                                "brazo/biceps/Curl Inclinado.GIF"
                                                            ? primary
                                                            : Colors.black)),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      final changeImagen =
                                                          entrenadorProvider
                                                              .setImagen(
                                                                  "brazo/biceps/Curl Inclinado.GIF");
                                                      Navigator.pop(context);
                                                    },
                                                    child: Image.asset(
                                                        "assets/images/brazo/biceps/Curl Inclinado.GIF")),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 4,
                                                        color: imagenActual ==
                                                                "brazo/biceps/Curl Predicador.GIF"
                                                            ? primary
                                                            : Colors.black)),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      final changeImagen =
                                                          entrenadorProvider
                                                              .setImagen(
                                                                  "brazo/biceps/Curl Predicador.GIF");
                                                      Navigator.pop(context);
                                                    },
                                                    child: Image.asset(
                                                        "assets/images/brazo/biceps/Curl Predicador.GIF")),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 4,
                                                        color: imagenActual ==
                                                                "brazo/biceps/Martillos.GIF"
                                                            ? primary
                                                            : Colors.black)),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      final changeImagen =
                                                          entrenadorProvider
                                                              .setImagen(
                                                                  "brazo/biceps/Martillos.GIF");
                                                      Navigator.pop(context);
                                                    },
                                                    child: Image.asset(
                                                        "assets/images/brazo/biceps/Martillos.GIF")),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 4,
                                                        color: imagenActual ==
                                                                "brazo/triceps/ExtensionTriceps.GIF"
                                                            ? primary
                                                            : Colors.black)),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      final changeImagen =
                                                          entrenadorProvider
                                                              .setImagen(
                                                                  "brazo/triceps/ExtensionTriceps.GIF");
                                                      Navigator.pop(context);
                                                    },
                                                    child: Image.asset(
                                                        "assets/images/brazo/triceps/ExtensionTriceps.GIF")),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 4,
                                                        color: imagenActual ==
                                                                "brazo/triceps/Fondos Laterales.GIF"
                                                            ? primary
                                                            : Colors.black)),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      final changeImagen =
                                                          entrenadorProvider
                                                              .setImagen(
                                                                  "brazo/triceps/Fondos Laterales.GIF");
                                                      Navigator.pop(context);
                                                    },
                                                    child: Image.asset(
                                                        "assets/images/brazo/triceps/Fondos Laterales.GIF")),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 4,
                                                        color: imagenActual ==
                                                                "brazo/triceps/Parade de mula.GIF"
                                                            ? primary
                                                            : Colors.black)),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      final changeImagen =
                                                          entrenadorProvider
                                                              .setImagen(
                                                                  "brazo/triceps/Parade de mula.GIF");
                                                      Navigator.pop(context);
                                                    },
                                                    child: Image.asset(
                                                        "assets/images/brazo/triceps/Parade de mula.GIF")),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 4,
                                                        color: imagenActual ==
                                                                "brazo/triceps/Press Frances.GIF"
                                                            ? primary
                                                            : Colors.black)),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      final changeImagen =
                                                          entrenadorProvider
                                                              .setImagen(
                                                                  "brazo/triceps/Press Frances.GIF");
                                                      Navigator.pop(context);
                                                    },
                                                    child: Image.asset(
                                                        "assets/images/brazo/triceps/Press Frances.GIF")),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            padding:
                                                const EdgeInsets.only(left: 16),
                                            child: const Text(
                                              "Cardio",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                  fontFamily: 'NeoRegular',
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                          GridView.count(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            crossAxisCount: 3,
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 4,
                                                        color: imagenActual ==
                                                                "cardio/Bicicleta Estatica.GIF"
                                                            ? primary
                                                            : Colors.black)),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      final changeImagen =
                                                          entrenadorProvider
                                                              .setImagen(
                                                                  "cardio/Bicicleta Estatica.GIF");
                                                      Navigator.pop(context);
                                                    },
                                                    child: Image.asset(
                                                        "assets/images/cardio/Bicicleta Estatica.GIF")),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 4,
                                                        color: imagenActual ==
                                                                "cardio/Boxeo al Costal.GIF"
                                                            ? primary
                                                            : Colors.black)),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      final changeImagen =
                                                          entrenadorProvider
                                                              .setImagen(
                                                                  "cardio/Boxeo al Costal.GIF");
                                                      Navigator.pop(context);
                                                    },
                                                    child: Image.asset(
                                                        "assets/images/cardio/Boxeo al Costal.GIF")),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 4,
                                                        color: imagenActual ==
                                                                "cardio/Caminadora .GIF"
                                                            ? primary
                                                            : Colors.black)),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      final changeImagen =
                                                          entrenadorProvider
                                                              .setImagen(
                                                                  "cardio/Caminadora .GIF");
                                                      Navigator.pop(context);
                                                    },
                                                    child: Image.asset(
                                                        "assets/images/cardio/Caminadora .GIF")),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 4,
                                                        color: imagenActual ==
                                                                "cardio/inclinada.GIF"
                                                            ? primary
                                                            : Colors.black)),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      final changeImagen =
                                                          entrenadorProvider
                                                              .setImagen(
                                                                  "cardio/inclinada.GIF");
                                                      Navigator.pop(context);
                                                    },
                                                    child: Image.asset(
                                                        "assets/images/cardio/inclinada.GIF")),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 4,
                                                        color: imagenActual ==
                                                                "cardio/Correr.GIF"
                                                            ? primary
                                                            : Colors.black)),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      final changeImagen =
                                                          entrenadorProvider
                                                              .setImagen(
                                                                  "cardio/cardio/Correr.GIF");
                                                      Navigator.pop(context);
                                                    },
                                                    child: Image.asset(
                                                        "assets/images/cardio/Correr.GIF")),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 4,
                                                        color: imagenActual ==
                                                                "cardio/Levantamiento de Piernas.GIF"
                                                            ? primary
                                                            : Colors.black)),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      final changeImagen =
                                                          entrenadorProvider
                                                              .setImagen(
                                                                  "cardio/cardio/Levantamiento de Piernas.GIF");
                                                      Navigator.pop(context);
                                                    },
                                                    child: Image.asset(
                                                        "assets/images/cardio/Levantamiento de Piernas.GIF")),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 4,
                                                        color: imagenActual ==
                                                                "cardio/Maquina Eliptica.GIF"
                                                            ? primary
                                                            : Colors.black)),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      final changeImagen =
                                                          entrenadorProvider
                                                              .setImagen(
                                                                  "cardio/cardio/Maquina Eliptica.GIF");
                                                      Navigator.pop(context);
                                                    },
                                                    child: Image.asset(
                                                        "assets/images/cardio/Maquina Eliptica.GIF")),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 4,
                                                        color: imagenActual ==
                                                                "cardio/Maquina Escaladora.GIF"
                                                            ? primary
                                                            : Colors.black)),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      final changeImagen =
                                                          entrenadorProvider
                                                              .setImagen(
                                                                  "cardio/cardio/Maquina Escaladora.GIF");
                                                      Navigator.pop(context);
                                                    },
                                                    child: Image.asset(
                                                        "assets/images/cardio/Maquina Escaladora.GIF")),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 4,
                                                        color: imagenActual ==
                                                                "cardio/Pateo al Costal.GIF"
                                                            ? primary
                                                            : Colors.black)),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      final changeImagen =
                                                          entrenadorProvider
                                                              .setImagen(
                                                                  "cardio/cardio/Pateo al Costal.GIF");
                                                      Navigator.pop(context);
                                                    },
                                                    child: Image.asset(
                                                        "assets/images/cardio/Pateo al Costal.GIF")),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 4,
                                                        color: imagenActual ==
                                                                "cardio/Sentadilla Splits.GIF"
                                                            ? primary
                                                            : Colors.black)),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      final changeImagen =
                                                          entrenadorProvider
                                                              .setImagen(
                                                                  "cardio/cardio/Sentadilla Splits.GIF");
                                                      Navigator.pop(context);
                                                    },
                                                    child: Image.asset(
                                                        "assets/images/cardio/Sentadilla Splits.GIF")),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 4,
                                                        color: imagenActual ==
                                                                "cardio/Splits.GIF"
                                                            ? primary
                                                            : Colors.black)),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      final changeImagen =
                                                          entrenadorProvider
                                                              .setImagen(
                                                                  "cardio/cardio/Splits.GIF");
                                                      Navigator.pop(context);
                                                    },
                                                    child: Image.asset(
                                                        "assets/images/cardio/Splits.GIF")),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            padding:
                                                const EdgeInsets.only(left: 16),
                                            child: const Text(
                                              "Espalda",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                  fontFamily: 'NeoRegular',
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                          GridView.count(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            crossAxisCount: 3,
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 4,
                                                        color: imagenActual ==
                                                                "espalda/espalda/Dominada en Barra.GIF"
                                                            ? primary
                                                            : Colors.black)),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      final changeImagen =
                                                          entrenadorProvider
                                                              .setImagen(
                                                                  "espalda/espalda/Dominada en Barra.GIF");
                                                      Navigator.pop(context);
                                                    },
                                                    child: Image.asset(
                                                        "assets/images/espalda/espalda/Dominada en Barra.GIF")),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 4,
                                                        color: imagenActual ==
                                                                "espalda/espalda/Jalon a Pecho Frontal.GIF"
                                                            ? primary
                                                            : Colors.black)),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      final changeImagen =
                                                          entrenadorProvider
                                                              .setImagen(
                                                                  "espalda/espalda/Jalon a Pecho Frontal.GIF");
                                                      Navigator.pop(context);
                                                    },
                                                    child: Image.asset(
                                                        "assets/images/espalda/espalda/Jalon a Pecho Frontal.GIF")),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 4,
                                                        color: imagenActual ==
                                                                "espalda/espalda/Jalon con Maquina.GIF"
                                                            ? primary
                                                            : Colors.black)),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      final changeImagen =
                                                          entrenadorProvider
                                                              .setImagen(
                                                                  "espalda/espalda/Jalon con Maquina.GIF");
                                                      Navigator.pop(context);
                                                    },
                                                    child: Image.asset(
                                                        "assets/images/espalda/espalda/Jalon con Maquina.GIF")),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 4,
                                                        color: imagenActual ==
                                                                "espalda/espalda/Jalon Transnuca.GIF"
                                                            ? primary
                                                            : Colors.black)),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      final changeImagen =
                                                          entrenadorProvider
                                                              .setImagen(
                                                                  "espalda/espalda/Jalon Transnuca.GIF");
                                                      Navigator.pop(context);
                                                    },
                                                    child: Image.asset(
                                                        "assets/images/espalda/espalda/Jalon Transnuca.GIF")),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 4,
                                                        color: imagenActual ==
                                                                "espalda/espalda/Pull Over Polea.GIF"
                                                            ? primary
                                                            : Colors.black)),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      final changeImagen =
                                                          entrenadorProvider
                                                              .setImagen(
                                                                  "espalda/espalda/Pull Over Polea.GIF");
                                                      Navigator.pop(context);
                                                    },
                                                    child: Image.asset(
                                                        "assets/images/espalda/espalda/Pull Over Polea.GIF")),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 4,
                                                        color: imagenActual ==
                                                                "espalda/espalda/Remo con Barra.GIF"
                                                            ? primary
                                                            : Colors.black)),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      final changeImagen =
                                                          entrenadorProvider
                                                              .setImagen(
                                                                  "espalda/espalda/Remo con Barra.GIF");
                                                      Navigator.pop(context);
                                                    },
                                                    child: Image.asset(
                                                        "assets/images/espalda/espalda/Remo con Barra.GIF")),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 4,
                                                        color: imagenActual ==
                                                                "espalda/espalda/Remo con Maquina.GIF"
                                                            ? primary
                                                            : Colors.black)),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      final changeImagen =
                                                          entrenadorProvider
                                                              .setImagen(
                                                                  "espalda/espalda/Remo con Maquina.GIF");
                                                      Navigator.pop(context);
                                                    },
                                                    child: Image.asset(
                                                        "assets/images/espalda/espalda/Remo con Maquina.GIF")),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 4,
                                                        color: imagenActual ==
                                                                "espalda/espalda/Remo con Maquina.GIF"
                                                            ? primary
                                                            : Colors.black)),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      final changeImagen =
                                                          entrenadorProvider
                                                              .setImagen(
                                                                  "espalda/espalda/Remo con Maquina.GIF");
                                                      Navigator.pop(context);
                                                    },
                                                    child: Image.asset(
                                                        "assets/images/espalda/espalda/Remo con Maquina.GIF")),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 4,
                                                        color: imagenActual ==
                                                                "espalda/espalda/Remo con Polea.GIF"
                                                            ? primary
                                                            : Colors.black)),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      final changeImagen =
                                                          entrenadorProvider
                                                              .setImagen(
                                                                  "espalda/espalda/Remo con Polea.GIF");
                                                      Navigator.pop(context);
                                                    },
                                                    child: Image.asset(
                                                        "assets/images/espalda/espalda/Remo con Polea.GIF")),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 4,
                                                        color: imagenActual ==
                                                                "espalda/trapecio/45 Grados.GIF"
                                                            ? primary
                                                            : Colors.black)),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      final changeImagen =
                                                          entrenadorProvider
                                                              .setImagen(
                                                                  "espalda/trapecio/45 Grados.GIF");
                                                      Navigator.pop(context);
                                                    },
                                                    child: Image.asset(
                                                        "assets/images/espalda/trapecio/45 Grados.GIF")),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 4,
                                                        color: imagenActual ==
                                                                "espalda/trapecio/Encogimiento de Hombros.GIF"
                                                            ? primary
                                                            : Colors.black)),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      final changeImagen =
                                                          entrenadorProvider
                                                              .setImagen(
                                                                  "espalda/trapecio/Encogimiento de Hombros.GIF");
                                                      Navigator.pop(context);
                                                    },
                                                    child: Image.asset(
                                                        "assets/images/espalda/trapecio/Encogimiento de Hombros.GIF")),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 4,
                                                        color: imagenActual ==
                                                                "espalda/trapecio/Encogimiento Hombros con Barra.GIF"
                                                            ? primary
                                                            : Colors.black)),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      final changeImagen =
                                                          entrenadorProvider
                                                              .setImagen(
                                                                  "espalda/trapecio/Encogimiento Hombros con Barra.GIF");
                                                      Navigator.pop(context);
                                                    },
                                                    child: Image.asset(
                                                        "assets/images/espalda/trapecio/Encogimiento Hombros con Barra.GIF")),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 4,
                                                        color: imagenActual ==
                                                                "espalda/trapecio/Encogimiento Hombros Inclinado.GIF"
                                                            ? primary
                                                            : Colors.black)),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      final changeImagen =
                                                          entrenadorProvider
                                                              .setImagen(
                                                                  "espalda/trapecio/Encogimiento Hombros Inclinado.GIF");
                                                      Navigator.pop(context);
                                                    },
                                                    child: Image.asset(
                                                        "assets/images/espalda/trapecio/Encogimiento Hombros Inclinado.GIF")),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 4,
                                                        color: imagenActual ==
                                                                "espalda/trapecio/Remo al Menton con Z.GIF"
                                                            ? primary
                                                            : Colors.black)),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      final changeImagen =
                                                          entrenadorProvider
                                                              .setImagen(
                                                                  "espalda/trapecio/Remo al Menton con Z.GIF");
                                                      Navigator.pop(context);
                                                    },
                                                    child: Image.asset(
                                                        "assets/images/espalda/trapecio/Remo al Menton con Z.GIF")),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            padding:
                                                const EdgeInsets.only(left: 16),
                                            child: const Text(
                                              "Pecho",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                  fontFamily: 'NeoRegular',
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                          GridView.count(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            crossAxisCount: 3,
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 4,
                                                        color: imagenActual ==
                                                                "pecho/Fondos.GIF"
                                                            ? primary
                                                            : Colors.black)),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      final changeImagen =
                                                          entrenadorProvider
                                                              .setImagen(
                                                                  "pecho/Fondos.GIF");
                                                      Navigator.pop(context);
                                                    },
                                                    child: Image.asset(
                                                        "assets/images/pecho/Fondos.GIF")),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 4,
                                                        color: imagenActual ==
                                                                "pecho/Peck Fly.GIF"
                                                            ? primary
                                                            : Colors.black)),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      final changeImagen =
                                                          entrenadorProvider
                                                              .setImagen(
                                                                  "pecho/Peck Fly.GIF");
                                                      Navigator.pop(context);
                                                    },
                                                    child: Image.asset(
                                                        "assets/images/pecho/Peck Fly.GIF")),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 4,
                                                        color: imagenActual ==
                                                                "pecho/Press Declinado con Mancuernas.GIF"
                                                            ? primary
                                                            : Colors.black)),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      final changeImagen =
                                                          entrenadorProvider
                                                              .setImagen(
                                                                  "pecho/Press Declinado con Mancuernas.GIF");
                                                      Navigator.pop(context);
                                                    },
                                                    child: Image.asset(
                                                        "assets/images/pecho/Press Declinado con Mancuernas.GIF")),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 4,
                                                        color: imagenActual ==
                                                                "pecho/Press Inclinado con Barra.GIF"
                                                            ? primary
                                                            : Colors.black)),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      final changeImagen =
                                                          entrenadorProvider
                                                              .setImagen(
                                                                  "pecho/Press Inclinado con Barra.GIF");
                                                      Navigator.pop(context);
                                                    },
                                                    child: Image.asset(
                                                        "assets/images/pecho/Press Inclinado con Barra.GIF")),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 4,
                                                        color: imagenActual ==
                                                                "pecho/Press Inclinado con Mancuernas.GIF"
                                                            ? primary
                                                            : Colors.black)),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      final changeImagen =
                                                          entrenadorProvider
                                                              .setImagen(
                                                                  "pecho/Press Inclinado con Mancuernas.GIF");
                                                      Navigator.pop(context);
                                                    },
                                                    child: Image.asset(
                                                        "assets/images/pecho/Press Inclinado con Mancuernas.GIF")),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 4,
                                                        color: imagenActual ==
                                                                "pecho/Press Plano con Barra.GIF"
                                                            ? primary
                                                            : Colors.black)),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      final changeImagen =
                                                          entrenadorProvider
                                                              .setImagen(
                                                                  "pecho/Press Plano con Barra.GIF");
                                                      Navigator.pop(context);
                                                    },
                                                    child: Image.asset(
                                                        "assets/images/pecho/Press Plano con Barra.GIF")),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 4,
                                                        color: imagenActual ==
                                                                "pecho/Press Plano con Mancuernas.GIF.GIF"
                                                            ? primary
                                                            : Colors.black)),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      final changeImagen =
                                                          entrenadorProvider
                                                              .setImagen(
                                                                  "pecho/Press Plano con Mancuernas.GIF.GIF");
                                                      Navigator.pop(context);
                                                    },
                                                    child: Image.asset(
                                                        "assets/images/pecho/Press Plano con Mancuernas.GIF.GIF")),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            padding:
                                                const EdgeInsets.only(left: 16),
                                            child: const Text(
                                              "Pierna",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                  fontFamily: 'NeoRegular',
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                          GridView.count(
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              scrollDirection: Axis.vertical,
                                              shrinkWrap: true,
                                              crossAxisCount: 3,
                                              children: [
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 4,
                                                          color: imagenActual ==
                                                                  "pierna/cuadriceps/Extension de Piernas.GIF"
                                                              ? primary
                                                              : Colors.black)),
                                                  child: GestureDetector(
                                                      onTap: () {
                                                        final changeImagen =
                                                            entrenadorProvider
                                                                .setImagen(
                                                                    "pierna/cuadriceps/Extension de Piernas.GIF");
                                                        Navigator.pop(context);
                                                      },
                                                      child: Image.asset(
                                                          "assets/images/pierna/cuadriceps/Extension de Piernas.GIF")),
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 4,
                                                          color: imagenActual ==
                                                                  "pierna/cuadriceps/Peso Muerto Bulgaro.GIF"
                                                              ? primary
                                                              : Colors.black)),
                                                  child: GestureDetector(
                                                      onTap: () {
                                                        final changeImagen =
                                                            entrenadorProvider
                                                                .setImagen(
                                                                    "pierna/cuadriceps/Peso Muerto Bulgaro.GIF");
                                                        Navigator.pop(context);
                                                      },
                                                      child: Image.asset(
                                                          "assets/images/pierna/cuadriceps/Peso Muerto Bulgaro.GIF")),
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 4,
                                                          color: imagenActual ==
                                                                  "pierna/cuadriceps/Press de Piernas.GIF"
                                                              ? primary
                                                              : Colors.black)),
                                                  child: GestureDetector(
                                                      onTap: () {
                                                        final changeImagen =
                                                            entrenadorProvider
                                                                .setImagen(
                                                                    "pierna/cuadriceps/Press de Piernas.GIF");
                                                        Navigator.pop(context);
                                                      },
                                                      child: Image.asset(
                                                          "assets/images/pierna/cuadriceps/Press de Piernas.GIF")),
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 4,
                                                          color: imagenActual ==
                                                                  "pierna/cuadriceps/Sentadilla Bulgara.GIF"
                                                              ? primary
                                                              : Colors.black)),
                                                  child: GestureDetector(
                                                      onTap: () {
                                                        final changeImagen =
                                                            entrenadorProvider
                                                                .setImagen(
                                                                    "pierna/cuadriceps/Sentadilla Bulgara.GIF");
                                                        Navigator.pop(context);
                                                      },
                                                      child: Image.asset(
                                                          "assets/images/pierna/cuadriceps/Sentadilla Bulgara.GIF")),
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 4,
                                                          color: imagenActual ==
                                                                  "pierna/cuadriceps/Sentadilla Hack.GIF"
                                                              ? primary
                                                              : Colors.black)),
                                                  child: GestureDetector(
                                                      onTap: () {
                                                        final changeImagen =
                                                            entrenadorProvider
                                                                .setImagen(
                                                                    "pierna/cuadriceps/Sentadilla Hack.GIF");
                                                        Navigator.pop(context);
                                                      },
                                                      child: Image.asset(
                                                          "assets/images/pierna/cuadriceps/Sentadilla Hack.GIF")),
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 4,
                                                          color: imagenActual ==
                                                                  "pierna/cuadriceps/Sentadilla Libre.GIF"
                                                              ? primary
                                                              : Colors.black)),
                                                  child: GestureDetector(
                                                      onTap: () {
                                                        final changeImagen =
                                                            entrenadorProvider
                                                                .setImagen(
                                                                    "pierna/cuadriceps/Sentadilla Libre.GIF");
                                                        Navigator.pop(context);
                                                      },
                                                      child: Image.asset(
                                                          "assets/images/pierna/cuadriceps/Sentadilla Libre.GIF")),
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 4,
                                                          color: imagenActual ==
                                                                  "pierna/femoral/Aductor.GIF"
                                                              ? primary
                                                              : Colors.black)),
                                                  child: GestureDetector(
                                                      onTap: () {
                                                        final changeImagen =
                                                            entrenadorProvider
                                                                .setImagen(
                                                                    "pierna/femoral/Aductor.GIF");
                                                        Navigator.pop(context);
                                                      },
                                                      child: Image.asset(
                                                          "assets/images/pierna/femoral/Aductor.GIF")),
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 4,
                                                          color: imagenActual ==
                                                                  "pierna/femoral/Curl Femoral Recostado.GIF"
                                                              ? primary
                                                              : Colors.black)),
                                                  child: GestureDetector(
                                                      onTap: () {
                                                        final changeImagen =
                                                            entrenadorProvider
                                                                .setImagen(
                                                                    "pierna/femoral/Curl Femoral Recostado.GIF");
                                                        Navigator.pop(context);
                                                      },
                                                      child: Image.asset(
                                                          "assets/images/pierna/femoral/Curl Femoral Recostado.GIF")),
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 4,
                                                          color: imagenActual ==
                                                                  "pierna/femoral/Curl Femoral Sentado.GIF"
                                                              ? primary
                                                              : Colors.black)),
                                                  child: GestureDetector(
                                                      onTap: () {
                                                        final changeImagen =
                                                            entrenadorProvider
                                                                .setImagen(
                                                                    "pierna/femoral/Curl Femoral Sentado.GIF");
                                                        Navigator.pop(context);
                                                      },
                                                      child: Image.asset(
                                                          "assets/images/pierna/femoral/Curl Femoral Sentado.GIF")),
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 4,
                                                          color: imagenActual ==
                                                                  "pierna/femoral/Peso Muerto.GIF"
                                                              ? primary
                                                              : Colors.black)),
                                                  child: GestureDetector(
                                                      onTap: () {
                                                        final changeImagen =
                                                            entrenadorProvider
                                                                .setImagen(
                                                                    "pierna/femoral/Peso Muerto.GIF");
                                                        Navigator.pop(context);
                                                      },
                                                      child: Image.asset(
                                                          "assets/images/pierna/femoral/Peso Muerto.GIF")),
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 4,
                                                          color: imagenActual ==
                                                                  "pierna/femoral/Sentadilla Sumo.GIF"
                                                              ? primary
                                                              : Colors.black)),
                                                  child: GestureDetector(
                                                      onTap: () {
                                                        final changeImagen =
                                                            entrenadorProvider
                                                                .setImagen(
                                                                    "pierna/femoral/Sentadilla Sumo.GIF");
                                                        Navigator.pop(context);
                                                      },
                                                      child: Image.asset(
                                                          "assets/images/pierna/femoral/Sentadilla Sumo.GIF")),
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 4,
                                                          color: imagenActual ==
                                                                  "pierna/pantorrillas/Elevacion Pantorrilla con Mancuernas.GIF"
                                                              ? primary
                                                              : Colors.black)),
                                                  child: GestureDetector(
                                                      onTap: () {
                                                        final changeImagen =
                                                            entrenadorProvider
                                                                .setImagen(
                                                                    "pierna/pantorrillas/Elevacion Pantorrilla con Mancuernas.GIF");
                                                        Navigator.pop(context);
                                                      },
                                                      child: Image.asset(
                                                          "assets/images/pierna/pantorrillas/Elevacion Pantorrilla con Mancuernas.GIF")),
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 4,
                                                          color: imagenActual ==
                                                                  "pierna/pantorrillas/Elevacion Pantorrilla Press.GIF"
                                                              ? primary
                                                              : Colors.black)),
                                                  child: GestureDetector(
                                                      onTap: () {
                                                        final changeImagen =
                                                            entrenadorProvider
                                                                .setImagen(
                                                                    "pierna/pantorrillas/Elevacion Pantorrilla Press.GIF");
                                                        Navigator.pop(context);
                                                      },
                                                      child: Image.asset(
                                                          "assets/images/pierna/pantorrillas/Elevacion Pantorrilla Press.GIF")),
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 4,
                                                          color: imagenActual ==
                                                                  "pierna/pantorrillas/Sentadilla Pantorrilla Concentrada.GIF"
                                                              ? primary
                                                              : Colors.black)),
                                                  child: GestureDetector(
                                                      onTap: () {
                                                        final changeImagen =
                                                            entrenadorProvider
                                                                .setImagen(
                                                                    "pierna/pantorrillas/Sentadilla Pantorrilla Concentrada.GIF");
                                                        Navigator.pop(context);
                                                      },
                                                      child: Image.asset(
                                                          "assets/images/pierna/pantorrillas/Sentadilla Pantorrilla Concentrada.GIF")),
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 4,
                                                          color: imagenActual ==
                                                                  "pierna/pantorrillas/Tejedora.GIF"
                                                              ? primary
                                                              : Colors.black)),
                                                  child: GestureDetector(
                                                      onTap: () {
                                                        final changeImagen =
                                                            entrenadorProvider
                                                                .setImagen(
                                                                    "pierna/pantorrillas/Tejedora.GIF");
                                                        Navigator.pop(context);
                                                      },
                                                      child: Image.asset(
                                                          "assets/images/pierna/pantorrillas/Tejedora.GIF")),
                                                ),
                                              ]),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            });
                      }),
                      child: imagenActual == 'sin imagen'
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
                          : Image.asset("assets/images/$imagenActual")),
                  const SizedBox(
                    height: 15.0,
                  ),
                  //Image.asset("assets/images/abdomen/Crunch con Polea .GIF")
                  const SizedBox(
                    height: 85.0,
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
