enum Turnos { Manha, Tarde, Noite }

final String tableTurn = 'turn';

class TurnFields {
  static final List<String> values = [
    /// Add all fields
    id, description
  ];

  static final String id = '_id';
  static final String description = 'description';
}

class Turn {
  int id;
  String description;

  Turn(this.id, this.description);

  Turn copy({
    required int id,
    required String description,
  }) =>
      Turn(id, description);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic> {
      TurnFields.id: id,
      TurnFields.description: description,
    };
    return map;
  }

  static Turn fromJson(Map<String, Object?> json) => Turn(
      json[TurnFields.id] as int,
      json[TurnFields.description] as String);
}

//List<Turn> TURN = [
//  Turn(1,"Manha"),
//  Turn(2,"Tarde"),
//  Turn(3,"Noite"),
//];
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
