final String tableUser = 'user';

class UserFields {
  static final List<String> values = [
    /// Add all fields
    id, username, password, name, profilePicture, backgroundPicture, address
  ];

  static final String id = '_id';
  static final String username = 'username';
  static final String password = 'password';
  static final String name = 'name';
  static final String profilePicture = 'profilePicture';
  static final String backgroundPicture = 'backgroundPicture';
  static final String address = 'address';
}

class User {
  late int _id;
  late String _username;
  late String _password;
  late String name;
  late String profilePicture;
  late String backgroundPicture;
  late String address;

  User(this._username, this._password, this.name, this.profilePicture,
      this.backgroundPicture, this.address);

  User.fromMap(dynamic obj) {
    this._username = obj['username'];
    this._password = obj['password'];
    this.name = obj['name'];
    this.profilePicture = obj['profilePicture'];
    this.backgroundPicture = obj['backgroundPicture'];
    this.address = obj['address'];
  }

  String get username => _username;
  String get password => _password;
  int get id => _id;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["username"] = _username;
    map["password"] = _password;
    map["name"] = name;
    map["profilePicture"] = profilePicture;
    map["backgroundPicture"] = backgroundPicture;
    map["address"] = address;
    return map;
  }
}
