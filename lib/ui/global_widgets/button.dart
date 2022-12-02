import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ButtomCustom extends StatelessWidget {
  final Color color;
  final void Function() onSubmit;
  final String texto;
  const ButtomCustom(
      {super.key, required this.color, required this.onSubmit, required this.texto, });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onSubmit();
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 18),
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: color,
        ),
        child: Text(
              texto,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontFamily: 'NeoMedium',
                  fontWeight: FontWeight.w700),
            ),
      ),
    );
  }
}
