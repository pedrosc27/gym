import 'package:flutter/material.dart';
import 'package:gym/ui/pages/gyms/widgets/gym_card.dart';

class GymPage extends StatefulWidget {
  const GymPage({super.key});

  @override
  State<GymPage> createState() => _GymPageState();
}

class _GymPageState extends State<GymPage> {
  @override
  Widget build(BuildContext context) {
    final MediaQueryData data = MediaQuery.of(context);
    final Size size = data.size;
    final _width = size.width;
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            const Text(
              "Seleccione el Centro Deportivo para Mayor Información",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontFamily: 'NeoRegular',
                  fontWeight: FontWeight.w700),
            ),
             const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GymCard(
                  imagen: "assets/images/gym/Black-Power.JPG",
                  size: _width * .4,
                  url: "https://www.facebook.com/BlackPowerGymPro/",
                ),
                GymCard(
                  imagen: "assets/images/gym/Kings-Queens-Fit.JPG",
                  size: _width * .4,
                  url: "https://www.facebook.com/kings.queens.fit/",
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GymCard(
                  imagen: "assets/images/gym/Pro-Gym.JPG",
                  size: _width * .4,
                  url: "https://www.facebook.com/PROGYMLZC/",
                ),
                GymCard(
                  imagen: "assets/images/gym/Sparta-Gym.JPG",
                  size: _width * .4,
                  url: "https://www.facebook.com/profile.php?id=100076159667919",
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GymCard(
                  imagen: "assets/images/gym/G-Sport.JPG",
                  size: _width * .4,
                  url: "https://www.facebook.com/clubdeportivoGsport",
                ),
                GymCard(
                  imagen: "assets/images/gym/Infinity-Gym.JPG",
                  size: _width * .4,
                  url: "https://www.facebook.com/profile.php?id=100063738902568",
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
