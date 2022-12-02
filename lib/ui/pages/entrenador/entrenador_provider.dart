import 'package:flutter/material.dart';
import 'package:gym/domain/models/users.dart';
import 'package:gym/domain/repository/users_repository.dart';

class EntrenadorProvider extends ChangeNotifier {
  EntrenadorProvider({required this.personRepository});

  final UserRepository personRepository;

  Stream<List<Usuario>> loadUsers() {
    return personRepository.getAllUsers();
  }

  /*void delete(String docId) async {
    await personRepository.deletePerson(docId);
  }*/
}