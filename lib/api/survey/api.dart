import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:snau_survey/models/models.dart';
import 'package:snau_survey/views/views.dart';

abstract class SurveyAbstractService {
  Future<List<Survey>> getSurveyList({required String module});
  Future<List<Farmer>> getSurveyRespondents({
    required int surveyId,
    required String surveyName,
  });
  Future<List<SurveyPage>> getSurveyPages({required int surveyId});
  Future<List<PageInputs>> getPageInputs({required int pageId});
}

class SurveyService extends SurveyAbstractService {
  final String domain = "http://localhost:4000/api";
  Helpers helper = Helpers();

  @override
  Future<List<Survey>> getSurveyList({
    required String module,
  }) async {
    Uri uri = Uri.parse(domain + '/');

    return generateSurveys();

    // try {
    //   http.Response response = await http.get(uri, headers: helper.headers);
    //   print(response.body);

    //   if (response.statusCode == 200) {
    //     Map res = json.decode(response.body);

    //     if (res['success'] == 1) {
    //       List data = res['data'];
    //       return data.map((e) => Survey.fromJson(e)).toList();
    //     } else {
    //       throw Exception('Error occurred while getting $module survey list.');
    //     }
    //   } else if (response.statusCode == 404 || response.statusCode == 400) {
    //     Map res = json.decode(response.body);
    //     throw Exception(res['message'].toString());
    //   } else {
    //     throw Exception('Error occurred while getting $module survey list.');
    //   }
    // } catch (err) {
    //   throw Exception(err.toString().replaceAll('Exception:', ''));
    // }
  }

  @override
  Future<List<Farmer>> getSurveyRespondents({
    required int surveyId,
    required String surveyName,
  }) async {
    Uri uri = Uri.parse(domain + '');

    try {
      http.Response response = await http.get(uri, headers: helper.headers);
      print(response.body);

      if (response.statusCode == 200) {
        Map res = json.decode(response.body);

        if (res['success'] == 1) {
          List data = res['data'];

          return data.map((e) => Farmer.fromJson(e)).toList();
        } else {
          throw Exception(
              'Error occurred while getting $surveyName survey respondents.');
        }
      } else if (response.statusCode == 400 || response.statusCode == 404) {
        Map res = json.decode(response.body);
        throw Exception(res['message'].toString());
      } else {
        throw Exception(
            'Error occurred while getting $surveyName survey respondents.');
      }
    } catch (err) {
      throw Exception(err.toString().replaceAll('Exception:', ''));
    }
  }

  @override
  Future<List<SurveyPage>> getSurveyPages({
    required int surveyId,
  }) async {
    Uri uri = Uri.parse(domain + '');

    try {
      http.Response response = await http.get(uri, headers: helper.headers);
      print(response.body);

      if (response.statusCode == 200) {
        Map res = json.decode(response.body);

        if (res['success'] == 1) {
          List data = res['data'];
          return data.map((e) => SurveyPage.fromJson(e)).toList();
        } else {
          throw Exception('Error occurred while getting survey pages.');
        }
      } else if (response.statusCode == 400 || response.statusCode == 404) {
        Map res = json.decode(response.body);
        throw Exception(res['message'].toString());
      } else {
        throw Exception('Error occurred while getting survey pages.');
      }
    } catch (err) {
      throw Exception(err.toString().replaceAll('Exception:', ''));
    }
  }

  @override
  Future<List<PageInputs>> getPageInputs({
    required int pageId,
  }) async {
    Uri uri = Uri.parse(domain + '');

    try {
      http.Response response = await http.get(uri, headers: helper.headers);
      print(response.body);

      if (response.statusCode == 200) {
        Map res = json.decode(response.body);

        if (res['success'] == 1) {
          List data = res['data'];

          return data.map((e) => PageInputs.fromJson(e)).toList();
        } else {
          throw Exception('Error occurred while getting page inputs.');
        }
      } else if (response.statusCode == 400 || response.statusCode == 404) {
        Map res = json.decode(response.body);
        throw Exception(res['message'].toString());
      } else {
        throw Exception('Error occurred while getting page inputs.');
      }
    } catch (err) {
      throw Exception(err.toString().replaceAll('Exception:', ''));
    }
  }

  List<Survey> generateSurveys() {
    return List.filled(
      10,
      Survey(
        id: -1,
        surveyName: 'surveyName',
        description: 'survey description',
        module: 'enumerator',
      ),
    );
  }
}
