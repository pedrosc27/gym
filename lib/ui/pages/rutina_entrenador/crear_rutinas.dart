import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym/data/preferences.dart';
import 'package:gym/data/preferences_provider.dart';
import 'package:gym/domain/models/rutina.dart';
import 'package:gym/ui/pages/home/widgets/rutina_card.dart';
import 'package:gym/ui/pages/rutina_entrenador/crear_rutina_dia.dart';
import 'package:gym/ui/pages/rutina_entrenador/crear_rutina_provider.dart';
import 'package:gym/ui/pages/rutina_entrenador/widgets/rutina_card_entrenador.dart';
import 'package:gym/ui/utils/colors.dart';
import 'package:provider/provider.dart';

class CrearRutinas extends StatefulWidget {
  const CrearRutinas({super.key});

  @override
  State<CrearRutinas> createState() => CrearRutinasState();
}

class CrearRutinasState extends State<CrearRutinas> {
  late String usuario;
  late List<Dia> todosLosDias;

  @override
  void initState() {
    super.initState();
    final entrenadorProvider = context.read<RutinaEntrenadorProvider>();
    usuario = entrenadorProvider.user;
    todosLosDias = entrenadorProvider.todosLosDias;
  }

  @override
  Widget build(BuildContext context) {
    final rutinas = context.watch<RutinaEntrenadorProvider>();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          "Rutinas",
          style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'NeoMedium',
              fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
              onPressed: () {
                print("Boton verde");
                rutinas.imagen = "sin imagen";
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const CrearRutinaDia()));
              },
              icon: const Icon(
                Icons.add_circle,
                color: primary,
                size: 40,
              )),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: primary,
        onPressed: () async {
          if (rutinas.lunes.isEmpty ||
              rutinas.martes.isEmpty ||
              rutinas.miercoles.isEmpty ||
              rutinas.jueves.isEmpty ||
              rutinas.viernes.isEmpty) {
            const snackBar = SnackBar(
              content: Text(
                "Todos los días deben tener una rutina como mínimo",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontFamily: 'NeoRegular',
                    fontWeight: FontWeight.w700),
              ),
            );

            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else {
            DateTime now = DateTime.now();
            DateTime lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
            final preferencias = context.read<PreferencesProvider>();
            final emailEntrenador =LocalStorage.prefs.getString("email") ;
            final rutina = Rutina(
              usuario: rutinas.user,
              instructor: emailEntrenador!,
              mes: lastDayOfMonth.month.toString(),
              year: lastDayOfMonth.year.toString(),
              rutina: RutinaClass(
                lunes: rutinas.lunes,
                martes: rutinas.martes,
                miercoles: rutinas.miercoles,
                jueves: rutinas.jueves,
                viernes: rutinas.viernes,
              ),
            );
            final personRef = FirebaseFirestore.instance
                .collection("rutinas")
                .withConverter<Rutina>(
                  fromFirestore: (snapshots, _) {
                    final person = Rutina.fromJson(snapshots.data()!);
                    //final newPerson = person.copyWith(id: snapshots.id);
                    return person;
                  },
                  toFirestore: (person, _) => person.toJson(),
                );
            final result = await personRef.add(rutina);
            const snackBar = SnackBar(
              content: Text(
                "Rutina Creada",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontFamily: 'NeoRegular',
                    fontWeight: FontWeight.w700),
              ),
            );

            ScaffoldMessenger.of(context).showSnackBar(snackBar);

            await Future.delayed(Duration(seconds: 3));
            rutinas.reset();
            Navigator.pop(context);
          }
        },
        icon: const Icon(Icons.save),
        label: const Text(
          "Publicar Rutina",
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
        child: rutinas.todosLosDias.isEmpty
            ? const Center(
                child: Text(
                "No has agregado Rutinas",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'NeoMedium',
                    fontWeight: FontWeight.w700),
              ))
            : SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: rutinas.todosLosDias.length,
                      itemBuilder: (context, index) {
                        final rutinaDiaria = rutinas.todosLosDias[index];
                        return Dismissible(
                          key: UniqueKey(),
                          onDismissed: (DismissDirection direction) {
                            rutinas.deleteItem(index);
                                
                          },
                          secondaryBackground: Container(
                            color: Colors.red,
                            child:  const Center(
                              child: Text(
                                'Borrar',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            
                          ),
                          background: Container(),
                          direction: DismissDirection.endToStart,
                          child: RutinaCardEntrenador(
                            dia: rutinaDiaria,
                            imagen: "assets/images/${rutinaDiaria.imagen}",
                            nombre: rutinaDiaria.nombreRutina,
                            repeticiones: rutinaDiaria.repeticiones,
                            terminada: rutinaDiaria.terminada,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
