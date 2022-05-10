import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class PageInputs {
  final int controlId;
  final int pages;
  final String name;
  final String label;
  final String type;
  String? data;

  PageInputs({
    required this.controlId,
    required this.pages,
    required this.name,
    required this.label,
    required this.type,
  });

  factory PageInputs.fromJson(Map<String, dynamic> json) => PageInputs(
        controlId:
            json['control_id'].toString().isEmpty || json['control_id'] == null
                ? -1
                : int.parse(json['control_id'].toString()),
        pages: json['pages'].toString().isEmpty || json['pages'] == null
            ? -1
            : int.parse(json['pages'].toString()),
        name: json['name'].toString().isEmpty || json['name'] == null
            ? ''
            : json['name'].toString(),
        label: json['label'].toString().isEmpty || json['label'] == null
            ? ''
            : json['label'].toString(),
        type: json['type'].toString().isEmpty || json['type'] == null
            ? ''
            : json['type'].toString(),
      );

  Map<String, dynamic> toJson() => {
        'control_id': controlId,
        'pages': pages,
        'name': name,
        'label': label,
        'type': type,
      };

  // Widget definitions for creating page input widgets.
  // Function to create the single input text widget
  Widget buildSingleInput({
    required BuildContext context,
  }) {
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width * .7,
      child: TextFormField(
        keyboardType: TextInputType.text,
        onChanged: (String? value) {
          data = value;
        },
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            color: Color.fromRGBO(17, 68, 131, 1),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              width: 1,
              color: Color.fromRGBO(17, 68, 131, 1),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              width: 1.5,
              color: Color.fromRGBO(17, 68, 131, 1),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              width: 2,
              color: Color.fromRGBO(17, 68, 131, 1),
            ),
          ),
        ),
      ),
    );
  }

  // Function to create the single input number widget
  Widget buildNumberInput({
    required BuildContext context,
  }) {
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width * .7,
      child: TextFormField(
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        ],
        onChanged: (String? value) {
          data = value;
        },
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            color: Color.fromRGBO(17, 68, 131, 1),
          ),
          helperText: 'Enter numbers only!',
          helperStyle: TextStyle(
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w700,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              width: 1,
              color: Color.fromRGBO(17, 68, 131, 1),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              width: 1.5,
              color: Color.fromRGBO(17, 68, 131, 1),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              width: 2,
              color: Color.fromRGBO(17, 68, 131, 1),
            ),
          ),
        ),
      ),
    );
  }

  // Function to create the DateTime widget
  Widget buildDateInput({
    required BuildContext context,
  }) {
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width * .7,
      child: TextFormField(
        keyboardType: TextInputType.datetime,
        onChanged: (String? value) {
          data = value;
        },
        onTap: () {
          DatePicker.showDatePicker(
            context,
            minTime: DateTime(1990, 1, 1),
            maxTime: DateTime(2050, 12, 31),
            onChanged: (DateTime? date) {
              data = date.toString();
            },
          );
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              width: 1,
              color: Color.fromRGBO(17, 68, 131, 1),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              width: 1.5,
              color: Color.fromRGBO(17, 68, 131, 1),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              width: 2,
              color: Color.fromRGBO(17, 68, 131, 1),
            ),
          ),
        ),
      ),
    );
  }

  // Function to create the text area widget
  Widget buildTextAreaInput({
    required BuildContext context,
  }) {
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width * .7,
      child: TextFormField(
        keyboardType: TextInputType.text,
        onChanged: (String? value) {
          data = value;
        },
        maxLength: 500,
        maxLines: 10,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            color: Color.fromRGBO(17, 68, 131, 1),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              width: 1,
              color: Color.fromRGBO(17, 68, 131, 1),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              width: 1.5,
              color: Color.fromRGBO(17, 68, 131, 1),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              width: 2,
              color: Color.fromRGBO(17, 68, 131, 1),
            ),
          ),
        ),
      ),
    );
  }
}
