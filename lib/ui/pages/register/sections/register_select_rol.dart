import 'package:flutter/material.dart';
import 'package:gym/data/preferences_provider.dart';
import 'package:gym/domain/models/users.dart';
import 'package:gym/domain/repository/users_repository.dart';
import 'package:gym/ui/global_widgets/button.dart';
import 'package:gym/ui/pages/preload/preload.dart';
import 'package:gym/ui/pages/register/register_provider.dart';
import 'package:gym/ui/pages/register/sections/register_goal.dart';
import 'package:gym/ui/pages/register/sections/register_user_data.dart';
import 'package:gym/ui/utils/colors.dart';
import 'package:provider/provider.dart';

class RegistarRol extends StatefulWidget {
  const RegistarRol._();
  static Widget init() => ChangeNotifierProvider(
        lazy: false,
        create: (context) => RegisterProvider(
          personRepository: context.read<UserRepository>(),
        ),
        child: const RegistarRol._(),
      );

  @override
  State<RegistarRol> createState() => _RegistarRol();
}

class _RegistarRol extends State<RegistarRol> {
  int valorActual = 1;
  @override
  Widget build(BuildContext context) {
    final MediaQueryData data = MediaQuery.of(context);
    final Size size = data.size;
    final registerProvider = context.read<RegisterProvider>();
    final preferencesProvider = Provider.of<PreferencesProvider>(context);
    return Container(
      color: Colors.black,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(
                    child: Text(
                      "Elige tu tipo de Usuario",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontFamily: 'NeoMedium',
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        valorActual = 1;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(16),
                      width: size.width * .8,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: valorActual == 1 ? primary : Colors.black,
                          style: BorderStyle.solid,
                          width: 3.0,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20.0)),
                        color: Color(0xFF1c1e21),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Usuario",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontFamily: 'NeoMedium',
                                fontWeight: FontWeight.w700),
                          ),
                          Image.asset("assets/images/usuario.png")
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        valorActual = 2;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(16),
                      width: size.width * .8,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: valorActual == 2 ? primary : Colors.black,
                          style: BorderStyle.solid,
                          width: 3.0,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20.0)),
                        color: Color(0xFF1c1e21),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Nutriólogo",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontFamily: 'NeoMedium',
                                fontWeight: FontWeight.w700),
                          ),
                          Image.asset("assets/images/nutriologa.png")
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: (() {
                      setState(() {
                        valorActual = 3;
                      });
                    }),
                    child: Container(
                      padding: EdgeInsets.all(16),
                      width: size.width * .8,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: valorActual == 3 ? primary : Colors.black,
                          style: BorderStyle.solid,
                          width: 3.0,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20.0)),
                        color: Color(0xFF1c1e21),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Entrenador",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontFamily: 'NeoMedium',
                                fontWeight: FontWeight.w700),
                          ),
                          Image.asset("assets/images/entrenador.png")
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Container(
                    width: size.width * .8,
                    child: ButtomCustom(
                      color: primary,
                      texto: "Siguiente",
                      onSubmit: () async {
                        print(valorActual);
                        String tipoUsuario2 = '';
                        if (valorActual == 1) {
                          tipoUsuario2 = 'usuario';
                        }
                        if (valorActual == 3) {
                          tipoUsuario2 = 'entrenador';
                        }
                        if (valorActual == 2) {
                          tipoUsuario2 = 'nutriloga';
                        }
                        print(tipoUsuario2);
                        final email = preferencesProvider.email;
                        final password = preferencesProvider.password;
                        final nuevoUsuario = Usuario(
                            email: email!,
                            password: password!,
                            tipo: tipoUsuario2);
                        print('email: $email');
                        print('password: $password');
                        final tipoUsuario = await context
                            .read<RegisterProvider>()
                            .registerUser(nuevoUsuario);

                        final changePreferences = preferencesProvider.changePref(email, tipoUsuario2);
                        if (valorActual == 1) {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => RegisterGoal.init()));
                         // Navigator.of(context).push(MaterialPageRoute(
                              //builder: (_) => RegisterUserData.init()));
                        }
                        if (valorActual == 3 || valorActual == 2)  {
                          Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => PreLoadPage()),
                        (Route<dynamic> route) => false);
                          
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
