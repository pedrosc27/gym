import 'package:flutter/material.dart';
import 'package:gym/ui/pages/entrenador/entrenador_datos_usuario.dart';
import 'package:gym/ui/pages/nutriologa/nutri_activas.dart';

import 'package:gym/ui/pages/nutriologa/nutriologa.dart';
import 'package:gym/ui/pages/nutriologa/nutriologa_datos.dart';
import 'package:gym/ui/pages/signout/signout.dart';
import 'package:gym/ui/utils/colors.dart';

class NavigationNutriologa extends StatefulWidget {
  const NavigationNutriologa({super.key});

  @override
  State<NavigationNutriologa> createState() => _NavigationNutriologa();
}

class _NavigationNutriologa extends State<NavigationNutriologa> {
  int _selectedIndex = 0;
  final List<Widget> _pages = <Widget>[
    NutriologaDatos.init(),
    Nutriologa.init(),
    NutriologaActPage.init(),
    EntrenadorDatosUsuarios.init(),
    SignOut()

    //InsertarFire(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          onTap: _onItemTapped,
          currentIndex: _selectedIndex,
          backgroundColor: negroDegradado,
          selectedItemColor: primary,
          unselectedItemColor: Colors.white,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.fitness_center),
                label: 'Calls',
                backgroundColor: degradado),
            BottomNavigationBarItem(
                icon: Icon(Icons.dinner_dining),
                label: 'Camera',
                backgroundColor: degradado),
            BottomNavigationBarItem(
                icon: Icon(Icons.fastfood),
                label: 'Camera',
                backgroundColor: degradado),
            BottomNavigationBarItem(
                icon: Icon(Icons.manage_accounts),
                label: 'Calls',
                backgroundColor: degradado),
            BottomNavigationBarItem(
                icon: Icon(Icons.logout),
                label: 'Camera',
                backgroundColor: degradado)
          ],
        ),
        body: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ));
  }
}
