import 'dart:ffi';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';

enum Categorias { pintura, limpeza, mecanica, servResidenciais }

class Worker {
  String name;
  double price;
  String? description;
  double? evaluation;
  Categorias category;
  List<String>? previousWorks;
  List<double>? previousEvaluations;

  Worker(this.name, this.category, this.price);
}

List<Worker> WORKERS = [
  Worker("John", Categorias.limpeza, 120.00),
  Worker("joao", Categorias.mecanica, 120.00),
  Worker("gigi", Categorias.pintura, 120.00),
  Worker("carlos", Categorias.servResidenciais, 110.00),
  Worker("leo", Categorias.servResidenciais, 100.00)
];
