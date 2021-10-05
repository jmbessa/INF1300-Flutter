import 'dart:ffi';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';

enum Categorias { pintura, limpeza, mecanica, servResidenciais }

enum Turnos { manha, tarde, noite }

class Worker {
  String name;
  double price;
  List<Turnos> turn;
  String? description;
  double? evaluation;
  Categorias category;

  List<String>? previousWorks;
  List<double>? previousEvaluations;

  Worker(this.name, this.category, this.price, this.evaluation, this.turn);
}

List<Worker> WORKERS = [
  Worker("Pedro Cunha", Categorias.limpeza, 120.00, 4.0,
      [Turnos.manha, Turnos.tarde, Turnos.noite]),
  Worker("Júlia Dias", Categorias.limpeza, 120.00, 4.0,
      [Turnos.tarde, Turnos.noite]),
  Worker("Eduarda Barros", Categorias.limpeza, 120.00, 4.0,
      [Turnos.noite, Turnos.tarde]),
  Worker("José Almeida", Categorias.limpeza, 120.00, 4.0,
      [Turnos.manha, Turnos.noite]),
  Worker("Beatriz Cardoso", Categorias.limpeza, 120.00, 4.0, [Turnos.tarde]),
  Worker("Lucas Pereira", Categorias.limpeza, 120.00, 4.0,
      [Turnos.noite, Turnos.manha]),
  Worker("Rafael Goncalves", Categorias.limpeza, 120.00, 4.0,
      [Turnos.manha, Turnos.noite]),
  Worker("Luís Cavalcanti", Categorias.limpeza, 120.00, 4.0,
      [Turnos.tarde, Turnos.noite]),
  Worker("Júlio Ferreira", Categorias.limpeza, 120.00, 4.0,
      [Turnos.noite, Turnos.manha]),
  Worker("Kauan Barbosa", Categorias.limpeza, 120.00, 4.0,
      [Turnos.manha, Turnos.noite]),
  Worker("Rodrigo Costa", Categorias.mecanica, 120.00, 4.5,
      [Turnos.tarde, Turnos.noite]),
  Worker("Paulo Santos", Categorias.mecanica, 120.00, 4.5,
      [Turnos.noite, Turnos.tarde]),
  Worker("Sarah Pereira", Categorias.mecanica, 120.00, 4.5, [Turnos.manha]),
  Worker("Julieta Fernandes", Categorias.mecanica, 120.00, 4.5, [Turnos.tarde]),
  Worker("Luís Dias", Categorias.mecanica, 120.00, 4.5, [Turnos.noite]),
  Worker("Ana Barbosa", Categorias.mecanica, 120.00, 4.5,
      [Turnos.manha, Turnos.tarde]),
  Worker("Kai Cardoso", Categorias.mecanica, 120.00, 4.5,
      [Turnos.tarde, Turnos.noite]),
  Worker("Evelyn Pinto", Categorias.mecanica, 120.00, 4.5,
      [Turnos.noite, Turnos.manha]),
  Worker("Gustavo Dias", Categorias.mecanica, 120.00, 4.5, [Turnos.manha]),
  Worker("Vitoria Almeida", Categorias.mecanica, 120.00, 4.5, [Turnos.tarde]),
  Worker("Kauê Alves", Categorias.pintura, 120.00, 4.8, [Turnos.noite]),
  Worker("Gustavo Ribeiro", Categorias.pintura, 120.00, 4.8, [Turnos.manha]),
  Worker("Lavinia Almeida", Categorias.pintura, 120.00, 4.8, [Turnos.tarde]),
  Worker("Aline Rodrigues", Categorias.pintura, 120.00, 4.8,
      [Turnos.noite, Turnos.tarde]),
  Worker("Anna Rodrigues", Categorias.pintura, 120.00, 4.8,
      [Turnos.manha, Turnos.tarde]),
  Worker("Júlio Almeida", Categorias.pintura, 120.00, 4.8, [Turnos.tarde]),
  Worker("Vinicius Pereira", Categorias.pintura, 120.00, 4.8,
      [Turnos.noite, Turnos.manha]),
  Worker("Livia Ferreira", Categorias.pintura, 120.00, 4.8,
      [Turnos.manha, Turnos.tarde]),
  Worker("Vitória Castro", Categorias.pintura, 120.00, 4.8, [Turnos.tarde]),
  Worker("Victor Souza", Categorias.pintura, 120.00, 4.8,
      [Turnos.noite, Turnos.tarde]),
  Worker("Eduardo Cardoso", Categorias.servResidenciais, 110.00, 4.2,
      [Turnos.manha]),
  Worker(
      "Luís Almeida", Categorias.servResidenciais, 100.00, 4.7, [Turnos.tarde]),
  Worker("Paulo Cavalcanti", Categorias.servResidenciais, 100.00, 4.7,
      [Turnos.noite]),
  Worker("Estevan Goncalves", Categorias.servResidenciais, 100.00, 4.7,
      [Turnos.manha]),
  Worker("Tomás Fernandes", Categorias.servResidenciais, 100.00, 4.7,
      [Turnos.tarde]),
  Worker(
      "Luis Martins", Categorias.servResidenciais, 100.00, 4.7, [Turnos.noite]),
  Worker("Emily Ferreira", Categorias.servResidenciais, 100.00, 4.7,
      [Turnos.manha]),
  Worker("Kaua Dias", Categorias.servResidenciais, 100.00, 4.7, [Turnos.tarde]),
  Worker(
      "Leila Melo", Categorias.servResidenciais, 100.00, 4.7, [Turnos.noite]),
  Worker(
      "Arthur Costa", Categorias.servResidenciais, 100.00, 4.7, [Turnos.manha]),
];
