import 'package:gym/domain/models/rutina.dart';

class RutinaIndex{
  final Rutina rutina;
  Dia? dia;
  final int index;

  RutinaIndex({
    this.dia,
    required this.rutina,
    required this.index
  });
}