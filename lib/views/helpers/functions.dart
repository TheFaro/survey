import 'package:flutter/material.dart';
import 'package:snau_survey/models/models.dart';
import 'package:snau_survey/views/search_delegate/main.dart';
import 'package:snau_survey/views/views.dart';

class Helpers {
  Map<String, String> headers = {'Content-Type': 'application/json'};

  // function to build floating snackBar
  void buildSnackBar(BuildContext context, String message, Color color) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.start,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(15),
        duration: const Duration(seconds: 4),
      ));

  // function to build text form field
  Widget buildTextFormField({
    required BuildContext context,
    String? labelText,
    TextStyle? labelStyle,
    required TextEditingController controller,
    TextStyle? textStyle,
    Widget? prefix,
    Widget? suffix,
    required TextInputType keyboardType,
    OutlineInputBorder? enabledBorder,
    OutlineInputBorder? focusedBorder,
    OutlineInputBorder? errorBorder,
    OutlineInputBorder? border,
    String? helperText,
    TextStyle? helperStyle,
    String? Function(String?)? validator,
    int? maxLength,
    AutovalidateMode? validateMode,
    Widget? suffixIcon,
  }) {
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width * .7,
      child: TextFormField(
        controller: controller,
        style: textStyle,
        keyboardType: keyboardType,
        validator: validator,
        autovalidateMode: validateMode,
        maxLength: maxLength,
        decoration: InputDecoration(
          helperText: helperText,
          helperStyle: helperStyle,
          labelText: labelText,
          labelStyle: labelStyle,
          border: border,
          enabledBorder: enabledBorder,
          focusedBorder: focusedBorder,
          errorBorder: errorBorder,
          prefix: prefix,
          suffix: suffix,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }

  // function to build drop down textview
  Widget buildDropdownField({
    required BuildContext context,
    required String selectedValue,
    final String emptyValue = '',
    required Function setState,
    required List<String> list,
    TextStyle? helperStyle,
    String? helperText,
    String? labelText,
  }) {
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width * .7,
      child: FormField<String>(
        builder: (FormFieldState<String> state) {
          return InputDecorator(
            decoration: InputDecoration(
              helperText: helperText,
              helperStyle: helperStyle,
              labelText: labelText,
              labelStyle:
                  const TextStyle(color: Color.fromRGBO(17, 68, 131, 1)),
              errorStyle: const TextStyle(
                color: Colors.redAccent,
                fontSize: 16,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(
                    width: 1.0, color: Color.fromRGBO(17, 68, 131, 1)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(
                    width: 1.0, color: Color.fromRGBO(17, 68, 131, 1)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    width: 2.0, color: Color.fromRGBO(17, 68, 131, 1)),
                borderRadius: BorderRadius.circular(5),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(width: 1.5, color: Colors.red.shade900),
              ),
            ),
            isEmpty: selectedValue == emptyValue,
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedValue,
                isDense: true,
                onChanged: (String? value) {
                  // setState(() {
                  //   selectedValue = value!;
                  //   state.didChange(value);
                  // });
                  setState(value!);
                  state.didChange(value);
                },
                items: list.map((String value) {
                  return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(
                          color: Color.fromRGBO(17, 68, 131, 1),
                        ),
                      ));
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }

  // function to build data view for farmer variables
  Widget buildDataView({
    required BuildContext context,
    required String label,
    required String data,
  }) {
    double width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Container(
          width: width * .8,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            color: Colors.grey.shade100,
          ),
          child: Wrap(
            direction: Axis.vertical,
            crossAxisAlignment: WrapCrossAlignment.start,
            alignment: WrapAlignment.start,
            children: [
              // title / label
              Padding(
                padding: const EdgeInsets.only(left: 12, top: 12),
                child: Text(
                  label,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ),

              // data
              Padding(
                padding: const EdgeInsets.only(left: 12, bottom: 15),
                child: Text(
                  data,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                  width: 3,
                  color: Color.fromRGBO(17, 68, 131, 1),
                  style: BorderStyle.solid),
            ),
          ),
          width: width * .8,
        ),
      ],
    );
  }

  // function to build dialog to choose between view survey results and take survey
  Future<void> buildSurveyChoiceDialog({
    required BuildContext context,
    required Survey survey,
  }) async {
    double width = MediaQuery.of(context).size.width;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Select Option',
          textAlign: TextAlign.start,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // view survey results button
            Padding(
              padding: const EdgeInsets.all(15),
              child: SizedBox(
                width: width * .65,
                child: MaterialButton(
                  color: Colors.deepOrange,
                  textColor: Colors.white,
                  padding: const EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  elevation: 5,
                  child: const Text(
                    'View Survey Results',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewSurveyListScreen(
                          viewSurvey: true,
                          survey: survey,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 15),

            // take survey
            Padding(
              padding: const EdgeInsets.all(15),
              child: SizedBox(
                width: width * .65,
                child: MaterialButton(
                  color: const Color.fromRGBO(
                    17,
                    68,
                    131,
                    1,
                  ),
                  textColor: Colors.white,
                  padding: const EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  elevation: 5,
                  child: const Text(
                    'Take Survey',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onPressed: () {
                    // TODO : go to take survey view

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewSurveyListScreen(
                          viewSurvey: false,
                          survey: survey,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        elevation: 10,
        actions: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextButton(
              style: TextButton.styleFrom(
                primary: Colors.red.shade600,
              ),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
