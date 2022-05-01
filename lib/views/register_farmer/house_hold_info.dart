import 'package:flutter/material.dart';
import 'package:snau_survey/api/api.dart';
import 'package:snau_survey/views/views.dart';

class HouseholdInfoView extends StatefulWidget {
  const HouseholdInfoView({Key? key, required this.tabController})
      : super(key: key);

  final TabController tabController;

  @override
  _HouseholdInfoState createState() => _HouseholdInfoState();
}

class _HouseholdInfoState extends State<HouseholdInfoView> {
  Helpers helper = Helpers();
  RegisterFarmerService service = RegisterFarmerService();

  TextEditingController houseSize = TextEditingController();
  TextEditingController ovc = TextEditingController();
  TextEditingController avgMonthlyIncome = TextEditingController();
  TextEditingController avgMonthlyExpenditure = TextEditingController();

  // source of livelihood
  List<String> _livelihoodList = [
    "",
    "Farm Activities",
    "Off Farm Activities",
  ];
  String _currentLivelihood = "";

  // source of income
  List<String> _incomeList = [
    "",
    "Formal Employement",
    "Informal Employment",
    "Farming",
    "None Farm Business",
    "Family Support",
    "Other",
  ];
  String _currentIncome = "";

  // source of food
  List<String> _foodList = [
    "",
    "Own Production",
    "Purchases",
    "Gifts",
    "Labour",
    "Releif",
    "Family",
    "Other",
  ];
  String _currentFood = "";

  // call backs to setstate
  void livelihoodCallBack(String value) {
    setState(() {
      _currentLivelihood = value;
    });
  }

  void incomeCallBack(String value) {
    setState(() {
      _currentIncome = value;
    });
  }

  void foodCallBack(String value) {
    setState(() {
      _currentFood = value;
    });
  }

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

                // house size
                Center(
                  child: helper.buildTextFormField(
                      context: context,
                      labelText: 'House Size',
                      labelStyle: labelStyle,
                      controller: houseSize,
                      textStyle: textStyle,
                      keyboardType: TextInputType.number,
                      enabledBorder: enabledBorder,
                      focusedBorder: focusedBorder,
                      errorBorder: errorBorder,
                      border: border,
                      helperText: 'Enter your house size',
                      helperStyle: helperStyle,
                      validateMode: AutovalidateMode.onUserInteraction,
                      validator: (String? value) {
                        String pattern = r"^[0-9]+";
                        RegExp regExp = RegExp(pattern);

                        if (value!.isNotEmpty && !regExp.hasMatch(value)) {
                          return "House size should be a number";
                        }
                      }),
                ),
                const SizedBox(height: 20),

                // number of OVC
                Center(
                  child: helper.buildTextFormField(
                      context: context,
                      labelText: 'Number of OVC',
                      labelStyle: labelStyle,
                      controller: ovc,
                      textStyle: textStyle,
                      keyboardType: TextInputType.number,
                      enabledBorder: enabledBorder,
                      focusedBorder: focusedBorder,
                      errorBorder: errorBorder,
                      border: border,
                      helperText: 'Enter number of OVC\'s',
                      helperStyle: helperStyle,
                      validateMode: AutovalidateMode.onUserInteraction,
                      validator: (String? value) {
                        String pattern = r"^[0-9]+";
                        RegExp regExp = RegExp(pattern);

                        if (value!.isNotEmpty && !regExp.hasMatch(value)) {
                          return "OVC should be a number";
                        }
                      }),
                ),
                const SizedBox(height: 20),

                // main source of livelihood
                Center(
                  child: helper.buildDropdownField(
                      context: context,
                      selectedValue: _currentLivelihood,
                      list: _livelihoodList,
                      setState: livelihoodCallBack,
                      helperText: 'Select main source of livelihood',
                      helperStyle: helperStyle,
                      labelText: 'Source of Livelihood'),
                ),
                const SizedBox(height: 20),

                // main source of income
                Center(
                  child: helper.buildDropdownField(
                      context: context,
                      selectedValue: _currentIncome,
                      list: _incomeList,
                      setState: incomeCallBack,
                      helperText: 'Select main source of income',
                      helperStyle: helperStyle,
                      labelText: 'Source of Income'),
                ),
                const SizedBox(height: 20),

                // source of food
                Center(
                  child: helper.buildDropdownField(
                      context: context,
                      selectedValue: _currentFood,
                      list: _foodList,
                      setState: foodCallBack,
                      helperText: 'Select main source of food',
                      helperStyle: helperStyle,
                      labelText: 'Source of Food'),
                ),
                const SizedBox(height: 20),

                // average monthly income
                Center(
                  child: helper.buildTextFormField(
                    context: context,
                    labelText: 'Monthly Income',
                    labelStyle: labelStyle,
                    controller: avgMonthlyIncome,
                    textStyle: textStyle,
                    keyboardType: TextInputType.number,
                    enabledBorder: enabledBorder,
                    focusedBorder: focusedBorder,
                    errorBorder: errorBorder,
                    border: border,
                    helperText: 'Enter average monthly income',
                    helperStyle: helperStyle,
                    validateMode: AutovalidateMode.onUserInteraction,
                    validator: (String? value) {
                      String pattern = r"^[0-9]*.[0-9]*$";
                      RegExp regExp = RegExp(pattern);

                      if (value!.isNotEmpty && !regExp.hasMatch(value)) {
                        return "Monthly Income should be a number";
                      }
                    },
                    prefix: Container(
                      color: Colors.grey.shade200,
                      child: const Text(
                        'E ',
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

                // average monthly expenditure
                Center(
                  child: helper.buildTextFormField(
                    context: context,
                    labelText: 'Monthly Expenditure',
                    labelStyle: labelStyle,
                    controller: avgMonthlyExpenditure,
                    textStyle: textStyle,
                    keyboardType: TextInputType.number,
                    enabledBorder: enabledBorder,
                    focusedBorder: focusedBorder,
                    errorBorder: errorBorder,
                    border: border,
                    helperText: 'Enter average monthly expenditure',
                    helperStyle: helperStyle,
                    validateMode: AutovalidateMode.onUserInteraction,
                    validator: (String? value) {
                      String pattern = r"^[0-9]*.[0-9]*$";
                      RegExp regExp = RegExp(pattern);

                      if (value!.isNotEmpty && !regExp.hasMatch(value)) {
                        return "Monthly expenditure should be a number";
                      }
                    },
                    prefix: Container(
                      color: Colors.grey.shade200,
                      child: const Text(
                        'E ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 35),

                // next and back buttons
                Center(
                  child: Wrap(
                    direction: Axis.horizontal,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      // back
                      SizedBox(
                        width: width * .35,
                        child: MaterialButton(
                          textColor: Colors.white,
                          color: Colors.black87,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          padding: const EdgeInsets.all(20),
                          child: const Text(
                            'Back',
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            widget.tabController.animateTo(0);
                          },
                          elevation: 10,
                        ),
                      ),
                      const SizedBox(
                        width: 40,
                      ),

                      // next
                      SizedBox(
                        width: width * .35,
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
                            service.updateFarmer(body: {
                              'house_size':
                                  int.parse(houseSize.text.toString()),
                              'ovcs': ovc.text.toString(),
                              'main_source_of_livelihood': _currentLivelihood,
                              'main_source_of_income': _currentIncome,
                              'main_source_of_food': _currentFood,
                              'average_monthly_income':
                                  avgMonthlyIncome.text.toString(),
                              'average_expenditure':
                                  avgMonthlyExpenditure.text.toString(),
                            }).then((String value) {
                              helper.buildSnackBar(
                                  context, value, Colors.green.shade600);
                              widget.tabController.animateTo(2);
                            }).catchError((err) {
                              helper.buildSnackBar(
                                  context,
                                  err.toString().replaceAll("Exception:", ''),
                                  Colors.red.shade600);
                            });
                          },
                          elevation: 10,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
