import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:snau_survey/models/models.dart';

class FarmerDBHelper {
  static final _databaseName = 'farmer.db';
  static final _databaseVersion = 1;
  static final farmerTable = "farmer_list";

  // table column names
  static final columnId = 'id';
  static final columnNationalId = 'nationalid';
  static final columnName = 'name';
  static final columnSecondName = 'secondname';
  static final columnSurname = 'surname';
  static final columnGender = 'gender';
  static final columnDOB = 'date_of_birth';
  static final columnPhoneNumber = 'phone_number';
  static final columnNextOfKin = 'next_of_kin';
  static final columnEmailAddress = 'email_address';
  static final columnMaritalStatus = 'marital_status';
  static final columnLevelOfEducation = 'level_of_education';
  static final columnRegion = 'region';
  static final columnNearestRDA = 'nearest_rda';
  static final columnConstituency = 'constituency';
  static final columnUmphakatsi = 'umphakatsi';
  static final columnAgroEcologicalZone = 'Agro_Ecological_zone';
  static final columnHouseSize = 'house_size';
  static final columnOvcs = 'ovcs';
  static final columnLivelihood = 'main_source_of_livelihood';
  static final columnIncome = 'main_source_income';
  static final columnFood = 'main_source_of_food';
  static final columnAvgIncome = 'average_income';
  static final columnAvgExpenditure = 'average_expenditure';
  static final columnBankAcc = 'bank_acc';
  static final columnMobileBank = 'mobile_bank';
  static final columnAccessToFunds = 'access_to_funds';
  static final columnMembershipNum = 'membership_number';
  static final columnCardNum = 'card_number';
  static final columnEsnauMember = 'esnau_member';
  static final columnAffiliation = 'affiliation';
  static final columnCooperative = 'cooperatives';
  static final columnAssociation = 'association';
  static final columnLandOwned = 'land_owned';
  static final columnLandProduction = 'land_in_production';
  static final columnLeasedLand = 'leased_land';
  static final columnTotalLand = 'total_land';
  static final columnAddress = 'address';
  static final columnCaptureDate = 'capture_date';
  static final columnNearestTown = 'nearest_town';
  static final columnProfileImage = 'profile_image';
  static final columnRecordStatus = 'record_status';

  // make this a singleton class
  FarmerDBHelper._privateConstructor();
  static final FarmerDBHelper instance = FarmerDBHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    return db.execute('''
      CREATE TABLE farmer_list_table (
      $columnId int(11) NOT NULL,
      $columnNationalId varchar(13) NOT NULL,
      $columnName varchar(100) DEFAULT NULL,
      $columnSecondName varchar(100) DEFAULT NULL,
      $columnSurname varchar(100) DEFAULT NULL,
      $columnGender varchar(5) DEFAULT NULL,
      $columnDOB varchar(100) DEFAULT NULL,
      $columnPhoneNumber varchar(100) DEFAULT NULL,
      $columnNextOfKin varchar(100) DEFAULT NULL,
      $columnEmailAddress varchar(100) DEFAULT NULL,
      $columnMaritalStatus varchar(100) DEFAULT NULL,
      $columnLevelOfEducation varchar(100) DEFAULT NULL,
      $columnRegion varchar(100) DEFAULT NULL,
      $columnNearestRDA varchar(100) DEFAULT NULL,
      $columnConstituency varchar(100) DEFAULT NULL,
      $columnUmphakatsi varchar(100) DEFAULT NULL,
      $columnAgroEcologicalZone varchar(100) NOT NULL,
      $columnHouseSize int(11) DEFAULT NULL,
      $columnOvcs varchar(45) DEFAULT NULL,
      $columnLivelihood varchar(100) DEFAULT NULL,
      $columnIncome varchar(100) DEFAULT NULL,
      $columnFood varchar(100) DEFAULT NULL,
      $columnAvgIncome int(11) DEFAULT NULL,
      $columnAvgExpenditure int(11) DEFAULT NULL,
      $columnBankAcc varchar(100) DEFAULT NULL,
      $columnMobileBank varchar(100) DEFAULT NULL,
      $columnAccessToFunds varchar(100) DEFAULT NULL,
      $columnMembershipNum varchar(100) DEFAULT NULL,
      $columnCardNum varchar(100) DEFAULT NULL,
      $columnEsnauMember varchar(100) NOT NULL,
      $columnAffiliation varchar(100) NOT NULL,
      $columnCooperative varchar(100) NOT NULL,
      $columnAssociation varchar(100) NOT NULL,
      $columnLandOwned int(11) DEFAULT NULL,
      $columnLandProduction int(11) DEFAULT NULL,
      $columnLeasedLand int(11) DEFAULT NULL,
      $columnTotalLand int(11) DEFAULT NULL,
      $columnAddress varchar(100) NOT NULL,
      $columnCaptureDate datetime DEFAULT NULL,
      $columnNearestTown varchar(100) NOT NULL,
      $columnProfileImage varchar(100) NOT NULL,
      $columnRecordStatus varchar(100) NOT NULL
  )
    ''');
  }

  Future<void> insertFarmer(Farmer farmer) async {
    final db = await database;
    await db.insert(
      farmerTable,
      farmer.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Farmer>> getFarmers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(farmerTable);
    return List.generate(
      maps.length,
      (index) => Farmer(
        id: maps[index][columnId],
        nationalId: maps[index][columnNationalId],
        name: maps[index][columnName],
        secondName: maps[index][columnSecondName],
        surname: maps[index][columnSurname],
        gender: maps[index][columnGender],
        DOB: maps[index][columnDOB],
        phone: maps[index][columnPhoneNumber],
        nextOfKinPhone: maps[index][columnNextOfKin],
        email: maps[index][columnEmailAddress],
        maritalStatus: maps[index][columnMaritalStatus],
        education: maps[index][columnLevelOfEducation],
        region: maps[index][columnRegion],
        nearestRDA: maps[index][columnNearestRDA],
        constituency: maps[index][columnConstituency],
        umphakatsi: maps[index][columnUmphakatsi],
        agroZone: maps[index][columnAgroEcologicalZone],
        GPSCoordinates: '',
        houseSize: maps[index][columnHouseSize],
        ovcs: maps[index][columnOvcs],
        sourceOfLivelihood: maps[index][columnLivelihood],
        sourceOfFood: maps[index][columnFood],
        sourceOfIncome: maps[index][columnIncome],
        avgMonthlyIncome: maps[index][columnAvgIncome],
        avgMonthlyExpenditure: maps[index][columnAvgExpenditure],
        bankAcc: maps[index][columnBankAcc],
        mobileBank: maps[index][columnMobileBank],
        accessToFunds: maps[index][columnAccessToFunds],
        membershipNumber: maps[index][columnMembershipNum],
        cardNumber: maps[index][columnCardNum],
        esnauMember: maps[index][columnEsnauMember],
        affiliation: maps[index][columnAffiliation],
        cooperatives: maps[index][columnCooperative],
        association: maps[index][columnAssociation],
        landOwned: maps[index][columnLandOwned],
        leasedLand: maps[index][columnLeasedLand],
        productionLand: maps[index][columnLandProduction],
        totalLand: maps[index][columnTotalLand],
        address: maps[index][columnAddress],
        captureDate: maps[index][columnCaptureDate],
        nearestTown: maps[index][columnNearestTown],
        profileImage: maps[index][columnProfileImage],
        recordStatus: maps[index][columnRecordStatus],
      ),
    );
  }

  Future<void> updateFarmer(Farmer farmer) async {
    final db = await database;
    await db.update(
      farmerTable,
      farmer.toMap(),
      where: 'id = ?',
      whereArgs: [farmer.id],
    );
  }

  Future<void> deleteFarmer(int id) async {
    final db = await database;
    await db.delete(
      farmerTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
