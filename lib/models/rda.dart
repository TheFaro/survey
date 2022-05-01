class RDA {
  final int id;
  final String region;
  final String rda;

  RDA({
    required this.id,
    required this.region,
    required this.rda,
  });

  factory RDA.fromJson(Map<String, dynamic> json) => RDA(
        id: json['id'].toString().isEmpty || json['id'] == null
            ? -1
            : int.parse(json['id'].toString()),
        region: json['region'].toString().isEmpty || json['region'] == null
            ? ""
            : json['region'].toString(),
        rda: json['rda'].toString().isEmpty || json['rda'] == null
            ? ""
            : json['rda'].toString(),
      );
}
