
import 'package:gym/domain/models/nutriologa_datos.dart';
import 'package:gym/domain/models/receta.dart';
import 'package:gym/domain/models/rutina.dart';
import 'package:gym/domain/models/users.dart';

abstract class UserRepository {
  Future<List<Usuario>>? getUsuario(String email);
  Future<Usuario> registerUser(Usuario usuario);
  Stream<List<Rutina>> getPersonsStream(String usuario);
  Stream<List<Receta>> getRecetasUsuarioStream(String usuario);
  Stream<List<NutriologaDatosModel>> getUsuarioGraficas(String usuario);
  Stream<List<Usuario>> getAllUsers();
  Stream<List<Receta>> getAllRecetas();
   Future<bool> deletePerson(String id);


}
