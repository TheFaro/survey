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
  // final String domain = "http://localhost:4000/api";
  final String domain = "http://survey.esnaufis.org/api"; // live server
  Helpers helper = Helpers();

  @override
  Future<List<Survey>> getSurveyList({
    required String module,
  }) async {
    Uri? uri;
    if (module == 'enumerator') {
      uri = Uri.parse(domain + '/survey/enuadmin/survey_group');
    } else {
      uri = Uri.parse(domain + '');
    }

    // return generateSurveys();

    try {
      http.Response response = await http.get(uri, headers: helper.headers);
      print(response.body);

      if (response.statusCode == 200) {
        Map res = json.decode(response.body);

        if (res['success'] == 1) {
          List data = res['data'];
          return data.map((e) => Survey.fromJson(e)).toList();
        } else {
          throw Exception('Error occurred while getting $module survey list.');
        }
      } else if (response.statusCode == 404 || response.statusCode == 400) {
        Map res = json.decode(response.body);
        throw Exception(res['message'].toString());
      } else {
        throw Exception('Error occurred while getting $module survey list.');
      }
    } catch (err) {
      throw Exception(err.toString().replaceAll('Exception:', ''));
    }
  }

  @override
  Future<List<Farmer>> getSurveyRespondents({
    required int surveyId,
    required String surveyName,
  }) async {
    Uri uri = Uri.parse(domain + '');

    return getRespondentFarmers();

    // try {
    //   http.Response response = await http.get(uri, headers: helper.headers);
    //   print(response.body);

    //   if (response.statusCode == 200) {
    //     Map res = json.decode(response.body);

    //     if (res['success'] == 1) {
    //       List data = res['data'];

    //       return data.map((e) => Farmer.fromJson(e)).toList();
    //     } else {
    //       throw Exception(
    //           'Error occurred while getting $surveyName survey respondents.');
    //     }
    //   } else if (response.statusCode == 400 || response.statusCode == 404) {
    //     Map res = json.decode(response.body);
    //     throw Exception(res['message'].toString());
    //   } else {
    //     throw Exception(
    //         'Error occurred while getting $surveyName survey respondents.');
    //   }
    // } catch (err) {
    //   throw Exception(err.toString().replaceAll('Exception:', ''));
    // }
  }

  @override
  Future<List<SurveyPage>> getSurveyPages({
    required int surveyId,
  }) async {
    Uri uri = Uri.parse(domain + '');

    return getSurveyPagesDummy();

    // try {
    //   http.Response response = await http.get(uri, headers: helper.headers);
    //   print(response.body);

    //   if (response.statusCode == 200) {
    //     Map res = json.decode(response.body);

    //     if (res['success'] == 1) {
    //       List data = res['data'];
    //       return data.map((e) => SurveyPage.fromJson(e)).toList();
    //     } else {
    //       throw Exception('Error occurred while getting survey pages.');
    //     }
    //   } else if (response.statusCode == 400 || response.statusCode == 404) {
    //     Map res = json.decode(response.body);
    //     throw Exception(res['message'].toString());
    //   } else {
    //     throw Exception('Error occurred while getting survey pages.');
    //   }
    // } catch (err) {
    //   throw Exception(err.toString().replaceAll('Exception:', ''));
    // }
  }

  @override
  Future<List<PageInputs>> getPageInputs({
    required int pageId,
  }) async {
    Uri uri = Uri.parse(domain + '');

    return getPageInputsDummy();
    // try {
    //   http.Response response = await http.get(uri, headers: helper.headers);
    //   print(response.body);

    //   if (response.statusCode == 200) {
    //     Map res = json.decode(response.body);

    //     if (res['success'] == 1) {
    //       List data = res['data'];

    //       return data.map((e) => PageInputs.fromJson(e)).toList();
    //     } else {
    //       throw Exception('Error occurred while getting page inputs.');
    //     }
    //   } else if (response.statusCode == 400 || response.statusCode == 404) {
    //     Map res = json.decode(response.body);
    //     throw Exception(res['message'].toString());
    //   } else {
    //     throw Exception('Error occurred while getting page inputs.');
    //   }
    // } catch (err) {
    //   throw Exception(err.toString().replaceAll('Exception:', ''));
    // }
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

  List<Farmer> getRespondentFarmers() {
    Farmer farmer = Farmer(
      id: 1,
      nationalId: '9607196100302',
      name: 'Fanelesibonge',
      secondName: 'Phiwokuhle',
      surname: 'Malaza',
      gender: 'Male',
      DOB: '19/07/1996',
      phone: '+26878221507',
      nextOfKinPhone: '+26876159059',
      email: 'malazafanelesibonge@gmail.com',
      maritalStatus: 'Single',
      education: 'Tetiary Education',
      region: 'Manzini',
      nearestRDA: 'Ludzeludze',
      constituency: 'Matsapha',
      umphakatsi: 'Zombodze',
      agroZone: 'Middleveld',
      GPSCoordinates: '',
      houseSize: 2,
      ovcs: "0",
      sourceOfLivelihood: "other",
      sourceOfFood: "other",
      sourceOfIncome: "other",
      avgMonthlyIncome: 4000,
      avgMonthlyExpenditure: 4000,
      bankAcc: "yes",
      mobileBank: "yes",
      accessToFunds: "no",
      membershipNumber: "none",
      cardNumber: "none",
      esnauMember: "no",
      affiliation: "none",
      cooperatives: "none",
      association: "none",
      landOwned: 5,
      leasedLand: 6,
      productionLand: 11,
      totalLand: 11,
      address: "P.O. Box 1646 Matsapha",
      captureDate: DateTime.now(),
      nearestTown: "Matsapha",
      profileImage: 'none',
      recordStatus: 'active',
    );

    return List<Farmer>.filled(10, farmer);
  }

  // function to create dummy survey pages data.
  List<SurveyPage> getSurveyPagesDummy() {
    return List.filled(
      3,
      SurveyPage(
        id: -1,
        surveyGroup: -1,
        page: 'survey page name.',
      ),
    );
  }

  // function to create dummy page inputs data
  List<PageInputs> getPageInputsDummy() {
    return List.filled(
      7,
      PageInputs(
        controlId: -1,
        pages: -1,
        name: 'data',
        label: 'Data Label',
        type: 'number',
      ),
    );
  }
}
