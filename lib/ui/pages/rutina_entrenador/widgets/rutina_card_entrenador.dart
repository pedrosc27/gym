import 'package:flutter/material.dart';

import 'package:gym/domain/models/rutina.dart';
import 'package:gym/ui/pages/rutina/rutina_page.dart';
import 'package:gym/ui/utils/colors.dart';

class RutinaCardEntrenador extends StatefulWidget {
  final Dia dia;
  final String imagen;
  final String nombre;
  final String repeticiones;
  final bool terminada;

  const RutinaCardEntrenador(
      {super.key,
      required this.dia,
      required this.imagen,
      required this.nombre,
      required this.repeticiones,
      required this.terminada});

  @override
  State<RutinaCardEntrenador> createState() => _RutinaCardEntrenadorState();
}

class _RutinaCardEntrenadorState extends State<RutinaCardEntrenador> {
  late bool isChecked;
  @override
  void initState() {
    super.initState();
    isChecked = widget.terminada;
  }

  void _onVisibleChanged() {
    setState(() {
      isChecked = !isChecked;
    });
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData data = MediaQuery.of(context);
    final Size size = data.size;
    final _width = size.width;
    
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) =>  RutinaPage(dia: widget.dia, imagen: widget.imagen,)));
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                      image: DecorationImage(
                          image: AssetImage(widget.imagen),
                          fit: BoxFit.cover)),
                  width: _width * .15,
                  height: _width * .15,
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(widget.nombre,
                          style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontFamily: 'NeoMedium',
                              fontWeight: FontWeight.w700)),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(widget.repeticiones,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontFamily: 'NeoRegular',
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }
}
