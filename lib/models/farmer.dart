import 'package:snau_survey/models/sqlite/farmer_db.dart';

class Farmer {
  final int id;
  final String nationalId;
  final String name;
  final String secondName;
  final String surname;
  final String gender;
  final String DOB;
  final String phone;
  final String nextOfKinPhone;
  final String email;
  final String maritalStatus;
  final String education;
  final String region;
  final String nearestRDA;
  final String constituency;
  final String umphakatsi;
  final String agroZone;
  final String GPSCoordinates;
  final int houseSize;
  final String ovcs;
  final String sourceOfLivelihood;
  final String sourceOfIncome;
  final String sourceOfFood;
  final int avgMonthlyIncome;
  final int avgMonthlyExpenditure;
  final String bankAcc;
  final String mobileBank;
  final String accessToFunds;
  final String membershipNumber;
  final String cardNumber;
  final String esnauMember;
  final String affiliation;
  final String cooperatives;
  final String association;
  final int landOwned;
  final int leasedLand;
  final int productionLand;
  final int totalLand;
  final String address;
  final DateTime? captureDate;
  final String nearestTown;
  final String profileImage;
  final String recordStatus;

  Farmer({
    required this.id,
    required this.nationalId,
    required this.name,
    required this.secondName,
    required this.surname,
    required this.gender,
    required this.DOB,
    required this.phone,
    required this.nextOfKinPhone,
    required this.email,
    required this.maritalStatus,
    required this.education,
    required this.region,
    required this.nearestRDA,
    required this.constituency,
    required this.umphakatsi,
    required this.agroZone,
    required this.GPSCoordinates,
    required this.houseSize,
    required this.ovcs,
    required this.sourceOfLivelihood,
    required this.sourceOfFood,
    required this.sourceOfIncome,
    required this.avgMonthlyIncome,
    required this.avgMonthlyExpenditure,
    required this.bankAcc,
    required this.mobileBank,
    required this.accessToFunds,
    required this.membershipNumber,
    required this.cardNumber,
    required this.esnauMember,
    required this.affiliation,
    required this.cooperatives,
    required this.association,
    required this.landOwned,
    required this.leasedLand,
    required this.productionLand,
    required this.totalLand,
    required this.address,
    required this.captureDate,
    required this.nearestTown,
    required this.profileImage,
    required this.recordStatus,
  });

  factory Farmer.fromJson(Map<String, dynamic> json) => Farmer(
        id: json['id'].toString().isEmpty || json['id'] == null
            ? -1
            : int.parse(json['id'].toString()),
        nationalId:
            json['nationalid'].toString().isEmpty || json['nationalid'] == null
                ? ""
                : json['nationalid'].toString(),
        name: json['name'].toString().isEmpty || json['name'] == null
            ? ""
            : json['name'].toString(),
        secondName:
            json['secondname'].toString().isEmpty || json['secondname'] == null
                ? ""
                : json['secondname'].toString(),
        surname: json['surname'].toString().isEmpty || json['surname'] == null
            ? ""
            : json['surname'].toString(),
        gender: json['gender'].toString().isEmpty || json['gender'] == null
            ? ""
            : json['gender'].toString(),
        DOB: json['date_of_birth'].toString().isEmpty ||
                json['date_of_birth'] == null
            ? ""
            : json['date_of_birth'].toString(),
        phone: json['phone_number'].toString().isEmpty ||
                json['phone_number'] == null
            ? ""
            : json['phone_number'].toString(),
        nextOfKinPhone: json['next_of_kin'].toString().isEmpty ||
                json['next_of_kin'] == null
            ? ""
            : json['next_of_kin'].toString(),
        email: json['email_address'].toString().isEmpty ||
                json['email_address'] == null
            ? ""
            : json['email_address'].toString(),
        maritalStatus: json['marital_status'].toString().isEmpty ||
                json['marital_status'] == null
            ? ""
            : json['marital_status'].toString(),
        education: json['level_of_education'].toString().isEmpty ||
                json['level_of_education'] == null
            ? ''
            : json['level_of_education'].toString(),
        region: json['region'].toString().isEmpty || json['region'] == null
            ? ""
            : json['region'].toString(),
        nearestRDA: json['nearest_rda'].toString().isEmpty ||
                json['nearest_rda'] == null
            ? ""
            : json['nearest_rda'].toString(),
        constituency: json['constituency'].toString().isEmpty ||
                json['constituency'] == null
            ? ""
            : json['constituency'].toString(),
        umphakatsi:
            json['umphakatsi'].toString().isEmpty || json['umphakatsi'] == null
                ? ""
                : json['umphakatsi'].toString(),
        agroZone: json['Agro_Ecological_zone'].toString().isEmpty ||
                json['Agro_Ecological_zone'] == null
            ? ""
            : json['Agro_Ecological_zone'].toString(),
        GPSCoordinates: json['GPS_Coordinates'].toString().isEmpty ||
                json['GPS_Coordinates'] == null
            ? ""
            : json['GPS_Coordinates'].toString(),
        houseSize:
            json['house_size'].toString().isEmpty || json['house_size'] == null
                ? -1
                : int.parse(json['house_size'].toString()),
        ovcs: json['ovcs'].toString().isEmpty || json['ovcs'] == null
            ? ""
            : json['ovcs'].toString(),
        sourceOfLivelihood:
            json['main_source_of_livelihood'].toString().isEmpty ||
                    json['main_source_of_livelihood'] == null
                ? ""
                : json['main_source_of_livelihood'].toString(),
        sourceOfFood: json['main_source_of_food'].toString().isEmpty ||
                json['main_source_of_food'] == null
            ? ""
            : json['main_source_of_food'].toString(),
        sourceOfIncome: json['main_source_income'].toString().isEmpty ||
                json['main_source_food'] == null
            ? ""
            : json['main_source_food'].toString(),
        avgMonthlyIncome: json['average_monthly_income'].toString().isEmpty ||
                json['average_monthly_income'] == null
            ? -1
            : int.parse(json['average_monthly_income'].toString()),
        avgMonthlyExpenditure:
            json['average_monthly_expenditure'].toString().isEmpty ||
                    json['average_monthly_expenditure'] == null
                ? -1
                : int.parse(json['average_monthly_expenditure'].toString()),
        bankAcc: json['bank_acc'].toString().isEmpty || json['bank_acc'] == null
            ? ""
            : json['bank_acc'].toString(),
        mobileBank: json['mobile_bank'].toString().isEmpty ||
                json['mobile_bank'] == null
            ? ""
            : json['mobile_bank'].toString(),
        accessToFunds: json['access_to_funds'].toString().isEmpty ||
                json['access_to_funds'] == null
            ? ""
            : json['access_to_funds'].toString(),
        membershipNumber: json['membership_number'].toString().isEmpty ||
                json['membership_number'] == null
            ? ""
            : json['membership_number'].toString(),
        cardNumber: json['card_number'].toString().isEmpty ||
                json['card_number'] == null
            ? ""
            : json['card_number'].toString(),
        esnauMember: json['esnau_member'].toString().isEmpty ||
                json['esnau_member'] == null
            ? ""
            : json['esnau_member'].toString(),
        affiliation: json['affiliation'].toString().isEmpty ||
                json['affiliation'] == null
            ? ""
            : json['affiliation'].toString(),
        cooperatives: json['cooperatives'].toString().isEmpty ||
                json['cooperatives'] == null
            ? ""
            : json['cooperatives'].toString(),
        association: json['association'].toString().isEmpty ||
                json['association'] == null
            ? ""
            : json['association'].toString(),
        landOwned:
            json['land_owned'].toString().isEmpty || json['land_owned'] == null
                ? -1
                : int.parse(json['land_owned'].toString()),
        leasedLand: json['leased_land'].toString().isEmpty ||
                json['leased_land'] == null
            ? -1
            : int.parse(json['leased_land'].toString()),
        productionLand: json['land_in_production'].toString().isEmpty ||
                json['land_in_production'] == null
            ? -1
            : int.parse(json['land_in_production'].toString()),
        totalLand:
            json['total_land'].toString().isEmpty || json['total_land'] == null
                ? -1
                : int.parse(json['total_land'].toString()),
        address: json['address'].toString().isEmpty || json['address'] == null
            ? ''
            : json['address'].toString(),
        captureDate: json['capture_date'].toString().isEmpty ||
                json['capture_date'] == null
            ? null
            : DateTime.parse(json['capture_date'].toString()),
        nearestTown: json['nearest_town'].toString().isEmpty ||
                json['nearest_town'] == null
            ? ""
            : json['nearest_town'].toString(),
        profileImage: json['profile_image'].toString().isEmpty ||
                json['profile_image'] == null
            ? ""
            : json['profile_image'].toString(),
        recordStatus: json['record_status'].toString().isEmpty ||
                json['record_status'] == null
            ? ""
            : json['record_status'].toString(),
      );

  Map<String, dynamic> toMap() => {
        FarmerDBHelper.columnId: id,
        FarmerDBHelper.columnNationalId: nationalId,
        FarmerDBHelper.columnName: name,
        FarmerDBHelper.columnSecondName: secondName,
        FarmerDBHelper.columnSurname: surname,
        FarmerDBHelper.columnGender: gender,
        FarmerDBHelper.columnDOB: DOB,
        FarmerDBHelper.columnPhoneNumber: phone,
        FarmerDBHelper.columnNextOfKin: nextOfKinPhone,
        FarmerDBHelper.columnEmailAddress: email,
        FarmerDBHelper.columnMaritalStatus: maritalStatus,
        FarmerDBHelper.columnLevelOfEducation: education,
        FarmerDBHelper.columnRegion: region,
        FarmerDBHelper.columnNearestRDA: nearestRDA,
        FarmerDBHelper.columnConstituency: constituency,
        FarmerDBHelper.columnUmphakatsi: umphakatsi,
        FarmerDBHelper.columnAgroEcologicalZone: agroZone,
        FarmerDBHelper.columnHouseSize: houseSize,
        FarmerDBHelper.columnOvcs: ovcs,
        FarmerDBHelper.columnLivelihood: sourceOfLivelihood,
        FarmerDBHelper.columnIncome: sourceOfIncome,
        FarmerDBHelper.columnFood: sourceOfFood,
        FarmerDBHelper.columnAvgIncome: avgMonthlyIncome,
        FarmerDBHelper.columnAvgExpenditure: avgMonthlyExpenditure,
        FarmerDBHelper.columnBankAcc: bankAcc,
        FarmerDBHelper.columnMobileBank: mobileBank,
        FarmerDBHelper.columnAccessToFunds: accessToFunds,
        FarmerDBHelper.columnMembershipNum: membershipNumber,
        FarmerDBHelper.columnCardNum: cardNumber,
        FarmerDBHelper.columnEsnauMember: esnauMember,
        FarmerDBHelper.columnAffiliation: affiliation,
        FarmerDBHelper.columnCooperative: cooperatives,
        FarmerDBHelper.columnAssociation: association,
        FarmerDBHelper.columnLandOwned: landOwned,
        FarmerDBHelper.columnLandProduction: productionLand,
        FarmerDBHelper.columnLeasedLand: leasedLand,
        FarmerDBHelper.columnTotalLand: totalLand,
        FarmerDBHelper.columnAddress: address,
        FarmerDBHelper.columnCaptureDate: captureDate.toString(),
        FarmerDBHelper.columnNearestTown: nearestTown,
        FarmerDBHelper.columnProfileImage: profileImage,
        FarmerDBHelper.columnRecordStatus: recordStatus,
      };
}
