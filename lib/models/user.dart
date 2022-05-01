class User{

  final int id;
  final String nationalId;
  final String name;
  final String surname;
  final String phone;
  final String email;
  final String gender;
  final String designation;
  final int organization;
  final int level;
  final String verificationCode;
  final String status;

  User({
    required this.id,
    required this.nationalId,
    required this.name,
    required this.surname,
    required this.phone,
    required this.email,
    required this.gender,
    required this.designation,
    required this.organization,
    required this.level,
    required this.verificationCode,
    required this.status,
  });

  factory User.fromJson(Map<String,dynamic> json) => User(
    id: json['id'].toString().isEmpty || json['id'] == null ? -1 : int.parse(json['id'].toString()),
    nationalId: json['nationalid'].toString().isEmpty || json['nationalid'] == null ? '' : json['nationalid'].toString(),
    name: json['name'].toString().isEmpty || json['name'] == null ? '' : json['name'].toString(),
    surname: json['surname'].toString().isEmpty || json['surname'] == null ? '' : json['surname'].toString(),
    phone: json['phone'].toString().isEmpty || json['phone'] == null ? '' : json['phone'].toString(),
    email: json['email'].toString().isEmpty || json['email'] == null ? '' : json['email'].toString(),
    gender: json['gender'].toString().isEmpty || json['gender'] == null ? '' : json['gender'].toString(),
    designation: json['designation'].toString().isEmpty || json['designation'] == null ? '' : json['designation'].toString(),
    organization: json['organization'].toString().isEmpty || json['organization'] == null ? -1 : int.parse(json['organization'].toString()),
    level: json['level'].toString().isEmpty || json['level'] == null ? -1 : int.parse(json['level'].toString()),
    verificationCode: json['verification_code'].toString().isEmpty || json['verification_code'] == null ? '' : json['verification_code'].toString(),
    status: json['status'].toString().isEmpty || json['status'] == null ? '' : json['status'].toString(),
  );

  Map<String,dynamic> toJson() => {
    'id' : id,
    'nationalid': nationalId,
    'name': name,
    'surname': surname,
    'phone' : phone,
    'email' : email,
    'gender' : gender,
    'designation': designation,
    'organization' : organization,
    'level': level,
    'verification_code' : verificationCode,
    'status': status,
  };
}