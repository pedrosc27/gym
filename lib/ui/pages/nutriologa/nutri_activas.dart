import 'package:gym/domain/models/users.dart';
import 'package:gym/ui/pages/entrenador/entrenador_provider.dart';
import 'package:gym/ui/pages/nutriologa/nutri_Activa_provider.dart';
import 'package:gym/ui/pages/nutriologa/nutri_recetas_activas.dart';
import 'package:gym/ui/pages/nutriologa/nutriologa_provider.dart';
import 'package:gym/ui/pages/nutriologa/sections/crear_dieta.dart';
import 'package:gym/ui/pages/recetas_usuario/recetas_usuario_provider.dart';
import 'package:gym/ui/pages/rutina_entrenador/crear_rutina_provider.dart';
import 'package:gym/ui/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:gym/domain/repository/users_repository.dart';
import 'package:provider/provider.dart';


class NutriologaActPage extends StatefulWidget {
  const NutriologaActPage._();

  static Widget init() => ChangeNotifierProvider(
        lazy: false,
        create: (context) => EntrenadorProvider(
          personRepository: context.read<UserRepository>(),
        )..loadUsers(),
        child: const NutriologaActPage._(),
      );

  @override
  State<NutriologaActPage> createState() => _NutriologaActPage();
}

class _NutriologaActPage extends State<NutriologaActPage> {
  @override
  Widget build(BuildContext context) {
    final entrenadorProvider = context.read<RutinaEntrenadorProvider>();
    final nutriologaProvider = context.read<NutriologaProvider>();
    final nutriologaActivasProvider = context.read<NutriActivaProvider>();

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
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                       Container(
                        color: primary,
                        height: 56,
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: const Center(
                          child: Text(
                            "Dietas Activas",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'NeoMedium',
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "Elige un Usuario revisar su dieta actual",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'NeoRegular',
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final usuario = data[index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: degradado),
                            child: ListTile(
                              onTap: () {
                                final setUser =
                                    nutriologaActivasProvider.setUsuario2(usuario.email);
                                print(nutriologaProvider.user);

                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) =>  RecetasUsuarioActivas.init()));
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
              ),
            );
          }),
    );
  }
}
