import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gym/domain/models/rutina.dart';
import 'package:gym/ui/utils/colors.dart';

class RutinaPage extends StatefulWidget {
  final Dia dia;
  final String imagen;
  const RutinaPage({super.key, required this.dia, required this.imagen});

  @override
  State<RutinaPage> createState() => _RutinaPageState();
}

class _RutinaPageState extends State<RutinaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(widget.dia.nombreRutina),
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          Container(
            width: double.infinity,
            child: Image.asset("assets/images/${widget.imagen}"),
          ),
          const SizedBox(
            height: 24,
          ),
           
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Descripción de la Rutina",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontFamily: 'NeoMedium',
                  fontWeight: FontWeight.w700),
            ),
          ),

          const SizedBox(
            height: 24,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              widget.dia.descripcion,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontFamily: 'NeoRegular',
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Repeticiones",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontFamily: 'NeoMedium',
                  fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              widget.dia.repeticiones,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontFamily: 'NeoRegular',
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),

            ],
          ),
        ),
      ),

    );
  }
}
