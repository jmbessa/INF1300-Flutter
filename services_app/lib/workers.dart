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

  Worker(this.name, this.category, this.price, this.evaluation);
}

List<Worker> WORKERS = [
  Worker("Pedro Cunha", Categorias.limpeza, 120.00, 4.0),
  Worker("Júlia Dias", Categorias.limpeza, 120.00, 4.0),
  Worker("Eduarda Barros", Categorias.limpeza, 120.00, 4.0),
  Worker("José Almeida", Categorias.limpeza, 120.00, 4.0),
  Worker("Beatriz Cardoso", Categorias.limpeza, 120.00, 4.0),
  Worker("Lucas Pereira", Categorias.limpeza, 120.00, 4.0),
  Worker("Rafael Goncalves", Categorias.limpeza, 120.00, 4.0),
  Worker("Luís Cavalcanti", Categorias.limpeza, 120.00, 4.0),
  Worker("Júlio Ferreira", Categorias.limpeza, 120.00, 4.0),
  Worker("Kauan Barbosa", Categorias.limpeza, 120.00, 4.0),
  Worker("Rodrigo Costa", Categorias.mecanica, 120.00, 4.5),
  Worker("Paulo Santos", Categorias.mecanica, 120.00, 4.5),
  Worker("Sarah Pereira", Categorias.mecanica, 120.00, 4.5),
  Worker("Julieta Fernandes", Categorias.mecanica, 120.00, 4.5),
  Worker("Luís Dias", Categorias.mecanica, 120.00, 4.5),
  Worker("Ana Barbosa", Categorias.mecanica, 120.00, 4.5),
  Worker("Kai Cardoso", Categorias.mecanica, 120.00, 4.5),
  Worker("Evelyn Pinto", Categorias.mecanica, 120.00, 4.5),
  Worker("Gustavo Dias", Categorias.mecanica, 120.00, 4.5),
  Worker("Vitoria Almeida", Categorias.mecanica, 120.00, 4.5),
  Worker("Kauê Alves", Categorias.pintura, 120.00, 4.8),
  Worker("Gustavo Ribeiro", Categorias.pintura, 120.00, 4.8),
  Worker("Lavinia Almeida", Categorias.pintura, 120.00, 4.8),
  Worker("Aline Rodrigues", Categorias.pintura, 120.00, 4.8),
  Worker("Anna Rodrigues", Categorias.pintura, 120.00, 4.8),
  Worker("Júlio Almeida", Categorias.pintura, 120.00, 4.8),
  Worker("Vinicius Pereira", Categorias.pintura, 120.00, 4.8),
  Worker("Livia Ferreira", Categorias.pintura, 120.00, 4.8),
  Worker("Vitória Castro", Categorias.pintura, 120.00, 4.8),
  Worker("Victor Souza", Categorias.pintura, 120.00, 4.8),
  Worker("Eduardo Cardoso", Categorias.servResidenciais, 110.00, 4.2),
  Worker("Luís Almeida", Categorias.servResidenciais, 100.00, 4.7),
  Worker("Paulo Cavalcanti", Categorias.servResidenciais, 100.00, 4.7),
  Worker("Estevan Goncalves", Categorias.servResidenciais, 100.00, 4.7),
  Worker("Tomás Fernandes", Categorias.servResidenciais, 100.00, 4.7),
  Worker("Luis Martins", Categorias.servResidenciais, 100.00, 4.7),
  Worker("Emily Ferreira", Categorias.servResidenciais, 100.00, 4.7),
  Worker("Kaua Dias", Categorias.servResidenciais, 100.00, 4.7),
  Worker("Leila Melo", Categorias.servResidenciais, 100.00, 4.7),
  Worker("Arthur Costa", Categorias.servResidenciais, 100.00, 4.7),
];
