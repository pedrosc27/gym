import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:gym/domain/models/rutina.dart';
import 'package:gym/ui/pages/rutina/rutina_page.dart';
import 'package:gym/ui/utils/colors.dart';

class RutinaCard extends StatefulWidget {
  final Dia dia;
  final String imagen;
  final String nombre;
  final String repeticiones;
  final bool terminada;
  final Rutina rutina;
  final String diaString;
  final int index;

  const RutinaCard(
      {super.key,
      required this.dia,
      required this.imagen,
      required this.nombre,
      required this.repeticiones,
      required this.terminada,
      required this.rutina,
      required this.diaString,
      required this.index});

  @override
  State<RutinaCard> createState() => _RutinaCardState();
}

class _RutinaCardState extends State<RutinaCard> {
  late bool isChecked;
  @override
  void initState() {
    super.initState();
    isChecked = widget.terminada;
  }

  void _onVisibleChanged() {
    setState(() {
      isChecked = !isChecked;
    });
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData data = MediaQuery.of(context);
    final Size size = data.size;
    final _width = size.width;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => RutinaPage(
                  dia: widget.dia,
                  imagen: widget.imagen,
                )));
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                      image: DecorationImage(
                          image: AssetImage("assets/images/${widget.imagen}"),
                          fit: BoxFit.cover)),
                  width: _width * .15,
                  height: _width * .15,
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(widget.nombre,
                          style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontFamily: 'NeoMedium',
                              fontWeight: FontWeight.w700)),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(widget.repeticiones,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontFamily: 'NeoRegular',
                          )),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    _onVisibleChanged();
                    final indexDia =
                        widget.rutina.rutina.viernes[widget.index];
                    Dia cambiarDia = Dia(
                        descripcion: indexDia.descripcion,
                        duracion: indexDia.duracion,
                        imagen: indexDia.imagen,
                        nombreRutina: indexDia.nombreRutina,
                        repeticiones: indexDia.repeticiones,
                        video: indexDia.video,
                        terminada: isChecked);

                    List<Dia> nuevos = widget.rutina.rutina.viernes;
                    nuevos[widget.index] = cambiarDia;

                    final nuevaRutinaClass = RutinaClass(
                        lunes: widget.rutina.rutina.lunes,
                        martes: widget.rutina.rutina.martes,
                        miercoles: widget.rutina.rutina.miercoles,
                        jueves: widget.rutina.rutina.jueves,
                        viernes: nuevos);

                    final nuevaRutina = Rutina(
                        usuario: widget.rutina.usuario,
                        instructor: widget.rutina.instructor,
                        mes: widget.rutina.mes,
                        year: widget.rutina.year,
                        rutina: nuevaRutinaClass);

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
                    print(
                        "Aqui va el id de la rutina Firebase ${widget.rutina.id!}");
                    print(nuevaRutina.rutina.viernes[widget.index].terminada);

                    final result = await FirebaseFirestore.instance
                        .collection("rutinas")
                        .doc(widget.rutina.id!)
                        .update(nuevaRutina
                            .toJson()); //.doc (widget.rutina.id!).update(nuevaRutina.toJson());
                  },
                  child: Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      color: isChecked ? primary : Colors.black,
                      border: Border.all(width: 2, color: primary),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(5.0)),
                    ),
                    child: Icon(Icons.check,
                        size: 20,
                        color: isChecked ? Colors.white : Colors.black),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }
}
