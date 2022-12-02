import 'package:flutter/material.dart';
import 'package:gym/domain/models/rutina.dart';

class RutinaEntrenadorProvider extends ChangeNotifier {
  String user = "";
  String imagen = "sin imagen";
  List<Dia> lunes = [];
  List<Dia> martes = [];
  List<Dia> miercoles = [];
  List<Dia> jueves = [];
  List<Dia> viernes = [];
  List<Dia> todosLosDias = [];

  void setUser(String userEmail) {
    user = userEmail;
    notifyListeners();
  }

  void setImagen(String imagenChange) {
    imagen = imagenChange;
    notifyListeners();
  }

  void setLunes(Dia dia) {
    lunes.add(dia);
    todosLosDias.add(dia);
    notifyListeners();
  }

  void setMartes(Dia dia) {
    martes.add(dia);
    todosLosDias.add(dia);
    notifyListeners();
  }

  void setMiercoles(Dia dia) {
    miercoles.add(dia);
    todosLosDias.add(dia);
    notifyListeners();
  }

  void setJueves(Dia dia) {
    jueves.add(dia);
    todosLosDias.add(dia);
    notifyListeners();
  }

  void setViernes(Dia dia) {
    viernes.add(dia);
    todosLosDias.add(dia);
    notifyListeners();
  }

  void deleteItem(int index) {
    final uno = lunes.removeWhere((dia) =>
        dia.nombreRutina == todosLosDias[index].nombreRutina &&
        dia.descripcion == todosLosDias[index].descripcion);
    final dos = martes.removeWhere((dia) =>
        dia.nombreRutina == todosLosDias[index].nombreRutina &&
        dia.descripcion == todosLosDias[index].descripcion);
    final tres = miercoles.removeWhere((dia) =>
        dia.nombreRutina == todosLosDias[index].nombreRutina &&
        dia.descripcion == todosLosDias[index].descripcion);
    final cuatro = jueves.removeWhere((dia) =>
        dia.nombreRutina == todosLosDias[index].nombreRutina &&
        dia.descripcion == todosLosDias[index].descripcion);
    final cinco = viernes.removeWhere((dia) =>
        dia.nombreRutina == todosLosDias[index].nombreRutina &&
        dia.descripcion == todosLosDias[index].descripcion);
    todosLosDias.removeAt(index);
    notifyListeners();
  }

  void reset() {
    user = "";
    imagen = "sin imagen";
    lunes = [];
    martes = [];
    miercoles = [];
    jueves = [];
    viernes = [];
    todosLosDias = [];
    notifyListeners();
  }
}
