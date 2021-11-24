enum Categorias { pintura, limpeza, mecanica, servResidenciais }

enum Turnos { Manha, Tarde, Noite }

final String tableWorkers = 'workers';
final String tableWorkerTurn = 'workerturn';

class WorkersFields {
  static final List<String> values = [
    /// Add all fields
    id, name, price, turn, description, evaluation, category, previousWorks,
    dates
  ];

  static final String id = '_id';
  static final String name = 'name';
  static final String price = 'price';
  static final String turn = 'turn';
  static final String description = 'description';
  static final String evaluation = 'evaluation';
  static final String category = 'category';
  static final String previousWorks = 'previousWorks';
  static final String dates = 'dates';
}

class Worker {
  int? id;
  String name;
  double? price;
  String turn;
  String? description;
  double? evaluation;
  String? category;
  String? previousWorks;
  String? dates;

  Worker(this.id, this.name, this.price, this.turn, this.description,
      this.evaluation, this.category, this.previousWorks, this.dates);

  Worker copy(
          {int? id,
          required String name,
          double? price,
          String? turn,
          String? description,
          double? evaluation,
          String? category,
          String? previousWorks,
          String? dates}) =>
      Worker(
          id,
          name,
          price ?? this.price,
          turn ?? this.turn,
          description ?? this.description,
          evaluation ?? this.evaluation,
          category ?? this.category,
          previousWorks ?? this.previousWorks,
          dates ?? this.dates);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      WorkersFields.id: id,
      WorkersFields.name: name,
      WorkersFields.price: price,
      WorkersFields.turn: turn,
      WorkersFields.description: description,
      WorkersFields.evaluation: evaluation,
      WorkersFields.category: category,
      WorkersFields.previousWorks: previousWorks,
      WorkersFields.dates: dates,
    };
    return map;
  }

  static Worker fromJson(Map<String, dynamic> json) => Worker(
      json[WorkersFields.id] as int?,
      json[WorkersFields.name] as String,
      json[WorkersFields.price] is int
          ? (json[WorkersFields.price] as int).toDouble()
          : json[WorkersFields.price],
      json[WorkersFields.turn] as String,
      json[WorkersFields.description] as String?,
      json[WorkersFields.evaluation] is int
          ? (json[WorkersFields.evaluation] as int).toDouble()
          : json[WorkersFields.evaluation],
      json[WorkersFields.category] as String?,
      json[WorkersFields.previousWorks] as String?,
      json[WorkersFields.dates] as String?);
}

class WorkersTurnFields {
  static final List<String> values = [
    /// Add all fields
    id, workerId, turnId
  ];

  static final String id = '_id';
  static final String workerId = 'workerId';
  static final String turnId = 'turnId';
}

class WorkerTurn {
  int? id;
  int workerId;
  int turnId;

  WorkerTurn(this.id, this.workerId, this.turnId);

  WorkerTurn copy({
    int? id,
    required int workerId,
    required int turnId,
  }) =>
      WorkerTurn(id, workerId, turnId);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      WorkersTurnFields.id: id,
      WorkersTurnFields.workerId: workerId,
      WorkersTurnFields.turnId: turnId,
    };
    return map;
  }

  static WorkerTurn fromJson(Map<String, dynamic> json) => WorkerTurn(
      json[WorkersTurnFields.id] as int?,
      json[WorkersTurnFields.workerId] as int,
      json[WorkersTurnFields.turnId] as int);
}

/*
List<Worker> WORKERS = [
  Worker(1, "Pedro Cunha", "Categorias.limpeza", 120.00, 4.0,
      "[Turnos.Manha, Turnos.Tarde, Turnos.Noite]"),
];*/
/*
List<Worker> WORKERS = [
  Worker("Pedro Cunha", Categorias.limpeza, 120.00, 4.0,
      [Turnos.Manha, Turnos.Tarde, Turnos.Noite]),
  Worker("Júlia Dias", Categorias.limpeza, 120.00, 4.0,
      [Turnos.Tarde, Turnos.Noite]),
  Worker("Eduarda Barros", Categorias.limpeza, 120.00, 4.0,
      [Turnos.Noite, Turnos.Tarde]),
  Worker("José Almeida", Categorias.limpeza, 120.00, 4.0,
      [Turnos.Manha, Turnos.Noite]),
  Worker("Beatriz Cardoso", Categorias.limpeza, 120.00, 4.0, [Turnos.Tarde]),
  Worker("Lucas Pereira", Categorias.limpeza, 120.00, 4.0,
      [Turnos.Noite, Turnos.Manha]),
  Worker("Rafael Goncalves", Categorias.limpeza, 120.00, 4.0,
      [Turnos.Manha, Turnos.Noite]),
  Worker("Luís Cavalcanti", Categorias.limpeza, 120.00, 4.0,
      [Turnos.Tarde, Turnos.Noite]),
  Worker("Júlio Ferreira", Categorias.limpeza, 120.00, 4.0,
      [Turnos.Noite, Turnos.Manha]),
  Worker("Kauan Barbosa", Categorias.limpeza, 120.00, 4.0,
      [Turnos.Manha, Turnos.Noite]),
  Worker("Rodrigo Costa", Categorias.mecanica, 120.00, 4.5,
      [Turnos.Tarde, Turnos.Noite]),
  Worker("Paulo Santos", Categorias.mecanica, 120.00, 4.5,
      [Turnos.Noite, Turnos.Tarde]),
  Worker("Sarah Pereira", Categorias.mecanica, 120.00, 4.5, [Turnos.Manha]),
  Worker("Julieta Fernandes", Categorias.mecanica, 120.00, 4.5, [Turnos.Tarde]),
  Worker("Luís Dias", Categorias.mecanica, 120.00, 4.5, [Turnos.Noite]),
  Worker("Ana Barbosa", Categorias.mecanica, 120.00, 4.5,
      [Turnos.Manha, Turnos.Tarde]),
  Worker("Kai Cardoso", Categorias.mecanica, 120.00, 4.5,
      [Turnos.Tarde, Turnos.Noite]),
  Worker("Evelyn Pinto", Categorias.mecanica, 120.00, 4.5,
      [Turnos.Noite, Turnos.Manha]),
  Worker("Gustavo Dias", Categorias.mecanica, 120.00, 4.5, [Turnos.Manha]),
  Worker("Vitoria Almeida", Categorias.mecanica, 120.00, 4.5, [Turnos.Tarde]),
  Worker("Kauê Alves", Categorias.pintura, 120.00, 4.8, [Turnos.Noite]),
  Worker("Gustavo Ribeiro", Categorias.pintura, 120.00, 4.8, [Turnos.Manha]),
  Worker("Lavinia Almeida", Categorias.pintura, 120.00, 4.8, [Turnos.Tarde]),
  Worker("Aline Rodrigues", Categorias.pintura, 120.00, 4.8,
      [Turnos.Noite, Turnos.Tarde]),
  Worker("Anna Rodrigues", Categorias.pintura, 120.00, 4.8,
      [Turnos.Manha, Turnos.Tarde]),
  Worker("Júlio Almeida", Categorias.pintura, 120.00, 4.8, [Turnos.Tarde]),
  Worker("Vinicius Pereira", Categorias.pintura, 120.00, 4.8,
      [Turnos.Noite, Turnos.Manha]),
  Worker("Livia Ferreira", Categorias.pintura, 120.00, 4.8,
      [Turnos.Manha, Turnos.Tarde]),
  Worker("Vitória Castro", Categorias.pintura, 120.00, 4.8, [Turnos.Tarde]),
  Worker("Victor Souza", Categorias.pintura, 120.00, 4.8,
      [Turnos.Noite, Turnos.Tarde]),
  Worker("Eduardo Cardoso", Categorias.servResidenciais, 110.00, 4.2,
      [Turnos.Manha]),
  Worker(
      "Luís Almeida", Categorias.servResidenciais, 100.00, 4.7, [Turnos.Tarde]),
  Worker("Paulo Cavalcanti", Categorias.servResidenciais, 100.00, 4.7,
      [Turnos.Noite]),
  Worker("Estevan Goncalves", Categorias.servResidenciais, 100.00, 4.7,
      [Turnos.Manha]),
  Worker("Tomás Fernandes", Categorias.servResidenciais, 100.00, 4.7,
      [Turnos.Tarde]),
  Worker(
      "Luis Martins", Categorias.servResidenciais, 100.00, 4.7, [Turnos.Noite]),
  Worker("Emily Ferreira", Categorias.servResidenciais, 100.00, 4.7,
      [Turnos.Manha]),
  Worker("Kaua Dias", Categorias.servResidenciais, 100.00, 4.7, [Turnos.Tarde]),
  Worker(
      "Leila Melo", Categorias.servResidenciais, 100.00, 4.7, [Turnos.Noite]),
  Worker(
      "Arthur Costa", Categorias.servResidenciais, 100.00, 4.7, [Turnos.Manha]),
];*/
