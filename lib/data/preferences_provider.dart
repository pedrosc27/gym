import 'package:flutter/cupertino.dart';
import 'package:gym/data/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesProvider extends ChangeNotifier {
  final SharedPreferences prefs = LocalStorage.prefs;
  String? email;
  String? nombre;
  String? tipo;
  String? password;

  Future<void> changePref(String emailNuevo, String tipoUsuario) async {
    LocalStorage.prefs.setString("email", emailNuevo).then((bool success) {
      email = emailNuevo;
    });
    LocalStorage.prefs.setString("tipo", tipoUsuario).then((bool success) {
      tipo = tipoUsuario;
    });
   
    notifyListeners();
  }

  Future<void> changePrefEmailPassword(String emailNuevo, String passwordUsuario) async {
    LocalStorage.prefs.setString("email", emailNuevo).then((bool success) {
      email = emailNuevo;
    });
    LocalStorage.prefs.setString("password", passwordUsuario).then((bool success) {
      password = passwordUsuario;
    });
   
    notifyListeners();
  }

  Future<bool> estaLogeado() async {
    bool login = false;
    if (LocalStorage.prefs.getString("email") != null) {
      login = true;
    }
    return login;
  }
}
