import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:snau_survey/api/api.dart';
import 'package:snau_survey/models/models.dart';
import 'package:snau_survey/views/views.dart';

class PersonalInfoView extends StatefulWidget {
  PersonalInfoView({Key? key, required this.tabController}) : super(key: key);

  TabController tabController;

  @override
  _PersonalInfoState createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfoView> {
  Helpers helper = Helpers();
  final GlobalKey<FormState> _emailKey = GlobalKey<FormState>();
  RegisterFarmerService service = RegisterFarmerService();

  TextEditingController nationalId = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController secondName = TextEditingController();
  TextEditingController surname = TextEditingController();
  TextEditingController dateOfBirth = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController nextOfKinPhone = TextEditingController();
  TextEditingController email = TextEditingController();

  // gender list
  List<String> _genders = ["", "Female", "Male"];
  String _currentGender = "";

  // marital status list
  List<String> _maritalStatusList = [
    "",
    "Single",
    "Married",
    "Divorced",
    "Widowed"
  ];
  String _currentMaritalStatus = "";

  // level of education
  List<String> _educationList = [
    "",
    "No Education",
    "Primary",
    "Secondary",
    "Tertiary",
  ];
  String _currentEducation = "";

  // region
  List<String> _regionList = [
    "",
    "Lubombo",
    "Hhohho",
    "Manzini",
    "Shiselweni",
  ];
  String _currentRegion = "";

  // nearest RDA
  Future<List<String>>? _futureRDAList;
  List<String> _RDAList = [""];
  String _currentRDA = "";

  // select constituency
  late Future<List<String>> _futureConstituency;
  List<String> _constituencyList = [""];
  String _currentConstituency = "";

  // select umphakatsi
  late Future<List<String>> _futureUmphakatsi;
  List<String> _umphakatsiList = [""];
  String _currentUmphakatsi = "";

  // agro ecological zone
  List<String> _agroList = ["", "Lowveld", "Middleveld", "Highveld"];
  String _currentAgro = "";

  // style definitions
  final labelStyle = const TextStyle(
    color: Color.fromRGBO(17, 68, 131, 1),
    fontWeight: FontWeight.w300,
  );

  final helperStyle = TextStyle(
    color: Colors.grey.shade600,
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );

  final textStyle = const TextStyle(
    color: Colors.black,
  );

  final border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
    borderSide:
        const BorderSide(width: 1.0, color: Color.fromRGBO(17, 68, 131, 1)),
  );

  final enabledBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
    borderSide:
        const BorderSide(width: 1.5, color: Color.fromRGBO(17, 68, 131, 1)),
  );

  final focusedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
    borderSide:
        const BorderSide(width: 2.5, color: Color.fromRGBO(17, 68, 131, 1)),
  );

  final errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
    borderSide: BorderSide(width: 1.0, color: Colors.red.shade600),
  );

  String? Function(String?)? emailValidator = (String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";

    RegExp regex = RegExp(pattern);

    if (value == null || value.isEmpty) {
      return "Please enter your email address.";
    } else if (value.isNotEmpty && !regex.hasMatch(value)) {
      return "Please enter a valid email address.";
    }

    return null;
  };

  // callbacks to set state
  void genderCallBack(String value) {
    setState(() {
      _currentGender = value;
    });
  }

  void maritalStatusCallBack(String value) {
    setState(() {
      _currentMaritalStatus = value;
    });
  }

  void educationCallBack(String value) {
    setState(() {
      _currentEducation = value;
    });
  }

  void regionCallBack(String value) {
    setState(() {
      _currentRegion = value;
    });

    // get rda list
    getRDAsFromService();

    // get constituency list
    getConstituencyList();
  }

  Future<void> getRDAsFromService() async {
    // get RDA list
    service.getNearestRDA(region: _currentRegion).then((List<RDA> list) {
      List<String> temp = [];
      for (RDA element in list) {
        temp.add(element.rda);
      }

      setState(() {
        _RDAList.insertAll(1, temp);
      });
    }).catchError((err) {
      helper.buildSnackBar(context, err.toString().replaceAll('Exception:', ''),
          Colors.red.shade400);
    });
  }

  Future<void> getConstituencyList() async {
    service
        .getConstituency(region: _currentRegion)
        .then((List<Constituency> list) {
      List<String> temp = [];
      for (Constituency element in list) {
        temp.add(element.inkhundla);
      }

      setState(() {
        _constituencyList.insertAll(1, temp);
      });
    }).catchError((err) {
      helper.buildSnackBar(context, err.toString().replaceAll('Exception:', ''),
          Colors.red.shade400);
    });
  }

  void RDACallBack(String value) {
    setState(() {
      _currentRDA = value;
    });
  }

  void constituencyCallBack(String value) {
    setState(() {
      _currentConstituency = value;
    });
  }

  void umphakatsiCallBack(String value) {
    setState(() {
      _currentUmphakatsi = value;
    });
  }

  void agroCallBack(String value) {
    setState(() {
      _currentAgro = value;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: width,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  // enter national id
                  Center(
                    child: helper.buildTextFormField(
                      context: context,
                      controller: nationalId,
                      labelText: 'National Id',
                      labelStyle: labelStyle,
                      textStyle: textStyle,
                      keyboardType: TextInputType.number,
                      enabledBorder: enabledBorder,
                      focusedBorder: focusedBorder,
                      border: border,
                      errorBorder: errorBorder,
                      helperStyle: helperStyle,
                      helperText: 'Enter your National Id',
                      maxLength: 13,
                      validator: (String? value) {
                        String pattern = r"^[0-9]+$";
                        RegExp regex = RegExp(pattern);
                        if (value!.isEmpty) {
                          return 'National Id is required';
                        } else if (value.isNotEmpty && !regex.hasMatch(value)) {
                          return "Incorrect value for National Id";
                        }

                        return null;
                      },
                      validateMode: AutovalidateMode.onUserInteraction,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // name
                  Center(
                    child: helper.buildTextFormField(
                      context: context,
                      controller: name,
                      labelText: 'First Name',
                      labelStyle: labelStyle,
                      textStyle: textStyle,
                      keyboardType: TextInputType.name,
                      enabledBorder: enabledBorder,
                      border: border,
                      focusedBorder: focusedBorder,
                      errorBorder: errorBorder,
                      helperStyle: helperStyle,
                      helperText: 'Enter your first name',
                      maxLength: 20,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'First name is required';
                        }

                        return null;
                      },
                      validateMode: AutovalidateMode.onUserInteraction,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // second name
                  Center(
                    child: helper.buildTextFormField(
                      context: context,
                      controller: secondName,
                      labelText: 'Second Name',
                      labelStyle: labelStyle,
                      textStyle: textStyle,
                      keyboardType: TextInputType.name,
                      border: border,
                      enabledBorder: enabledBorder,
                      focusedBorder: focusedBorder,
                      errorBorder: errorBorder,
                      helperStyle: helperStyle,
                      helperText: 'Enter your second name',
                      maxLength: 20,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // surname
                  Center(
                    child: helper.buildTextFormField(
                      context: context,
                      controller: surname,
                      labelText: 'Surname',
                      labelStyle: labelStyle,
                      textStyle: textStyle,
                      keyboardType: TextInputType.name,
                      border: border,
                      enabledBorder: enabledBorder,
                      focusedBorder: focusedBorder,
                      errorBorder: errorBorder,
                      helperText: 'Enter your surname',
                      helperStyle: helperStyle,
                      maxLength: 20,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Surname is required';
                        }

                        return null;
                      },
                      validateMode: AutovalidateMode.onUserInteraction,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  // select gender
                  Center(
                    child: helper.buildDropdownField(
                      context: context,
                      selectedValue: _currentGender,
                      emptyValue: _genders[0],
                      setState: genderCallBack,
                      list: _genders,
                      helperText: 'Select your gender',
                      helperStyle: helperStyle,
                      labelText: 'Gender',
                    ),
                  ),
                  const SizedBox(height: 20),

                  // date of birth
                  Center(
                    child: SizedBox(
                      width: width * .7,
                      child: TextFormField(
                        controller: dateOfBirth,
                        onTap: () {
                          DatePicker.showDatePicker(
                            context,
                            showTitleActions: true,
                            minTime: DateTime(1980, 1, 1),
                            maxTime: DateTime(2050, 12, 31),
                            onConfirm: (date) {
                              dateOfBirth.text =
                                  DateFormat('y/M/d').format(date);
                            },
                            onChanged: (date) {
                              dateOfBirth.text =
                                  DateFormat('y/M/d').format(date);
                            },
                          );
                        },
                        style: textStyle,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'Date of Birth',
                          labelStyle: labelStyle,
                          helperText: 'Enter your date of birth',
                          helperStyle: helperStyle,
                          border: border,
                          enabledBorder: enabledBorder,
                          focusedBorder: focusedBorder,
                          errorBorder: errorBorder,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // phone number
                  Center(
                    child: helper.buildTextFormField(
                      context: context,
                      controller: phoneNumber,
                      labelText: 'Phone Number',
                      labelStyle: labelStyle,
                      textStyle: textStyle,
                      keyboardType: TextInputType.phone,
                      border: border,
                      enabledBorder: enabledBorder,
                      focusedBorder: focusedBorder,
                      errorBorder: errorBorder,
                      helperText: 'Enter your phone number',
                      helperStyle: helperStyle,
                      maxLength: 8,
                      prefix: Container(
                        color: Colors.grey.shade200,
                        child: const Text(
                          '+268 ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // next of kin
                  Center(
                    child: helper.buildTextFormField(
                      context: context,
                      controller: phoneNumber,
                      labelText: 'Next of Kin Phone Number',
                      labelStyle: labelStyle,
                      textStyle: textStyle,
                      keyboardType: TextInputType.phone,
                      border: border,
                      enabledBorder: enabledBorder,
                      focusedBorder: focusedBorder,
                      errorBorder: errorBorder,
                      helperText: 'Enter next of kin phone number',
                      helperStyle: helperStyle,
                      maxLength: 8,
                      prefix: Container(
                        color: Colors.grey.shade200,
                        child: const Text(
                          '+268 ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // email
                  Center(
                    child: Form(
                      key: _emailKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: helper.buildTextFormField(
                        context: context,
                        controller: email,
                        labelText: 'Email Address',
                        labelStyle: labelStyle,
                        textStyle: textStyle,
                        keyboardType: TextInputType.emailAddress,
                        border: border,
                        enabledBorder: enabledBorder,
                        focusedBorder: focusedBorder,
                        errorBorder: errorBorder,
                        helperText: 'Enter your email address',
                        helperStyle: helperStyle,
                        validator: (String? value) {
                          String pattern =
                              r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                              r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                              r"{0,253}[a-zA-Z0-9])?)*$";

                          RegExp regex = RegExp(pattern);

                          if (value == null || value.isEmpty) {
                            return "Please enter your email address.";
                          } else if (value.isNotEmpty &&
                              !regex.hasMatch(value)) {
                            return "Please enter a valid email address.";
                          }

                          return null;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // marital status
                  Center(
                    child: helper.buildDropdownField(
                        context: context,
                        selectedValue: _currentMaritalStatus,
                        list: _maritalStatusList,
                        setState: maritalStatusCallBack,
                        helperStyle: helperStyle,
                        helperText: 'Select your marital status',
                        labelText: 'Marital Status'),
                  ),
                  const SizedBox(height: 20),

                  // level of education
                  Center(
                    child: helper.buildDropdownField(
                      context: context,
                      selectedValue: _currentEducation,
                      list: _educationList,
                      setState: educationCallBack,
                      helperText: 'Select your education level',
                      helperStyle: helperStyle,
                      labelText: 'Education Level',
                    ),
                  ),
                  const SizedBox(height: 20),

                  // region
                  Center(
                    child: helper.buildDropdownField(
                      context: context,
                      selectedValue: _currentRegion,
                      list: _regionList,
                      setState: regionCallBack,
                      helperText: 'Select your region',
                      helperStyle: helperStyle,
                      labelText: 'Region',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  // nearest rda
                  Center(
                    child: helper.buildDropdownField(
                      context: context,
                      selectedValue: _currentRDA,
                      list: _RDAList,
                      setState: RDACallBack,
                      helperText: 'Select your nearest RDA',
                      helperStyle: helperStyle,
                      labelText: 'Nearest RDA',
                    ),
                  ),
                  const SizedBox(height: 20),

                  // constituency
                  Center(
                    child: helper.buildDropdownField(
                      context: context,
                      selectedValue: _currentConstituency,
                      list: _constituencyList,
                      setState: constituencyCallBack,
                      helperText: 'Select your constituency',
                      helperStyle: helperStyle,
                      labelText: 'Constituency',
                    ),
                  ),
                  const SizedBox(height: 20),

                  // umphakatsi
                  Center(
                    child: helper.buildDropdownField(
                      context: context,
                      selectedValue: _currentUmphakatsi,
                      list: _umphakatsiList,
                      setState: umphakatsiCallBack,
                      helperText: 'Select your umphakatsi',
                      helperStyle: helperStyle,
                      labelText: 'Umphakatsi',
                    ),
                  ),
                  const SizedBox(height: 20),

                  // agro ecological zone
                  Center(
                    child: helper.buildDropdownField(
                        context: context,
                        selectedValue: _currentAgro,
                        list: _agroList,
                        setState: agroCallBack,
                        helperText: 'Select your agro ecological zone',
                        helperStyle: helperStyle,
                        labelText: 'Agro Ecological Zone'),
                  ),
                  const SizedBox(height: 35),

                  // next button
                  Center(
                    child: SizedBox(
                      width: width * .65,
                      child: MaterialButton(
                        textColor: Colors.white,
                        color: const Color.fromRGBO(17, 68, 131, 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        padding: const EdgeInsets.all(20),
                        child: const Text(
                          'Next',
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () {
                          // send personal data to database.
                          service.registerFarmer(body: {
                            'nationalid': nationalId.text.toString(),
                            'name': name.text.toString(),
                            'secondname': secondName.text.toString(),
                            'surname': surname.text.toString(),
                            'gender': _currentGender,
                            'date_of_birth': dateOfBirth.text.toString(),
                            'phone_number': phoneNumber.text.toString(),
                            'next_of_kin': nextOfKinPhone.text.toString(),
                            'email_address': email.text.toString(),
                            'marital_status': _currentMaritalStatus,
                            'level_of_education': _currentEducation,
                            'region': _currentRegion,
                            'nearest_rda': _currentRDA,
                            'constituency': _currentConstituency,
                            'umphakatsi': _currentUmphakatsi,
                            'Agro_Ecological_zone': _currentAgro,
                          }).then((String value) {
                            helper.buildSnackBar(
                              context,
                              value,
                              Colors.green.shade600,
                            );
                            widget.tabController.animateTo(1);
                          }).catchError((err) {
                            helper.buildSnackBar(
                              context,
                              err.toString().replaceAll('Exception:', ''),
                              Colors.red.shade600,
                            );
                          });
                        },
                        elevation: 10,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ]),
          ),
        ),
      ),
    );
  }
}
