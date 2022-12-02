import 'dart:convert';

Rutina rutinaFromJson(String str) => Rutina.fromJson(json.decode(str));

String rutinaToJson(Rutina data) => json.encode(data.toJson());

class Rutina {
  Rutina({
    this.id,
    required this.usuario,
    required this.instructor,
    required this.mes,
    required this.year,
    required this.rutina,
  });
  String? id;
  final String usuario;
  final String instructor;
  final String mes;
  final String year;
  final RutinaClass rutina;

  Rutina copyWith({
    String? id,
    String? usuario,
    String? instructor,
    String? mes,
    String? year,
    RutinaClass? rutina,
  }) =>
      Rutina(
        id: id ?? this.id,
        usuario: usuario ?? this.usuario,
        instructor: instructor ?? this.instructor,
        mes: mes ?? this.mes,
        year: year ?? this.year,
        rutina: rutina ?? this.rutina,
      );

  factory Rutina.fromJson(Map<String, dynamic> json) => Rutina(
        id: json["id"],
        usuario: json["usuario"],
        instructor: json["instructor"],
        mes: json["mes"],
        year: json["year"],
        rutina: RutinaClass.fromJson(json["rutina"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "usuario": usuario,
        "instructor": instructor,
        "mes": mes,
        "year": year,
        "rutina": rutina.toJson(),
      };
}

class RutinaClass {
  RutinaClass({
    required this.lunes,
    required this.martes,
    required this.miercoles,
    required this.jueves,
    required this.viernes,
  });

  final List<Dia> lunes;
  final List<Dia> martes;
  final List<Dia> miercoles;
  final List<Dia> jueves;
  final List<Dia> viernes;

  factory RutinaClass.fromJson(Map<String, dynamic> json) => RutinaClass(
        lunes: List<Dia>.from(json["lunes"].map((x) => Dia.fromJson(x))),
        martes: List<Dia>.from(json["martes"].map((x) => Dia.fromJson(x))),
        miercoles:
            List<Dia>.from(json["miercoles"].map((x) => Dia.fromJson(x))),
        jueves: List<Dia>.from(json["jueves"].map((x) => Dia.fromJson(x))),
        viernes: List<Dia>.from(json["viernes"].map((x) => Dia.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "lunes": List<dynamic>.from(lunes.map((x) => x.toJson())),
        "martes": List<dynamic>.from(martes.map((x) => x.toJson())),
        "miercoles": List<dynamic>.from(miercoles.map((x) => x.toJson())),
        "jueves": List<dynamic>.from(jueves.map((x) => x.toJson())),
        "viernes": List<dynamic>.from(viernes.map((x) => x.toJson())),
      };
}

class Dia {
  Dia(
      {required this.descripcion,
      required this.duracion,
      required this.imagen,
      required this.nombreRutina,
      required this.repeticiones,
      required this.video,
      required this.terminada});

  final String descripcion;
  final String duracion;
  final String imagen;
  final String nombreRutina;
  final String repeticiones;
  final String video;
  final bool terminada;

  factory Dia.fromJson(Map<String, dynamic> json) => Dia(
        descripcion: json["descripcion"],
        duracion: json["duracion"],
        imagen: json["imagen"],
        nombreRutina: json["nombre_rutina"],
        repeticiones: json["repeticiones"],
        video: json["video"],
        terminada: json["terminada"] == null ? null : json["terminada"],  
      );

  Map<String, dynamic> toJson() => {
        "descripcion": descripcion,
        "duracion": duracion,
        "imagen": imagen,
        "nombre_rutina": nombreRutina,
        "repeticiones": repeticiones,
        "video": video,
        "terminada": terminada,
      };
}
