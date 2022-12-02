import 'package:flutter/material.dart';
import 'package:gym/data/preferences.dart';
import 'package:gym/data/preferences_provider.dart';
import 'package:gym/ui/pages/preload/preload.dart';
import 'package:gym/ui/utils/colors.dart';
import 'package:provider/provider.dart';

class SignOut extends StatefulWidget {
  const SignOut({super.key});

  @override
  State<SignOut> createState() => _SignOutState();
}

class _SignOutState extends State<SignOut> {
  void signOut() async {
    final preferencias = context.read<PreferencesProvider>();
    LocalStorage.prefs.setString("email", "").then((bool success) {
      LocalStorage.prefs.setString("tipo", "").then((bool success) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => const PreLoadPage()));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: GestureDetector(
            onTap: () async {
              signOut();
            },
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: primary,
              ),
              child: const Text(
                "Cerrar Sesión",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'NeoRegular',
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
