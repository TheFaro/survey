class Umphakatsi {
  final int id;
  final String region;
  final String constituency;
  final String umphakatsi;

  Umphakatsi({
    required this.id,
    required this.region,
    required this.constituency,
    required this.umphakatsi,
  });

  factory Umphakatsi.fromJson(Map<String, dynamic> json) => Umphakatsi(
        id: json['umphakatsi_id'].toString().isEmpty ||
                json['umphakatsi_id'] == null
            ? -1
            : int.parse(json['umphakatsi_id'].toString()),
        region: json['region'].toString().isEmpty || json['region'] == null
            ? ""
            : json['region'].toString(),
        constituency: json['constituency'].toString().isEmpty ||
                json['constituency'] == null
            ? ""
            : json['constituency'].toString(),
        umphakatsi:
            json['umphakatsi'].toString().isEmpty || json['umphakatsi'] == null
                ? ""
                : json['umphakatsi'].toString(),
      );
}
