final String tableOrder = 'requestOrder';

class OrderFields {
  static final List<String> values = [
    /// Add all fields
    id, userId, workerId, observation, price, address, date, turn
  ];

  static final String id = '_id';
  static final String userId = 'userId';
  static final String workerId = 'workerId';
  static final String observation = 'observation';
  static final String price = 'price';
  static final String address = 'address';
  static final String date = 'date';
  static final String turn = 'turn';
}

class Order {
  int id;
  int userId;
  int workerId;
  String? observation;
  double? price;
  String address;
  String date;
  String turn;

  Order(this.id, this.userId, this.workerId, this.observation, this.price,
      this.address, this.date, this.turn);

  Order copy({
    required int id,
    required int userId,
    required int workerId,
    String? observation,
    required double price,
    required String address,
    required String date,
    required String turn,
  }) =>
      Order(id, userId, workerId, observation, price, address, date, turn);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      OrderFields.id: id,
      OrderFields.userId: userId,
      OrderFields.workerId: workerId,
      OrderFields.observation: observation,
      OrderFields.price: price,
      OrderFields.address: address,
      OrderFields.date: date,
      OrderFields.turn: turn,
    };
    return map;
  }

  static Order fromJson(Map<String, Object?> json) => Order(
      json[OrderFields.id] as int,
      json[OrderFields.userId] as int,
      json[OrderFields.workerId] as int,
      json[OrderFields.observation] as String?,
      json[OrderFields.price] as double,
      json[OrderFields.address] as String,
      json[OrderFields.date] as String,
      json[OrderFields.turn] as String);
}
