import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym/data/preferences.dart';
import 'package:gym/data/preferences_provider.dart';
import 'package:gym/ui/global_widgets/button.dart';

import 'package:gym/ui/global_widgets/input_text.dart';
import 'package:gym/ui/pages/home/home_page.dart';
import 'package:gym/ui/pages/login/login_provider.dart';
import 'package:gym/ui/pages/preload/preload.dart';
import 'package:gym/ui/utils/colors.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginForm();
}

class _LoginForm extends State<LoginForm> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

/*   Future<void> _setEmail() async {
    final preferenes = context.read<PreferencesProvider>();
    if (LocalStorage.prefs.getString("email") != null) {
      print("hay datos guardados");
      preferenes.email = LocalStorage.prefs.getString("email")!;
    }else{
     
      final guardar = await LocalStorage.prefs.setString('email', 'CorreoPrueba');
      
      print("no hay datos guardados");
    }
  }*/

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    bool isPassword = true;
    final preferencesProvider = Provider.of<PreferencesProvider>(context);
    final userExist = Provider.of<LoginProvider>(context).userExist;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "E-mail",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontFamily: 'NeoRegular',
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 15.0,
            ),
            InputText(
              controller: emailController,
              label: 'Email',
              prefix: Icons.email,
              type: TextInputType.emailAddress,
              validate: (String? value) {
                if (value!.isEmpty) {
                  return 'Este campo no puede estar vacío';
                }
              },
            ),
            const SizedBox(
              height: 15.0,
            ),
            const Text(
              "Contraseña",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontFamily: 'NeoRegular',
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 15.0,
            ),
            InputText(
              controller: passwordController,
              label: 'Password',
              prefix: Icons.lock,
              suffix: isPassword ? Icons.visibility : Icons.visibility_off,
              isPassword: isPassword,
              type: TextInputType.visiblePassword,
              validate: (String? value) {
                if (value!.isEmpty) {
                  return 'Este campo no puede estar vacío';
                }
              },
            ),
            const SizedBox(
              height: 25,
            ),
            userExist
                ? const SizedBox(
                    height: 15,
                  )
                : Column(
                    children: const [
                      Center(
                        child: Text(
                          "El usuario o contraseña son incorrectos",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.red,
                            fontFamily: 'NeoRegular',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      )
                    ],
                  ),
            ButtomCustom(
              color: primary,
              texto: "Iniciar Sesión",
              onSubmit: () async {
                if (formKey.currentState!.validate()) {
                  final result = await context
                      .read<LoginProvider>()
                      .getUser(emailController.text, passwordController.text);

                  if (result) {
                    final String emailSet =
                        context.read<LoginProvider>().usuario![0].email;
                    final String tipoSet =
                        context.read<LoginProvider>().usuario![0].tipo;
                    print("aqui va el emailSet : $emailSet");
                    print("aqui va el tiposet : $tipoSet");

                    final changePreferences =
                        preferencesProvider.changePref(emailSet, tipoSet);

                    //pushAndRemoveUntil
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => PreLoadPage()),
                        (Route<dynamic> route) => false);

                  
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
