import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym/data/preferences.dart';
import 'package:gym/data/preferences_provider.dart';
import 'package:gym/domain/models/rutina.dart';
import 'package:gym/ui/pages/entrenador/entrenador.dart';
import 'package:gym/ui/pages/entrenador/entrenador_navigation.dart';
import 'package:gym/ui/pages/home/home_page.dart';
import 'package:gym/ui/pages/home/widgets/navigation.dart';
import 'package:gym/ui/pages/login/login.dart';
import 'package:gym/ui/pages/nutriologa/nutriologa_navigation.dart';
import 'package:provider/provider.dart';

import '../nutriologa/nutriologa.dart';

class PreLoadPage extends StatefulWidget {
  const PreLoadPage({super.key});

  @override
  State<PreLoadPage> createState() => _PreLoadPage();
}

class _PreLoadPage extends State<PreLoadPage> {
  bool logeado = false; 
  String? tipo = "";
  @override
  void initState() {
   estaLogeado();

  }
  Future<void> estaLogeado() async{
  final preferencias = context.read<PreferencesProvider>();
  
    logeado = await preferencias.estaLogeado();
    tipo = preferencias.tipo;
    tipo = LocalStorage.prefs.getString("tipo") ;
    final email =LocalStorage.prefs.getString("email") ;

    setState(() {});
  }
  @override
  //child: logeado == true ?  const NavigationHome() : Login.init(),
  Widget build(BuildContext context) {
    if (!logeado) {
      return Container(
        child: Login.init(),
      );
    }
    if (logeado && tipo == "usuario") {
      return Container(
        child: const NavigationHome(),
      );
    }
    if (logeado && tipo == "entrenador") {
      return Container(
        child: const NavigationEntrenador(),
      );
    }
    if (logeado && tipo == "nutriloga") {
      return Container(
        child: const NavigationNutriologa(),
      );
    }
    else{
       return Container(
        child: Login.init(),
      );
    }
  }
}
