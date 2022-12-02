import 'package:flutter/material.dart';
import 'package:gym/data/preferences.dart';
import 'package:gym/domain/models/nutriologa_datos.dart';
import 'package:gym/domain/repository/users_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
class GraficasProvider extends ChangeNotifier {
  GraficasProvider({required this.personRepository});

  final UserRepository personRepository;
  final SharedPreferences prefs = LocalStorage.prefs;
  final usuario = LocalStorage.prefs.getString("email");

  Stream<List<NutriologaDatosModel>> loadGraficas() {
    return personRepository.getUsuarioGraficas(usuario!);
  }

  /*void delete(String docId) async {
    await personRepository.deletePerson(docId);
  }*/
}