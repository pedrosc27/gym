// To parse this JSON data, do
//
//     final usuario = usuarioFromJson(jsonString);


import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
    Usuario({
        required this.email,
        required this.password,
        required this.tipo,
    });

    final String email;
    final String password;
    final String tipo;

    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        email: json["email"],
        password: json["password"],
        tipo: json["tipo"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "tipo": tipo,
    };
}
