class Organization{

  final int id;
  final String name;
  final String phone;
  final String email;

  Organization({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
  });

  factory Organization.fromJson(Map<String,dynamic> json) => Organization(
    id: json['id'].toString().isEmpty || json['id'] == null ? -1 : int.parse(json['id'].toString()),
    name: json['name'].toString().isEmpty || json['name'] == null ? '' : json['name'].toString(),
    phone: json['phone'].toString().isEmpty || json['phone'] == null ? '' : json['phone'].toString(),
    email: json['email'].toString().isEmpty || json['email'] == null ? '' : json['email'].toString(),
  );

  Map<String,dynamic> toJson() => {
    'id': id,
    'name' : name,
    'phone' : phone,
    'email' : email,
  };
}