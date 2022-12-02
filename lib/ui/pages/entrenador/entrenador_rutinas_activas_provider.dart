import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym/domain/models/rutina.dart';

class EntrenadorRutinaActivaProvider extends ChangeNotifier {
  List<Rutina> rutina = [];
  String user = "";
  final rutinaRef =
      FirebaseFirestore.instance.collection('rutinas').withConverter<Rutina>(
            fromFirestore: (snapshots, _) {
              final rutina = Rutina.fromJson(snapshots.data()!);
              print('snap id:  ${snapshots.id}');
              final newRutina = rutina.copyWith(id: snapshots.id);
              return newRutina;
            },
            toFirestore: (rutina, _) => rutina.toJson(),
          );
  void setUser(String userEmail) {
    user = userEmail;
    notifyListeners();
  }

  Future<void> getRecetasUsuarioStream() async {
    final querySnapshot =
        await rutinaRef.where('usuario', isEqualTo: user).get();
    rutina = querySnapshot.docs.map((e) => e.data()).toList();
    notifyListeners();
  }
}
