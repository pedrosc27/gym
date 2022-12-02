import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym/data/preferences.dart';
import 'package:gym/domain/models/users.dart';
import 'package:gym/ui/global_widgets/button.dart';

import 'package:gym/ui/global_widgets/input_text.dart';
import 'package:gym/ui/pages/login/login_provider.dart';
import 'package:gym/ui/pages/register/register.dart';
import 'package:gym/ui/pages/register/sections/register_select_rol.dart';
import 'package:gym/ui/pages/register/register_provider.dart';
import 'package:gym/ui/utils/colors.dart';
import 'package:provider/provider.dart';

import '../../../../data/preferences_provider.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterForm();
}

class _RegisterForm extends State<RegisterForm> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    bool isPassword = true;
    final preferencesProvider = Provider.of<PreferencesProvider>(context);
    final userExist = Provider.of<RegisterProvider>(context).userExist;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Form(
        key: _formKey,
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
              height: 15.0,
            ),
            const Text(
              "Confirmar Contraseña",
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
              controller: confirmPasswordController,
              label: 'Password',
              prefix: Icons.lock,
              suffix: isPassword ? Icons.visibility : Icons.visibility_off,
              isPassword: isPassword,
              type: TextInputType.visiblePassword,
              validate: (String? value) {
                if (value!.isEmpty) {
                  return 'Este campo no puede estar vacío';
                }
                if (passwordController.text != confirmPasswordController.text) {
                  return 'las contraseñas no coinciden';
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
                          "Ya existe una cuenta registrada con este correo",
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
                if (_formKey.currentState!.validate()) {
                  final result = await context
                      .read<RegisterProvider>()
                      .getUser(emailController.text, passwordController.text);
                      if (result) {
                        final changePreferences = preferencesProvider.changePref(emailController.text, "");
                         preferencesProvider.email = LocalStorage.prefs.getString("email")!;
                        print(preferencesProvider.email);

                        final cambiar = preferencesProvider.changePrefEmailPassword(emailController.text, passwordController.text);

                         Navigator.of(context).push(MaterialPageRoute(builder: (_) => RegistarRol.init()));
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
