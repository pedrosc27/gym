import 'package:gym/domain/models/users.dart';
import 'package:gym/ui/pages/entrenador/entrenador_provider.dart';
import 'package:gym/ui/pages/entrenador/entrenador_rutina_activa.dart';
import 'package:gym/ui/pages/entrenador/entrenador_rutinas_activas_provider.dart';
import 'package:gym/ui/pages/home/widgets/rutina_card.dart';
import 'package:gym/ui/pages/rutina_entrenador/crear_rutinas.dart';
import 'package:gym/ui/pages/rutina_entrenador/crear_rutina_provider.dart';
import 'package:gym/ui/utils/colors.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:gym/domain/models/rutina.dart';
import 'package:gym/domain/repository/users_repository.dart';
import 'package:gym/ui/pages/home/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/preferences.dart';

class EntrenadorRutinasActivas extends StatefulWidget {
  const EntrenadorRutinasActivas._();

  static Widget init() => ChangeNotifierProvider(
        lazy: false,
        create: (context) => EntrenadorProvider(
          personRepository: context.read<UserRepository>(),
        )..loadUsers(),
        child: const EntrenadorRutinasActivas._(),
      );

  @override
  State<EntrenadorRutinasActivas> createState() => _EntrenadorRutinasActivas();
}

class _EntrenadorRutinasActivas extends State<EntrenadorRutinasActivas> {
  @override
  Widget build(BuildContext context) {
    
     final entrenadorProvider = context.read<EntrenadorRutinaActivaProvider>();
    

    return Scaffold(
      backgroundColor: Colors.black,
      body: StreamBuilder<List<Usuario>>(
          stream: context.read<EntrenadorProvider>().loadUsers(),
          builder: (context, snapshot) {
           
            if (!snapshot.hasData ||
                snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final data = snapshot.data!;
            if (data.isEmpty) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/pregunta.png"),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "No hay usuarios registrados",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: 'NeoRegular',
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              );
            }

            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                     const Padding(
                       padding:  EdgeInsets.all(16.0),
                       child: Text(
                         "Rutinas Activas",
                         style: TextStyle(
                           color: Colors.white,
                           
                             fontSize: 18,
                             fontFamily: 'NeoMedium',
                             fontWeight: FontWeight.w700),
                       ),
                     ),
                    const SizedBox(
                      height: 16,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 16),
                      child:  Text(
                        "Elige un Usuario para revisar su rutina Actual",
                        style: TextStyle(
                          color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'NeoRegular',),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final usuario = data[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: degradado),
                          child: ListTile(
                            onTap: (){
                             final setUser =entrenadorProvider.setUser(usuario.email);
                              print(entrenadorProvider.user);
                              Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) =>const EntrenadorRutinaActivaPage()));
                            },
                            title: Text(
                              usuario.email,
                              style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontFamily: 'NeoRegular',
                              fontWeight: FontWeight.w700),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
