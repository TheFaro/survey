import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:snau_survey/models/models.dart';
import 'package:snau_survey/views/views.dart';

abstract class RegisterFarmerAbstractService {
  Future<List<RDA>> getNearestRDA({required String region});
  Future<List<Constituency>> getConstituency({required String region});
  Future<List<Umphakatsi>> getUmphakatsi({
    required String region,
    required String constituencyId,
  });
  Future<Farmer> getFarmer({required String? id});
  Future<List<Farmer>> getFarmers({required String enumeratorId});
  Future<String> registerFarmer({required Map<String, dynamic> body});
  Future<String> updateFarmer({required Map<String, dynamic> body});
}

class RegisterFarmerService extends RegisterFarmerAbstractService {
  final String domain = "http://localhost:4000/api";
  Helpers helper = Helpers();

  @override
  Future<List<RDA>> getNearestRDA({
    required String region,
  }) async {
    Uri uri = Uri.parse(domain + '');

    Map<String, dynamic> body = {
      "region": region.toLowerCase(),
    };

    try {
      http.Response response = await http.post(uri,
          headers: helper.headers, body: json.encode(body));
      print(response.body);

      if (response.statusCode == 200) {
        Map res = json.decode(response.body);

        if (res['success'] == 1) {
          List list = res['data'];

          return list.map((item) => RDA.fromJson(item)).toList();
        } else {
          throw Exception('Error occurred while getting RDA\'s');
        }
      } else {
        Map res = json.decode(response.body);

        throw Exception(res['message']);
      }
    } catch (err) {
      throw Exception(err.toString().replaceAll('Exception:', ''));
    }
  }

  @override
  Future<List<Constituency>> getConstituency({
    required String region,
  }) async {
    Uri uri = Uri.parse(domain + '');

    Map<String, dynamic> body = {'region': region};

    try {
      http.Response response = await http.get(uri, headers: helper.headers);
      print(response.body);

      if (response.statusCode == 200) {
        Map res = json.decode(response.body);

        if (res['success'] == 1) {
          List data = res['data'];

          return data.map((item) => Constituency.fromJson(item)).toList();
        } else {
          throw Exception('Error occurred while getting constituencies.');
        }
      } else {
        Map res = json.decode(response.body);
        throw Exception(res['message'].toString());
      }
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  @override
  Future<List<Umphakatsi>> getUmphakatsi({
    required String region,
    required String constituencyId,
  }) async {
    Uri uri = Uri.parse(domain + '');

    try {
      http.Response response = await http.get(uri, headers: helper.headers);
      print(response.body);

      if (response.statusCode == 200) {
        Map res = json.decode(response.body);

        if (res['success'] == 1) {
          List data = res['data'];

          return data.map((item) => Umphakatsi.fromJson(item)).toList();
        } else {
          throw Exception('Error occurred while retrieving umphakatsi.');
        }
      } else {
        Map res = json.decode(response.body);

        throw Exception(res['message'].toString());
      }
    } catch (err) {
      throw Exception(err.toString().replaceAll('Exception:', ''));
    }
  }

  @override
  Future<Farmer> getFarmer({
    required String? id,
  }) async {
    Uri uri = Uri.parse(domain + '/:id');

    try {
      http.Response response = await http.get(uri, headers: helper.headers);
      print(response.body);

      if (response.statusCode == 200) {
        Map res = json.decode(response.body);
        if (res['success'] == 1) {
          Map<String, dynamic> dat = res['data'];

          return Farmer.fromJson(dat);
        } else {
          throw Exception('Error occurred while retrieving farmer.');
        }
      } else {
        return createFarmer();
        // Map res = json.decode(response.body);
        // throw Exception(res['message']);
      }
    } catch (err) {
      throw Exception(err.toString().replaceAll('Exception:', ''));
    }
  }

  @override
  Future<List<Farmer>> getFarmers({required String enumeratorId}) async {
    Uri uri = Uri.parse(domain + '');

    return getFarmerList();

    // try {
    //   http.Response response = await http.get(uri, headers: helper.headers);
    //   print(response.body);

    //   if (response.statusCode == 200) {
    //     Map res = json.decode(response.body);

    //     if (res['success'] == 1) {
    //       List data = res['farmers'];
    //       return data.map((e) => Farmer.fromJson(e)).toList();
    //     } else {
    //       throw Exception('Error occurred while getting farmer list.');
    //     }
    //   } else {
    //     print('Inside this guy.');

    //     // Map res = json.decode(response.body);
    //     // throw Exception(res['message'].toString());
    //   }
    // } catch (err) {
    //   throw Exception(err.toString().replaceAll('Exception:', ''));
    // }
  }

  @override
  Future<String> registerFarmer({required Map<String, dynamic> body}) async {
    Uri uri = Uri.parse(domain + '');

    try {
      http.Response response = await http.post(uri,
          headers: helper.headers, body: json.encode(body));
      print(response.body);

      if (response.statusCode == 200) {
        Map res = json.decode(response.body);

        if (res['success'] == 1) {
          return res['message'].toString();
        } else {
          throw Exception("Error occurred while registering Farmer.");
        }
      } else {
        Map res = json.decode(response.body);
        throw Exception(res['message'].toString());
      }
    } catch (err) {
      throw Exception(err.toString().replaceAll("Exception:", ""));
    }
  }

  @override
  Future<String> updateFarmer({
    required Map<String, dynamic> body,
  }) async {
    Uri uri = Uri.parse(domain + "");

    try {
      http.Response response =
          await http.put(uri, headers: helper.headers, body: json.encode(body));
      print(response.body);

      if (response.statusCode == 200) {
        Map res = json.decode(response.body);

        if (res['success'] == 1) {
          return res['message'].toString();
        } else {
          throw Exception('Error occurred while updating Farmer data.');
        }
      } else {
        Map res = json.decode(response.body);
        throw Exception(res['message'].toString());
      }
    } catch (err) {
      throw Exception(err.toString().replaceAll('Exception:', ""));
    }
  }

  Farmer createFarmer() {
    return Farmer(
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
  }

  List<Farmer> getFarmerList() {
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
}
