import 'package:snau_survey/models/models.dart';

class Survey {
  final int id;
  final String surveyName;
  final String module;
  final String description;
  final DateTime? date;
  List<SurveyPage>? pages;

  Survey({
    required this.id,
    required this.surveyName,
    required this.module,
    required this.description,
    this.date,
  });

  factory Survey.fromJson(Map<String, dynamic> json) => Survey(
        id: json['module_id'].toString().isEmpty || json['module_id'] == null
            ? -1
            : int.parse(json['module_id'].toString()),
        surveyName: json['survey_name'].toString().isEmpty ||
                json['survey_name'] == null
            ? ''
            : json['survey_name'].toString(),
        description: json['description'].toString().isEmpty ||
                json['description'] == null
            ? ''
            : json['description'].toString(),
        module: json['module'].toString().isEmpty || json['module'] == null
            ? ""
            : json['module'].toString(),
        date: json['captured_date'].toString().isEmpty ||
                json['captured_date'] == null
            ? null
            : DateTime.parse(json['captured_date'].toString()),
      );

  Map<String, dynamic> toJson() => {
        'module_id': id,
        'survey_name': surveyName,
        'description': description,
        'module': module,
        'captured_date': date.toString(),
      };
}
