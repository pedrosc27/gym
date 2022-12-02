import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym/data/preferences_provider.dart';
import 'package:gym/domain/models/rutina.dart';
import 'package:provider/provider.dart';

class InsertarFire extends StatefulWidget {
  const InsertarFire({super.key});

  @override
  State<InsertarFire> createState() => _InsertarFire();
}

class _InsertarFire extends State<InsertarFire> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Colors.black,
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            TextButton(
                onPressed: () async {
                  final lunes = Dia(
                      descripcion: "descripcion lunes",
                      duracion: "duracion lunes",
                      imagen: "imagen lunes",
                      nombreRutina: "nombreRutina lunes",
                      repeticiones: " repeticiones lunes",
                      video: " video lunes",
                      terminada: false);
                  final lunes2 = Dia(
                      descripcion: "5/12 Levantamiento de Disco Frontal 4/10 Levantamiento Frontal Mancuerna 4/15 Press Arnold 4/10 Press Militar ",
                      duracion: "duracion martes 2",
                      imagen: "imagen martes 2",
                      nombreRutina: "Hombro",
                      repeticiones: " repeticiones martes ",
                      video: " video martes 2",
                      terminada: false);
                  final martes = Dia(
                      descripcion: "4/31 Curl 31 4/15 Curl Inclinado Bicep 4/10 Curl Concentrado 4/10 Curl Neutro",
                      duracion: "duracion martes",
                      imagen: "imagen martes",
                      nombreRutina: "Brazo",
                      repeticiones: " repeticiones martes",
                      video: " video martes",
                      terminada: false);
                  final miercoles = Dia(
                      descripcion: "descripcion miercoles",
                      duracion: "duracion miercoles",
                      imagen: "imagen miercoles",
                      nombreRutina: "nombreRutina miercoles",
                      repeticiones: " repeticiones miercoles",
                      video: " video miercoles",
                      terminada: false);
                  final jueves = Dia(
                    descripcion: "descripcion jueves",
                    duracion: "duracion jueves",
                    imagen: "imagen jueves",
                    nombreRutina: "nombreRutina jueves",
                    repeticiones: " repeticiones jueves",
                    video: " video jueves",
                    terminada: false,
                  );
                  final jueves2 = Dia(
                      descripcion: "descripcion jueves 2",
                      duracion: "duracion jueves 2",
                      imagen: "imagen jueves 2",
                      nombreRutina: "nombreRutina jueves 2",
                      repeticiones: " repeticiones jueves 2",
                      video: " video jueves 2",
                      terminada: false);
                  final viernes = Dia(
                      descripcion: "descripcion viernes",
                      duracion: "duracion viernes",
                      imagen: "imagen viernes",
                      nombreRutina: "nombreRutina viernes",
                      repeticiones: " repeticiones viernes",
                      video: " video viernes",
                      terminada: false);

                  final rutina = Rutina(
                      usuario: "prueba12@gmail.com",
                      instructor: "instructor@gmail.com",
                      mes: "09",
                      year: "2022",
                      rutina: RutinaClass(
                          lunes: [lunes, lunes2],
                          martes: [martes, lunes2],
                          miercoles: [miercoles],
                          jueves: [jueves, jueves2],
                          viernes: [viernes]));

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
                  print(result);
                },
                child: Text("data"))
          ],
        ),
      ),
    );
  }
}
