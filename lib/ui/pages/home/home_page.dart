import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym/domain/models/datos_usuario.dart';
import 'package:gym/domain/models/nutriologa_datos.dart';
import 'package:gym/domain/models/rutina_index.dart';
import 'package:gym/ui/pages/home/widgets/rutina_card.dart';
import 'package:gym/ui/utils/colors.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:gym/domain/models/rutina.dart';
import 'package:gym/domain/repository/users_repository.dart';
import 'package:gym/ui/pages/home/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage._();

  static Widget init() => ChangeNotifierProvider(
        lazy: false,
        create: (context) => HomeProvider(
          personRepository: context.read<UserRepository>(),
        )..load,
        child: const HomePage._(),
      );

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  List<DatosUsuario> datosUsuarioFuture = [];
  List<NutriologaDatosModel> datosUsuarioNutriologoFuture = [];
  
  @override
  void initState() {
    super.initState();

    datosUsuario();
    datosRecordUsuario();
  }

  Future<List<DatosUsuario>>? datosUsuario() async {
    final SharedPreferences prefs = LocalStorage.prefs;
    final email = prefs.getString("email") ?? "";
    final personRef = FirebaseFirestore.instance
        .collection('datos')
        .withConverter<DatosUsuario>(
          fromFirestore: (snapshots, _) {
            final person = DatosUsuario.fromJson(snapshots.data()!);
            //final newPerson = person.copyWith(id: snapshots.id);
            return person;
          },
          toFirestore: (person, _) => person.toJson(),
        );
    final querySnapshot =
        await personRef.where('email', isEqualTo: email).get();
    final persons = querySnapshot.docs.map((e) => e.data()).toList();
    datosUsuarioFuture =persons;
    print('datosUsuarioFuture :  ${datosUsuarioFuture!.length}');
    return persons;
  }

 Future<List<NutriologaDatosModel>>? datosRecordUsuario() async {
    final SharedPreferences prefs = LocalStorage.prefs;
    final email = prefs.getString("email") ?? "";

    final personRef = FirebaseFirestore.instance
        .collection('datosnutriologa')
        .withConverter<NutriologaDatosModel>(
          fromFirestore: (snapshots, _) {
            final person = NutriologaDatosModel.fromJson(snapshots.data()!);
            //final newPerson = person.copyWith(id: snapshots.id);
            return person;
          },
          toFirestore: (person, _) => person.toJson(),
        );

    final querySnapshot =
        await personRef.where('usuario', isEqualTo: email).orderBy('timestamp', descending: true).get();
    final persons = querySnapshot.docs.map((e) => e.data()).toList();
    datosUsuarioNutriologoFuture = persons;
    print('datosUsuarioNutriologoFuture :  ${datosUsuarioNutriologoFuture!.length}');
    return persons;
  }


  @override
  Widget build(BuildContext context) {
    final MediaQueryData data = MediaQuery.of(context);
    final Size size = data.size;
    final _width = size.width;
    final SharedPreferences prefs = LocalStorage.prefs;
    final nombre = prefs.getString("nombre") ?? "";
    return Scaffold(
      backgroundColor: Colors.black,
      body: StreamBuilder<List<Rutina>>(
          stream: context.read<HomeProvider>().load(),
          builder: (context, snapshot) {
            DateTime date = DateTime.now();
            if (!snapshot.hasData ||
                snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final data = snapshot.data!;
            if (data.isEmpty) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/pregunta.png"),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Aun no tienes rutinas ni dietas",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: 'NeoRegular',
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              );
            }
            var fecha = DateTime.now();
            var dia = DateFormat('EEEE').format(date);
            print("AQUI VA EL ID DEL DOCUMENTO : ${data[0].id}");
            print("tamaño dia: ${data.length}");
            late List<Dia> rutinaDia;
            late List<RutinaIndex> rutinaIndexDia;
            List<RutinaIndex> rutinaIndexDia2 = [];
            print(dia);
            late int verdecito;
            if (dia == "Monday") {
              rutinaDia = data[0].rutina.lunes;
              verdecito = 12;
            }
            if (dia == "Tuesday") {
              rutinaDia = data[0].rutina.martes;
              verdecito = 24;
            }
            if (dia == "Wednesday") {
              rutinaDia = data[0].rutina.miercoles;
              verdecito = 36;
            }
            if (dia == "Thursday") {
              rutinaDia = data[0].rutina.jueves;
              verdecito = 48;
            }
            if (dia == "Friday") {
              rutinaDia = data[0].rutina.viernes;
              verdecito = 60;
            }

            rutinaIndexDia = [];
            rutinaIndexDia2 = [];

            for (var i = 0; i < data.length; i++) {
              for (var j = 0; j < data[i].rutina.viernes.length; j++) {
                print("i: $i j: $j : ${data[i].rutina.viernes.length}");
                print(data[i].rutina.viernes[j].nombreRutina);
                final lista = RutinaIndex(
                    rutina: data[i],
                    dia: data[i].rutina.viernes[j],
                    index: j);
                rutinaIndexDia2.add(lista);
              }
            }
            rutinaIndexDia = rutinaIndexDia2;

            print("rutinaIndex: ${rutinaIndexDia.length}");
            verdecito = 60;
            final cantidad = rutinaIndexDia.length;
            final terminadas =
                rutinaIndexDia.where((rutina) => rutina.dia!.terminada == true);
            final porcentaje = terminadas.length / rutinaIndexDia.length;

            double estatura =  150;
            double peso1 = 70;
            if(datosUsuarioFuture.isEmpty){
              estatura = 160;
            }else{
              estatura = double.parse(datosUsuarioFuture[0].estatura);
               peso1 =  double.parse(datosUsuarioFuture[0].peso) ;
              if (estatura < 2) {
                estatura = estatura * 100;
              }
            }
            final estatura1 = estatura/100;
            
            final masa1 = ((peso1) / (estatura1*estatura1));
             double peso2 = peso1;
             double masa2 = masa1;
            print("masa1: $masa1");
            if (datosUsuarioNutriologoFuture.isNotEmpty) {
               
              peso2= double.parse(datosUsuarioNutriologoFuture[0].peso);
              print("peso2: $peso2");
             masa2 =  ((peso2) / (estatura1*estatura1));
              print("masa2: $masa2");
            }

            final porcentajeMasa = masa2/masa1;
            print("porcentajeMasa: $porcentajeMasa");

            final cantidadPorcentaje = ((porcentajeMasa -1) * 100).round();
             print("cantidadPorcentaje: $cantidadPorcentaje");
              String simbolo = '+';

             if (cantidadPorcentaje < 0) {
               simbolo = '';
             }

            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Bienvenido ${datosUsuarioFuture[0].nombre}",
                          style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontFamily: 'NeoMedium',
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: _width * 0.4,
                            height: _width * 0.4,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              color: degradado,
                            ),
                            child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularPercentIndicator(
                                  radius: _width * 0.1,
                                  lineWidth: 5.0,
                                  animation: true,
                                  percent: porcentaje,
                                  center: Text(
                                      "${terminadas.length}/${cantidad}",
                                      style: const TextStyle(
                                          fontSize: 22,
                                          color: Colors.white,
                                          fontFamily: 'NeoMedium',
                                          fontWeight: FontWeight.w700)),
                                  circularStrokeCap: CircularStrokeCap.round,
                                  progressColor: primary,
                                ),
                                const SizedBox(height: 8,),
                                const Text(
                                  "Rutinas",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontFamily: 'NeoMedium',
                                      fontWeight: FontWeight.w700),
                                )
                              ],
                            ),
                          ),
                          Container(
                              width: _width * 0.4,
                              height: _width * 0.4,
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                color: degradado,
                              ),
                              child: 
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(top: 12),
                                   height: _width * 0.2,
                                    child:  Center(
                                      child: Text("$simbolo ${cantidadPorcentaje} %",
                                          style: const TextStyle(
                                              color: primary,
                                              fontSize: 40,
                                              fontFamily: 'NeoMedium',
                                              fontWeight: FontWeight.w700)),
                                    ),
                                  ),
                                  const SizedBox(height: 8,),
                                  const Text(
                                    "Masa Muscular",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontFamily: 'NeoMedium',
                                        fontWeight: FontWeight.w700),
                                  )
                                ],
                              ))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      width: _width - 32,
                      height: _width * 0.16,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft, //Starting point
                          end: Alignment.centerRight, //Ending point
                          stops: [verdecito / 70, 0],
                          colors: const [Colors.green, degradado],
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: _width * 0.2,
                            width: (_width - 32) / 5,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: verdecito == 12
                                    ? primary
                                    : Colors.transparent),
                            child: const Align(
                              child: Text(
                                "Lun",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontFamily: 'NeoRegular',
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                          Container(
                            height: _width * 0.2,
                            width: (_width - 32) / 5,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: verdecito == 24
                                      ? primary
                                      : Colors.transparent),
                              child: const Align(
                                child: Text(
                                  "Mar",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontFamily: 'NeoRegular',
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: _width * 0.2,
                            width: (_width - 32) / 5,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: verdecito == 36
                                    ? primary
                                    : Colors.transparent),
                            child: const Align(
                              child: Text(
                                "Mie",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontFamily: 'NeoRegular',
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                          Container(
                            height: _width * 0.2,
                            width: (_width - 32) / 5,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: verdecito == 48
                                    ? primary
                                    : Colors.transparent),
                            child: const Align(
                              child: Text(
                                "Jue",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontFamily: 'NeoRegular',
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                          Container(
                            height: _width * 0.2,
                            width: (_width - 32) / 5,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: verdecito == 60
                                    ? primary
                                    : Colors.transparent),
                            child: const Align(
                              child: Text(
                                "Vie",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontFamily: 'NeoRegular',
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Rutina Diaria",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontFamily: 'NeoMedium',
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    
                    const SizedBox(
                      height: 32,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
