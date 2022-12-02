import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym/data/preferences.dart';
import 'package:gym/data/preferences_provider.dart';
import 'package:gym/domain/models/rutina.dart';
import 'package:gym/ui/pages/entrenador/entrenador_rutinas_activas_provider.dart';
import 'package:gym/ui/pages/home/widgets/rutina_card.dart';
import 'package:gym/ui/pages/rutina_entrenador/crear_rutina_dia.dart';
import 'package:gym/ui/pages/rutina_entrenador/crear_rutina_provider.dart';
import 'package:gym/ui/pages/rutina_entrenador/widgets/rutina_card_entrenador.dart';
import 'package:gym/ui/utils/colors.dart';
import 'package:provider/provider.dart';

class EntrenadorRutinaActivaPage extends StatefulWidget {
  const EntrenadorRutinaActivaPage({super.key});

  @override
  State<EntrenadorRutinaActivaPage> createState() =>
      _EntrenadorRutinaActivaPage();
}

class _EntrenadorRutinaActivaPage extends State<EntrenadorRutinaActivaPage> {
  late String usuario;
  late List<Dia> todosLosDias;
  late Rutina rutina;

  @override
  void initState() {
    super.initState();
    getRtuinasActivas();
  }

  Future<void> getRtuinasActivas() async {
    final entrenadorProvider = context.read<EntrenadorRutinaActivaProvider>();
    final rutinaLen = entrenadorProvider.getRecetasUsuarioStream();
  }

  @override
  Widget build(BuildContext context) {
    final rutinas = context.watch<EntrenadorRutinaActivaProvider>();
    final rutinasActivas = rutinas.rutina;
    if (rutinasActivas.isNotEmpty) {
      final rutinaDia = rutinasActivas[0].rutina;
       todosLosDias = [
        ...rutinaDia.lunes,
        ...rutinaDia.martes,
        ...rutinaDia.miercoles,
        ...rutinaDia.jueves,
        ...rutinaDia.viernes
      ];
    }else{
       todosLosDias = [];
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          "Rutina Activa ",
          style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'NeoMedium',
              fontWeight: FontWeight.w700),
        ),
      ),
      body: SafeArea(
        child: rutinasActivas.isEmpty
            ? const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Center(
                    child: Text(
                  "Este Usuario no tiene una rutina activa",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'NeoMedium',
                      fontWeight: FontWeight.w700),
                )),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: todosLosDias.length,
                      itemBuilder: (context, index) {
                        final rutinaDiaria = todosLosDias[index];
                        return Dismissible(
                          key: UniqueKey(),
                          onDismissed: (DismissDirection direction) {
                            //rutinas.deleteItem(index);
                          },
                          secondaryBackground: Container(
                            color: Colors.red,
                            child: const Center(
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
