import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym/data/preferences.dart';
import 'package:gym/domain/models/receta.dart';
import 'package:shared_preferences/shared_preferences.dart';
class NutriActivaProvider extends ChangeNotifier {
  

  
  final SharedPreferences prefs = LocalStorage.prefs;
  final usuario = LocalStorage.prefs.getString("email");
  String usuario2 = "";

  final recetasRefWhere =
      FirebaseFirestore.instance.collection('recetas').withConverter<Receta>(
            fromFirestore: (snapshots, _) {
              print("Aqui va el Snap: ${snapshots.id}");
              final person = Receta.fromJson(snapshots.data()!);
              final newPerson = person.copyWith(id: snapshots.id);
              return newPerson;
            },
            toFirestore: (person, _) => person.toJson(),
          );

  Stream<List<Receta>> getRecetasUsuarioStream() {
    final result = recetasRefWhere.where('usuario', isEqualTo: usuario2).snapshots().map(
          (event) => event.docs
              .map(
                (e) => e.data(),
              )
              .toList(),
        );
    return result;
  }

  Future<bool> deletePerson(String id) async {
    await recetasRefWhere.doc(id).delete();
    return true;
  }

  void setUsuario2(String usuarioNuevo){
    usuario2 = usuarioNuevo;
    notifyListeners();
  }
  /*void delete(String docId) async {
    await personRepository.deletePerson(docId);
  }*/
}