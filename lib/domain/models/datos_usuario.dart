// To parse this JSON data, do
//
//     final datosUsuario = datosUsuarioFromJson(jsonString);

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

DatosUsuario datosUsuarioFromJson(String str) => DatosUsuario.fromJson(json.decode(str));

String datosUsuarioToJson(DatosUsuario data) => json.encode(data.toJson());

class DatosUsuario {
    DatosUsuario({
        required this.nombre,
        required this.apellido,
        required this.edad,
        required this.sexo,
        required this.estatura,
        required this.peso,
        required this.discapacidad,
        required this.alergia,
        required this.deporte,
        required this.email,
        required this.goal

    });

    final String nombre;
    final String apellido;
    final String edad;
    final String sexo;
    final String estatura;
    final String peso;
    final String discapacidad;
    final String alergia;
    final String deporte;
    final String email;
    final String goal;
   

    factory DatosUsuario.fromJson(Map<String, dynamic> json) => DatosUsuario(
        nombre: json["nombre"],
        apellido: json["apellido"],
        edad: json["edad"],
        sexo: json["sexo"],
        estatura: json["estatura"],
        peso: json["peso"],
        discapacidad: json["discapacidad"],
        alergia: json["alergia"],
        deporte: json["deporte"],
         email: json["email"],
          goal: json["goal"]
    );

    Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "apellido": apellido,
        "edad": edad,
        "sexo": sexo,
        "estatura": estatura,
        "peso": peso,
        "discapacidad": discapacidad,
        "alergia": alergia,
        "deporte": deporte,
        "email": email,
        "goal": goal
    };
}
