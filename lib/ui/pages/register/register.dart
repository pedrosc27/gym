import 'package:flutter/material.dart';
import 'package:gym/domain/repository/users_repository.dart';
import 'package:gym/ui/pages/login/login.dart';
import 'package:gym/ui/pages/register/register_provider.dart';
import 'package:gym/ui/pages/register/widgets/register_form.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
   const Register._();
    static Widget init() => ChangeNotifierProvider(
        lazy: false,
        create: (context) => RegisterProvider(
          personRepository: context.read<UserRepository>(),
         
        ),
        child: const Register._(),
      );

  @override
  State<Register> createState() => _Register();
}

class _Register extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                  "assets/images/back4.png"),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView (
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(
                    child: Text(
                      "HEALTH IMPACT REGISTRO",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontFamily: 'NeoMedium',
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  const SizedBox(
                    height: 60.0,
                  ),
                  const RegisterForm(),
                  const SizedBox(
                    height: 60.0,
                  ),
                  Column(
                    children: [
                      const Text(
                        "¿Ya tienes cuenta?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontFamily: 'NeoRegular',
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      GestureDetector(
                        onTap: (() {
                           Navigator.of(context).push(MaterialPageRoute(builder: (_) => Login.init()));
                        }),
                        child: const Text(
                          "Inicia Sesión",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontFamily: 'NeoMedium',
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
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
