import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gym/data/preferences.dart';
import 'package:gym/data/preferences_provider.dart';
import 'package:gym/data/users_firebase.dart';
import 'package:gym/domain/repository/users_repository.dart';
import 'package:gym/ui/pages/entrenador/entrenador_rutinas_activas_provider.dart';
import 'package:gym/ui/pages/nutriologa/nutri_Activa_provider.dart';
import 'package:gym/ui/pages/nutriologa/nutriologa_provider.dart';
import 'package:gym/ui/pages/preload/preload.dart';
import 'package:gym/ui/pages/recetas_usuario/recetas_usuario_provider.dart';
import 'package:gym/ui/pages/rutina_entrenador/crear_rutina_provider.dart';
import 'package:provider/provider.dart';

import 'ui/pages/entrenador/entrenador_datos_usuario_provider.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.configurePrefs();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     return MultiProvider(
      providers: [
        Provider<UserRepository>(
          create: (_) => UserFirebase(),
        ),
         ChangeNotifierProvider<PreferencesProvider>(create: (_) => PreferencesProvider()),
         ChangeNotifierProvider<RutinaEntrenadorProvider>(create: (_) => RutinaEntrenadorProvider()),
         ChangeNotifierProvider<EntrenadorRutinaActivaProvider>(create: (_) => EntrenadorRutinaActivaProvider()),
         ChangeNotifierProvider<EntrenadorDatosUsuarioProvider>(create: (_) => EntrenadorDatosUsuarioProvider()),
        ChangeNotifierProvider<NutriActivaProvider>(create: (_) => NutriActivaProvider()),
         ChangeNotifierProvider<NutriologaProvider>(create: (_) => NutriologaProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const PreLoadPage(),
      ),
    );
  }
}

