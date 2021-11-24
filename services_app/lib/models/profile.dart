final String tableProfile = 'profile';

class ProfileFields {
  static final List<String> values = [
    /// Add all fields
    id, name, picture, address
  ];

  static final String id = '_id';
  static final String name = 'name';
  static final String picture = 'picture';
  static final String address = 'address';
}

class Profile {
  int id;
  String name;
  String picture;
  String address;

  Profile(this.id, this.name, this.picture, this.address);

  Profile copy({
    required int id,
    required String name,
    required String picture,
    required String address,
  }) =>
      Profile(id, name, picture, address);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      ProfileFields.id: id,
      ProfileFields.name: name,
      ProfileFields.picture: picture,
      ProfileFields.address: address,
    };
    return map;
  }

  static Profile fromJson(Map<String, Object?> json) => Profile(
      json[ProfileFields.id] as int,
      json[ProfileFields.name] as String,
      json[ProfileFields.picture] as String,
      json[ProfileFields.address] as String);
}
