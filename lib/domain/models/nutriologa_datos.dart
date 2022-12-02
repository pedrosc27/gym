// To parse this JSON data, do
//
//     final nutriologaDatos = nutriologaDatosFromJson(jsonString);

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

NutriologaDatosModel nutriologaDatosFromJson(String str) => NutriologaDatosModel.fromJson(json.decode(str));

String nutriologaDatosToJson(NutriologaDatosModel data) => json.encode(data.toJson());

class NutriologaDatosModel {
    NutriologaDatosModel({
        required this.peso,
        required this.grasaImpidencia,
        required this.masaImpidencia,
        required this.cintura,
        required this.perimetroAbdominal,
        required this.cadera,
        required this.pBrazoRelajado,
        required this.pBrazoContraido,
        required this.pMuslo,
        required this.pPierna,
        required this.plBiceps,
        required this.plTriceps,
        required this.pSubescapular,
        required this.pIleocretal,
        required this.pSupraespinal,
        required this.pAbdominal,
        required this.plMuslo,
        required this.plPierna,
        required this.porcentajeGrasa,
        required this.usuario,
        required this.mes,
        required this.year,
        required this.timestamp
    });

    final String peso;
    final String grasaImpidencia;
    final String masaImpidencia;
    final String cintura;
    final String perimetroAbdominal;
    final String cadera;
    final String pBrazoRelajado;
    final String pBrazoContraido;
    final String pMuslo;
    final String pPierna;
    final String plBiceps;
    final String plTriceps;
    final String pSubescapular;
    final String pIleocretal;
    final String pSupraespinal;
    final String pAbdominal;
    final String plMuslo;
    final String plPierna;
    final String porcentajeGrasa;
    final String usuario;
    final String mes;
    final String year;
    final Timestamp timestamp;


    factory NutriologaDatosModel.fromJson(Map<String, dynamic> json) => NutriologaDatosModel(
        peso: json["peso"],
        grasaImpidencia: json["grasaImpidencia"],
        masaImpidencia: json["masaImpidencia"],
        cintura: json["cintura"],
        perimetroAbdominal: json["perimetroAbdominal"],
        cadera: json["cadera"],
        pBrazoRelajado: json["pBrazoRelajado"],
        pBrazoContraido: json["pBrazoContraido"],
        pMuslo: json["pMuslo"],
        pPierna: json["pPierna"],
        plBiceps: json["plBiceps"],
        plTriceps: json["plTriceps"],
        pSubescapular: json["pSubescapular"],
        pIleocretal: json["pIleocretal"],
        pSupraespinal: json["pSupraespinal"],
        pAbdominal: json["pAbdominal"],
        plMuslo: json["plMuslo"],
        plPierna: json["plPierna"],
        porcentajeGrasa: json["porcentajeGrasa"],
        usuario: json["usuario"],
        mes: json["mes"],
        year: json["year"],
        timestamp: json["timestamp"]
    );

    Map<String, dynamic> toJson() => {
        "peso": peso,
        "grasaImpidencia": grasaImpidencia,
        "masaImpidencia": masaImpidencia,
        "cintura": cintura,
        "perimetroAbdominal": perimetroAbdominal,
        "cadera": cadera,
        "pBrazoRelajado": pBrazoRelajado,
        "pBrazoContraido": pBrazoContraido,
        "pMuslo": pMuslo,
        "pPierna": pPierna,
        "plBiceps": plBiceps,
        "plTriceps": plTriceps,
        "pSubescapular": pSubescapular,
        "pIleocretal": pIleocretal,
        "pSupraespinal": pSupraespinal,
        "pAbdominal": pAbdominal,
        "plMuslo": plMuslo,
        "plPierna": plPierna,
        "porcentajeGrasa": porcentajeGrasa,
        "usuario": usuario,
        "mes": mes,
        "year": year,
        "timestamp": timestamp
    };
}
