import 'package:flutter/material.dart';
import 'package:gym/domain/models/receta.dart';

class RecataPaginaUsuario extends StatefulWidget {
  final Receta receta;

  const RecataPaginaUsuario({super.key, required this.receta});

  @override
  State<RecataPaginaUsuario> createState() => _RecataPaginaUsuarioState();
}

class _RecataPaginaUsuarioState extends State<RecataPaginaUsuario> {

  @override
  Widget build(BuildContext context) {
      final String _imagen = 'https://firebasestorage.googleapis.com/v0/b/gymapp-991c7.appspot.com/o/${widget.receta.imagen}?alt=media';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(widget.receta.nombre),
      ),
      backgroundColor: Colors.black,
      body: Container(
        child: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              Image.network(_imagen),
              const SizedBox(
                height: 24,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Momento del Día Recomendado",
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
                  widget.receta.horario,
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
                  "Descripción de la Receta",
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
                  widget.receta.descripcion,
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
        )),
      ),
    );
  }
}
