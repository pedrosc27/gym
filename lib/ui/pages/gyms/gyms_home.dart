import 'package:flutter/material.dart';
import 'package:gym/ui/pages/gyms/crossfit.dart';
import 'package:gym/ui/pages/gyms/gyms.dart';
import 'package:gym/ui/utils/colors.dart';

class GymHomePage extends StatefulWidget {
  const GymHomePage({super.key});

  @override
  State<GymHomePage> createState() => _GymHomePage();
}

class _GymHomePage extends State<GymHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              TabBar(
                indicatorColor: Colors.black,
                indicatorWeight: 1.0,
                labelColor: primary,
                unselectedLabelColor: Colors.white,
                labelStyle: TextStyle(
                    fontSize: 18,
                    fontFamily: 'NeoMedium',
                    fontWeight: FontWeight.w700),
                tabs: [
                  Tab(
                    text: 'Crossfits',
                  ),
                  Tab(
                    text: 'Gimnasios',
                  ),
                ],
              )
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Crossfitage(),
            GymPage(),
          ],
        ),
      ),
    );
  }
}
