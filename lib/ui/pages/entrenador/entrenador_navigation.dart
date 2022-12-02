import 'package:flutter/material.dart';
import 'package:gym/ui/pages/entrenador/entrenador.dart';
import 'package:gym/ui/pages/entrenador/entrenador_datos_usuario.dart';
import 'package:gym/ui/pages/entrenador/entrenador_rutinas_activas.dart';

import 'package:gym/ui/pages/signout/signout.dart';
import 'package:gym/ui/utils/colors.dart';

class NavigationEntrenador extends StatefulWidget {
  const NavigationEntrenador({super.key});

  @override
  State<NavigationEntrenador> createState() => _NavigationEntrenador();
}

class _NavigationEntrenador extends State<NavigationEntrenador> {
  int _selectedIndex = 0;
  final List<Widget> _pages = <Widget>[
    Entrenador.init(),
    EntrenadorRutinasActivas.init(),
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
                icon: Icon(Icons.account_box),
                label: 'Calls',
                backgroundColor: degradado),
            BottomNavigationBarItem(
                icon: Icon(Icons.manage_accounts),
                label: 'Calls',
                backgroundColor:degradado),
            BottomNavigationBarItem(
              icon: Icon(Icons.logout),
              label: 'Camera',
               backgroundColor:degradado
            )
          ],
        ),
        body: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ));
  }
}
