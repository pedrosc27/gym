import 'package:flutter/material.dart';
import 'package:gym/ui/pages/graficas/graficas.dart';
import 'package:gym/ui/pages/gyms/gyms_home.dart';
import 'package:gym/ui/pages/home/home_page.dart';
import 'package:gym/ui/pages/recetas_usuario/recetas_usuario.dart';
import 'package:gym/ui/pages/signout/signout.dart';
import 'package:gym/ui/utils/colors.dart';

class NavigationHome extends StatefulWidget {
  const NavigationHome({super.key});

  @override
  State<NavigationHome> createState() => _NavigationHomeState();
}

class _NavigationHomeState extends State<NavigationHome> {
  int _selectedIndex = 1;
  final List<Widget> _pages = <Widget>[
    GymHomePage(),
    HomePage.init(),
    RecetasUsuario.init(),
    Graficas.init(),
    SignOut(),
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
          selectedFontSize: 12,
          unselectedFontSize: 12,
          items: const <BottomNavigationBarItem>[
             BottomNavigationBarItem(
              icon: Icon(Icons.place),
              label: 'Chats',
              backgroundColor: degradado

            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.fitness_center),
                label: 'Calls',
                backgroundColor: degradado),
            BottomNavigationBarItem(
              icon: Icon(Icons.dinner_dining),
              label: 'Camera',
              backgroundColor: degradado
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart),
              label: 'Chats',
              backgroundColor: degradado
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.logout),
              label: 'Chats',
              backgroundColor: degradado
            ),
           
            
          ],
        ),
        body: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ));
  }
}
