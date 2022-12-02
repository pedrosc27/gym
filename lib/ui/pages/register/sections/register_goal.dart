import 'package:flutter/material.dart';
import 'package:gym/data/preferences.dart';
import 'package:gym/data/preferences_provider.dart';
import 'package:gym/domain/repository/users_repository.dart';
import 'package:gym/ui/global_widgets/button.dart';
import 'package:gym/ui/pages/home/home_page.dart';
import 'package:gym/ui/pages/login/login_provider.dart';
import 'package:gym/ui/pages/preload/preload.dart';
import 'package:gym/ui/pages/register/register_provider.dart';
import 'package:gym/ui/pages/register/sections/register_user_data.dart';
import 'package:gym/ui/utils/colors.dart';
import 'package:provider/provider.dart';

class RegisterGoal extends StatefulWidget {
  const RegisterGoal._();
  static Widget init() => ChangeNotifierProvider(
        lazy: false,
        create: (context) => RegisterProvider(
          personRepository: context.read<UserRepository>(),
        ),
        child: const RegisterGoal._(),
      );

  @override
  State<RegisterGoal> createState() => _RegisterGoal();
}

class _RegisterGoal extends State<RegisterGoal> {
  int valorActual = 1;
  @override
  Widget build(BuildContext context) {
    final MediaQueryData data = MediaQuery.of(context);
    final Size size = data.size;

    return Container(
      color: Colors.black,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(
                    child: Text(
                      "Elige tu Objetivo",
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
                            "Perdida de Peso",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontFamily: 'NeoMedium',
                                fontWeight: FontWeight.w700),
                          ),
                          Image.asset("assets/images/dieta.png")
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
                            "Aumento de IMC",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontFamily: 'NeoMedium',
                                fontWeight: FontWeight.w700),
                          ),
                          Image.asset("assets/images/masa-corporal.png")
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
                            "Definición Corporal",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontFamily: 'NeoMedium',
                                fontWeight: FontWeight.w700),
                          ),
                          Image.asset("assets/images/rutina-de-ejercicio.png")
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
                      texto: "Finalizar",
                      onSubmit: () async {
                        String goal = "";
                        if (valorActual == 1) {
                          goal = "Perdida de Peso";
                        }
                        if (valorActual == 2) {
                          goal = "Aumento de IMC";
                        }
                        if (valorActual == 3) {
                          goal = "Definición Corporal";
                        }

                        LocalStorage.prefs
                            .setString("goal", goal)
                            .then((bool success) {
                          print("se guardo el goal");
                        });
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => RegisterUserData.init()));
                      //  Navigator.of(context).pushAndRemoveUntil(
                        //    MaterialPageRoute(
                          //      builder: (context) => PreLoadPage()),
                            //(Route<dynamic> route) => false);
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
