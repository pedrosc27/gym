import 'package:flutter/material.dart';
import 'package:gym/ui/pages/gyms/widgets/gym_card.dart';

class Crossfitage extends StatefulWidget {
  const Crossfitage({super.key});

  @override
  State<Crossfitage> createState() => _Crossfitage();
}

class _Crossfitage extends State<Crossfitage> {
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
                  imagen: "assets/images/crossfit/Alpha-Box.JPG",
                  size: _width * .4,
                  url: "https://www.facebook.com/alphaboxlzc/",
                ),
                GymCard(
                  imagen: "assets/images/crossfit/BlackBox-Multi-Fitness.JPG",
                  size: _width * .4,
                  url: "https://www.facebook.com/Blackboxlzc/",
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
                  imagen: "assets/images/crossfit/CASTA.JPG",
                  size: _width * .4,
                  url: "https://www.facebook.com/CastaTeam/",
                ),
                GymCard(
                  imagen: "assets/images/crossfit/Epic-Cross-Lzc.JPG",
                  size: _width * .4,
                  url: "https://www.facebook.com/CrossfitEPIC/",
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
                  imagen: "assets/images/crossfit/exodo-Crossfit.JPG",
                  size: _width * .4,
                  url: "https://m.facebook.com/EXODOCROSSFIT/",
                ),
                GymCard(
                  imagen: "assets/images/crossfit/RX-Funcional-Crossfit.JPG",
                  size: _width * .4,
                  url:
                      "https://www.facebook.com/RX-Funcional-y-Crossfit-103366834934114/",
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
