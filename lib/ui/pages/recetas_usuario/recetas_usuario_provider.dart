import 'package:flutter/material.dart';
import 'package:gym/data/preferences.dart';
import 'package:gym/domain/models/receta.dart';
import 'package:gym/domain/repository/users_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
class RecetasUsuarioProvider extends ChangeNotifier {
  RecetasUsuarioProvider({required this.personRepository});

  final UserRepository personRepository;
  final SharedPreferences prefs = LocalStorage.prefs;
  final usuario = LocalStorage.prefs.getString("email");
  String usuario2 = "";

  Stream<List<Receta>> loadRecetas() {
    return personRepository.getRecetasUsuarioStream(usuario!);
  }

  void setUsuario2(String usuarioNuevo){
    usuario2 = usuarioNuevo;
    notifyListeners();
  }
  void delete(String docId) async {
    await personRepository.deletePerson(docId);
  }
}