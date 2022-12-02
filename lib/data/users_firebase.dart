import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym/domain/models/nutriologa_datos.dart';
import 'package:gym/domain/models/receta.dart';
import 'package:gym/domain/models/rutina.dart';
import 'package:gym/domain/models/users.dart';
import 'package:gym/domain/repository/users_repository.dart';

class UserFirebase implements UserRepository {
  final personRef =
      FirebaseFirestore.instance.collection('users').withConverter<Usuario>(
            fromFirestore: (snapshots, _) {
              final person = Usuario.fromJson(snapshots.data()!);
              //final newPerson = person.copyWith(id: snapshots.id);
              return person;
            },
            toFirestore: (person, _) => person.toJson(),
          );
  final personRefWhere =
      FirebaseFirestore.instance.collection('users').withConverter<Usuario>(
            fromFirestore: (snapshots, _) {
              final person = Usuario.fromJson(snapshots.data()!);
              //final newPerson = person.copyWith(id: snapshots.id);
              return person;
            },
            toFirestore: (person, _) => person.toJson(),
          );

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

  final recetasRefWhere =
      FirebaseFirestore.instance.collection('recetas').withConverter<Receta>(
            fromFirestore: (snapshots, _) {
              
              final person = Receta.fromJson(snapshots.data()!);   
             
              final newPerson = person.copyWith(id: snapshots.id);
              return newPerson;
            },
            toFirestore: (receta, _) => receta.toJson(),
          );

  final graficasRedWhere = FirebaseFirestore.instance
      .collection('datosnutriologa')
      .withConverter<NutriologaDatosModel>(
        fromFirestore: (snapshots, _) {
          final person = NutriologaDatosModel.fromJson(snapshots.data()!);
          //final newPerson = person.copyWith(id: snapshots.id);
          return person;
        },
        toFirestore: (person, _) => person.toJson(),
      );

  @override
  Future<List<Usuario>>? getUsuario(String email) async {
    final querySnapshot =
        await personRefWhere.where('email', isEqualTo: email).get();
    final persons = querySnapshot.docs.map((e) => e.data()).toList();
    return persons;
  }

  @override
  Future<Usuario> registerUser(Usuario usuario) async {
    final result = await personRef.add(usuario);
    return usuario;
  }

  @override
  Stream<List<Rutina>> getPersonsStream(String usuario) {
    final result =
        rutinaRef.where('usuario', isEqualTo: usuario).snapshots().map(
              (event) => event.docs
                  .map(
                    (e)  {
                       final eNew = e.data().copyWith(id: e.id);
                      return eNew;
                      },
                  )
                  .toList(),
            );
    return result;
  }
  @override
  Future<bool> deletePerson(String id) async {
    await recetasRefWhere.doc(id).delete();
    return true;
  }

  @override
  Stream<List<Receta>> getRecetasUsuarioStream(String usuario) {
    
    final result =
        recetasRefWhere.where('usuario', isEqualTo: usuario).snapshots().map(
              (event) => event.docs
                  .map(
                    (e)  {
                      
                       final eNew = e.data().copyWith(id: e.id);
                      return eNew;
                      },
                  )
                  .toList(),
            );
    return result;
  }

  @override
  Stream<List<NutriologaDatosModel>> getUsuarioGraficas(String usuario) {
    final result = graficasRedWhere
        .where('usuario', isEqualTo: usuario)
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map(
          (event) => event.docs
              .map(
                (e) => e.data(),
              )
              .toList(),
        );
    return result;
  }

  @override
  Stream<List<Usuario>> getAllUsers() {
    final result =
        personRefWhere.where('tipo', isEqualTo: "usuario").snapshots().map(
              (event) => event.docs
                  .map(
                    (e) => e.data(),
                  )
                  .toList(),
            );
    return result;
  }

  @override
  Stream<List<Receta>> getAllRecetas() {
    final result =
        recetasRefWhere.where('tipo', isEqualTo: "usuario").snapshots().map(
              (event) => event.docs
                  .map(
                    (e) => e.data(),
                  )
                  .toList(),
            );
    return result;
  }
}
