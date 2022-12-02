import 'package:flutter/material.dart';
import 'package:gym/data/preferences.dart';
import 'package:gym/domain/models/rutina.dart';
import 'package:gym/domain/repository/users_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
class HomeProvider extends ChangeNotifier {
  HomeProvider({required this.personRepository});

  final UserRepository personRepository;
  final SharedPreferences prefs = LocalStorage.prefs;
  final usuario = LocalStorage.prefs.getString("email");

  Stream<List<Rutina>> load() {
    return personRepository.getPersonsStream(usuario!);
  }

  /*void delete(String docId) async {
    await personRepository.deletePerson(docId);
  }*/
}