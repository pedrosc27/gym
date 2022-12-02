import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:gym/domain/models/datos_usuario.dart';

class EntrenadorDatosUsuarioProvider extends ChangeNotifier {
  List<DatosUsuario> datosUsuarios = [];
  String user = "";

  final rutinaRef = FirebaseFirestore.instance
      .collection('datos')
      .withConverter<DatosUsuario>(
        fromFirestore: (snapshots, _) {
          final rutina = DatosUsuario.fromJson(snapshots.data()!);
          //print('snap id:  ${snapshots.id}');
          final newRutina = rutina;
          return newRutina;
        },
        toFirestore: (rutina, _) => rutina.toJson(),
      );

  void setUser(String userEmail) {
    user = userEmail;
    notifyListeners();
  }
  Future<List<DatosUsuario>>? getUsuario() async {
    final querySnapshot = await rutinaRef.where('email',  isEqualTo: user).get();
    print(querySnapshot.size);
    final persons = querySnapshot.docs.map((e) => e.data()).toList();
    datosUsuarios = persons;
    notifyListeners();
    return persons;
  }

}
