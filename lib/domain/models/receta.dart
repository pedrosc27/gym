// To parse this JSON data, do
//
//     final usuario = usuarioFromJson(jsonString);

import 'dart:convert';

Receta usuarioFromJson(String str) => Receta.fromJson(json.decode(str));

String usuarioToJson(Receta data) => json.encode(data.toJson());

class Receta {
  Receta(
      {this.id,
      required this.nombre,
      required this.descripcion,
      required this.horario,
      required this.imagen,
      required this.mes,
      required this.year,
      required this.usuario});

  String? id;
  final String nombre;
  final String descripcion;
  final String horario;
  final String imagen;
  final String mes;
  final String year;
  final String usuario;

  Receta copyWith({
        String? id,
        String? nombre,
        String? descripcion,
        String? horario,
        String? imagen,
        String? mes,
        String? year,
        String? usuario,
  }) =>
      Receta(
     id: id ?? this.id,
            nombre: nombre ?? this.nombre,
            descripcion: descripcion ?? this.descripcion,
            horario: horario ?? this.horario,
            imagen: imagen ?? this.imagen,
            mes: mes ?? this.mes,
            year: year ?? this.year,
            usuario: usuario ?? this.usuario,
      );



  factory Receta.fromJson(Map<String, dynamic> json) => Receta(
      id: json["id"],
      nombre: json["nombre"],
      descripcion: json["descripcion"],
      horario: json["horario"],
      imagen: json["imagen"],
      mes: json["mes"],
      year: json["year"],
      usuario: json["usuario"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "descripcion": descripcion,
        "horario": horario,
        "imagen": imagen,
        "mes": mes,
        "year": year,
        "usuario": usuario
      };
}
