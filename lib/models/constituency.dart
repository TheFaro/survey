import 'package:snau_survey/models/sqlite/constituency.dart';

class Constituency {
  final int inkhundlaId;
  final String inkhundlaCode;
  final String region;
  final String inkhundla;

  Constituency({
    required this.inkhundlaId,
    required this.inkhundlaCode,
    required this.region,
    required this.inkhundla,
  });

  factory Constituency.fromJson(Map<String, dynamic> json) => Constituency(
        inkhundlaId: json['inkhundla_id'].toString().isEmpty ||
                json['inkhundla_id'] == null
            ? -1
            : int.parse(json['inkhundla_id'].toString()),
        inkhundlaCode:
            json['inkhundla_code'].toString().isEmpty || json['inkhundla_code']
                ? ""
                : json['inkhundla_code'].toString(),
        region: json['region'].toString().isEmpty || json['region'] == null
            ? ""
            : json['region'].toString(),
        inkhundla:
            json['inkhundla'].toString().isEmpty || json['inkhundla'] == null
                ? ""
                : json['inkhundla'].toString(),
      );

  Map<String, dynamic> toMap() => {
        ConstituencyDBHelper.columnInkhundlaId: inkhundlaId,
        ConstituencyDBHelper.columnInkhundlaCode: inkhundlaCode,
        ConstituencyDBHelper.columnRegion: region,
        ConstituencyDBHelper.columnInkhundla: inkhundla,
      };
}
