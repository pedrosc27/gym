import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gym/data/preferences.dart';
import 'package:gym/domain/repository/users_repository.dart';
import 'package:gym/ui/pages/nutriologa/nutri_Activa_provider.dart';
import 'package:gym/ui/pages/recetas_usuario/receta_usuario_page.dart';
import 'package:gym/ui/pages/recetas_usuario/recetas_usuario_provider.dart';
import 'package:gym/ui/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecetasUsuarioActivas extends StatefulWidget {
  const RecetasUsuarioActivas._();

  static Widget init() => ChangeNotifierProvider(
        lazy: false,
        create: (context) => RecetasUsuarioProvider(
          personRepository: context.read<UserRepository>(),
        )..loadRecetas,
        child: const RecetasUsuarioActivas._(),
      );

  @override
  State<RecetasUsuarioActivas> createState() => _RecetasUsuarioActivas();
}

class _RecetasUsuarioActivas extends State<RecetasUsuarioActivas> {
  @override
  Widget build(BuildContext context) {
    final MediaQueryData data = MediaQuery.of(context);
    final Size size = data.size;
    final _width = size.width;
    final SharedPreferences prefs = LocalStorage.prefs;
    final nombre = prefs.getString("nombre") ?? "";
    
    return Scaffold(
      backgroundColor: Colors.black,
      body: StreamBuilder(
          stream: context.read<NutriActivaProvider>().getRecetasUsuarioStream(),
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
                      "Este Usuario no tiene dietas Activas",
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
                    Container(
                      width: double.infinity,
                      color: primary,
                      height: 56,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: const Center(
                        child: Text(
                          "Dieta de la Semana",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'NeoMedium',
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    const SizedBox(height: 48),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final receta = data[index];
                          return Dismissible(
                            key: UniqueKey(),
                            onDismissed: (DismissDirection direction) async{
                              final recetasProvider= context.read<NutriActivaProvider>();
                              await recetasProvider.deletePerson(receta.id!);
                              
                              print("id: ${receta.id}");
                              print("nombre: ${receta.nombre}");
                              //recetasProvider.delete(receta.id!);
                              
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 16),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: degradado),
                              child: ListTile(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) =>
                                          RecataPaginaUsuario(receta: receta)));
                                },
                                title: Text(
                                  receta.nombre,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontFamily: 'NeoRegular',
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
