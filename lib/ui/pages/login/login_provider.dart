import 'package:flutter/material.dart';
import 'package:gym/domain/models/users.dart';
import 'package:gym/domain/repository/users_repository.dart';

class LoginProvider extends ChangeNotifier {
  LoginProvider({required this.personRepository});

  final UserRepository personRepository;
  bool userExist = true;
  List<Usuario>? usuario;

  Future<bool> getUser(String email, String password) async{
    print(email);
    usuario = await personRepository.getUsuario(email);
    
    if (usuario!.isEmpty ) {
      print("el usuario no existe");
       userExist = false; 
    }else{
        print("el usuario existe");
       
       if (password == usuario![0].password) {
         userExist = true;
       }else{
        userExist = false; 
       }
    }
    notifyListeners();

    return userExist;
  }
}
