import 'package:flutter/cupertino.dart';
import 'package:gym/domain/models/users.dart';
import 'package:gym/domain/repository/users_repository.dart';


class RegisterProvider extends ChangeNotifier{
  RegisterProvider({required this.personRepository});
  final UserRepository personRepository;
  bool userExist = true;
  List<Usuario>? usuarios;
  Usuario? usuarioRegister;

  String? email;
  String? password;
  String? tipoUsario;

 
  Future<bool> getUser(String email, String password) async{
    usuarios = await personRepository.getUsuario(email);
    
    if (usuarios!.isNotEmpty) {
       userExist = false; 
       print("userExiste: $userExist");
    }else{
       userExist = true;
      
      
    }
    notifyListeners();

    return userExist;
  }
  
  Future<Usuario> registerUser(Usuario usuario) async{
    final result = await personRepository.registerUser(usuario);
    usuarioRegister = result;
    notifyListeners();
    return result;
  }
  void onChangeTipoUsuario(String tipo){
    tipoUsario = tipo;
    notifyListeners();
  }

  void setUserData (String emailSet, String passwordSet){
    email = emailSet;
    password = passwordSet;
    notifyListeners();
  }

}