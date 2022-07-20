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
        id: json['rda_id'].toString().isEmpty || json['rda_id'] == null
            ? -1
            : int.parse(json['rda_id'].toString()),
        region: json['region'].toString().isEmpty || json['region'] == null
            ? ""
            : json['region'].toString(),
        rda: json['rda'].toString().isEmpty || json['rda'] == null
            ? ""
            : json['rda'].toString(),
      );
}
