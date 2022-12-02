import 'package:flutter/material.dart';
import 'package:gym/domain/repository/users_repository.dart';
import 'package:gym/ui/pages/login/login_provider.dart';
import 'package:gym/ui/pages/login/widgets/login_form.dart';
import 'package:gym/ui/pages/register/register.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
   const Login._();
    static Widget init() => ChangeNotifierProvider(
        lazy: false,
        create: (context) => LoginProvider(
          personRepository: context.read<UserRepository>(),
         
        ),
        child: const Login._(),
      );

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                  "assets/images/pexels-tima-miroshnichenko-6389075.jpg"),
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
                      "HEALTH IMPACT",
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
                  const LoginForm(),
                  const SizedBox(
                    height: 60.0,
                  ),
                  Column(
                    children: [
                      const Text(
                        "¿No tienes cuenta?",
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
                          Navigator.of(context).push(MaterialPageRoute(builder: (_) => Register.init()));
                        }),
                        child: const Text(
                          "Registrate ahora",
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
