import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gym/domain/models/datos_usuario.dart';
import 'package:gym/ui/pages/entrenador/entrenador_datos_usuario_provider.dart';
import 'package:gym/ui/utils/colors.dart';
import 'package:provider/provider.dart';

class PaginaDatosUsuario extends StatefulWidget {
  const PaginaDatosUsuario({super.key});

  @override
  State<PaginaDatosUsuario> createState() => _PaginaDatosUsuarioState();
}

class _PaginaDatosUsuarioState extends State<PaginaDatosUsuario> {
  late DatosUsuario? usuario;
  @override
  void initState() {
    super.initState();
    getRtuinasActivas();
  }

  Future<void> getRtuinasActivas() async {
    final entrenadorProvider = context.read<EntrenadorDatosUsuarioProvider>();
    final rutinaLen = entrenadorProvider.getUsuario();
  }

  Widget build(BuildContext context) {
    final rutinas = context.watch<EntrenadorDatosUsuarioProvider>();
    final rutinasActivas = rutinas.datosUsuarios;
    print('usuario en el provider :${rutinas.user}');
    print('rutina lenght sss:  ${rutinasActivas.length}');
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SafeArea(
          child: SingleChildScrollView(
            child: rutinasActivas.isEmpty
                ? const Center(
                    child: Text(
                      "Aún no hay datos de este usuario",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'NeoMedium',
                          fontWeight: FontWeight.w700),
                    ),
                  )
                : Datos(usuario: rutinasActivas[0]),
          ),
        ),
      ),
    );
  }
}

class Datos extends StatelessWidget {
  const Datos({
    Key? key,
    required this.usuario,
  }) : super(key: key);

  final DatosUsuario? usuario;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 32,
        ),
        const Text(
          "Datos del Usuario ",
          style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'NeoMedium',
              fontWeight: FontWeight.w700),
        ),
        const SizedBox(
          height: 16,
        ),
        const Text(
          "Nombre",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontFamily: 'NeoRegular',
              fontWeight: FontWeight.w700),
        ),
        const SizedBox(
          height: 15.0,
        ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.only(top: 20, bottom: 20, left: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: degradado),
          child: Text(
            usuario!.nombre,
            style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontFamily: 'NeoRegular',
                fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        const Text(
          "Apellido",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontFamily: 'NeoRegular',
              fontWeight: FontWeight.w700),
        ),
        const SizedBox(
          height: 15.0,
        ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.only(top: 20, bottom: 20, left: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: degradado),
          child: Text(
            usuario!.apellido,
            style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontFamily: 'NeoRegular',
                fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        const Text(
          "Sexo",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontFamily: 'NeoRegular',
              fontWeight: FontWeight.w700),
        ),
        const SizedBox(
          height: 15.0,
        ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.only(top: 20, bottom: 20, left: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: degradado),
          child: Text(
            usuario!.sexo,
            style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontFamily: 'NeoRegular',
                fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        const Text(
          "Email",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontFamily: 'NeoRegular',
              fontWeight: FontWeight.w700),
        ),
        const SizedBox(
          height: 15.0,
        ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.only(top: 20, bottom: 20, left: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: degradado),
          child: Text(
            usuario!.email,
            style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontFamily: 'NeoRegular',
                fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        const Text(
          "Edad",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontFamily: 'NeoRegular',
              fontWeight: FontWeight.w700),
        ),
        const SizedBox(
          height: 15.0,
        ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.only(top: 20, bottom: 20, left: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: degradado),
          child: Text(
            usuario!.edad,
            style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontFamily: 'NeoRegular',
                fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        const Text(
          "Estatura",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontFamily: 'NeoRegular',
              fontWeight: FontWeight.w700),
        ),
        const SizedBox(
          height: 15.0,
        ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.only(top: 20, bottom: 20, left: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: degradado),
          child: Text(
            usuario!.estatura,
            style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontFamily: 'NeoRegular',
                fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        const Text(
          "Peso",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontFamily: 'NeoRegular',
              fontWeight: FontWeight.w700),
        ),
        const SizedBox(
          height: 15.0,
        ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.only(top: 20, bottom: 20, left: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: degradado),
          child: Text(
            usuario!.peso,
            style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontFamily: 'NeoRegular',
                fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        const Text(
          "Deporte",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontFamily: 'NeoRegular',
              fontWeight: FontWeight.w700),
        ),
        const SizedBox(
          height: 15.0,
        ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.only(top: 20, bottom: 20, left: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: degradado),
          child: Text(
            usuario!.deporte,
            style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontFamily: 'NeoRegular',
                fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        const Text(
          "Discapacidad",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontFamily: 'NeoRegular',
              fontWeight: FontWeight.w700),
        ),
        const SizedBox(
          height: 15.0,
        ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.only(top: 20, bottom: 20, left: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: degradado),
          child: Text(
            usuario!.discapacidad,
            style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontFamily: 'NeoRegular',
                fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        const Text(
          "Alergia",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontFamily: 'NeoRegular',
              fontWeight: FontWeight.w700),
        ),
        const SizedBox(
          height: 15.0,
        ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.only(top: 20, bottom: 20, left: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: degradado),
          child: Text(
            usuario!.alergia,
            style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontFamily: 'NeoRegular',
                fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        const Text(
          "Meta",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontFamily: 'NeoRegular',
              fontWeight: FontWeight.w700),
        ),
        const SizedBox(
          height: 15.0,
        ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.only(top: 20, bottom: 20, left: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: degradado),
          child: Text(
            usuario!.goal,
            style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontFamily: 'NeoRegular',
                fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(
          height: 40,
        )
      ],
    );
  }
}
