import 'package:gym/domain/models/users.dart';
import 'package:gym/ui/pages/entrenador/entrenador_datos_usuario_page.dart';
import 'package:gym/ui/pages/entrenador/entrenador_datos_usuario_provider.dart';
import 'package:gym/ui/pages/entrenador/entrenador_provider.dart';
import 'package:gym/ui/pages/entrenador/entrenador_rutina_activa.dart';
import 'package:gym/ui/pages/entrenador/entrenador_rutinas_activas_provider.dart';
import 'package:gym/ui/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:gym/domain/repository/users_repository.dart';
import 'package:provider/provider.dart';


class EntrenadorDatosUsuarios extends StatefulWidget {
  const EntrenadorDatosUsuarios._();

  static Widget init() => ChangeNotifierProvider(
        lazy: false,
        create: (context) => EntrenadorProvider(
          personRepository: context.read<UserRepository>(),
        )..loadUsers(),
        child: const EntrenadorDatosUsuarios._(),
      );

  @override
  State<EntrenadorDatosUsuarios> createState() => _EntrenadorDatosUsuarios();
}

class _EntrenadorDatosUsuarios extends State<EntrenadorDatosUsuarios> {
  @override
  Widget build(BuildContext context) {
     final entrenadorProvider = context.read<EntrenadorDatosUsuarioProvider>();


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
                         "Datos del Usuario ",
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
                        "Elige un Usuario para revisar sus Datos",
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
                              builder: (_) =>const PaginaDatosUsuario()));
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
