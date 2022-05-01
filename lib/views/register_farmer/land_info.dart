import 'package:flutter/material.dart';
import 'package:snau_survey/api/api.dart';
import 'package:snau_survey/models/models.dart';
import 'package:snau_survey/views/views.dart';

class LandInfoView extends StatefulWidget {
  const LandInfoView({Key? key, required this.user}) : super(key: key);

  final User user;
  @override
  _LandInfoState createState() => _LandInfoState();
}

class _LandInfoState extends State<LandInfoView> {
  Helpers helper = Helpers();
  RegisterFarmerService service = RegisterFarmerService();

  TextEditingController owned = TextEditingController();
  TextEditingController production = TextEditingController();
  TextEditingController leased = TextEditingController();
  TextEditingController total = TextEditingController();

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

                  // land owned
                  Center(
                    child: helper.buildTextFormField(
                      context: context,
                      labelText: 'Enter Land Owned',
                      labelStyle: labelStyle,
                      controller: owned,
                      textStyle: textStyle,
                      keyboardType: TextInputType.number,
                      enabledBorder: enabledBorder,
                      focusedBorder: focusedBorder,
                      errorBorder: errorBorder,
                      border: border,
                      helperText: 'Enter land owned',
                      helperStyle: helperStyle,
                      prefix: Container(
                        color: Colors.grey.shade200,
                        child: const Text(
                          'Ha ',
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

                  // production land
                  Center(
                    child: helper.buildTextFormField(
                      context: context,
                      labelText: 'Enter Land in Production',
                      labelStyle: labelStyle,
                      controller: production,
                      textStyle: textStyle,
                      keyboardType: TextInputType.number,
                      enabledBorder: enabledBorder,
                      focusedBorder: focusedBorder,
                      errorBorder: errorBorder,
                      border: border,
                      helperText: 'Enter land in production',
                      helperStyle: helperStyle,
                      prefix: Container(
                        color: Colors.grey.shade200,
                        child: const Text(
                          'Ha ',
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

                  // leased land
                  Center(
                    child: helper.buildTextFormField(
                      context: context,
                      labelText: 'Enter Leased Land',
                      labelStyle: labelStyle,
                      controller: leased,
                      textStyle: textStyle,
                      keyboardType: TextInputType.number,
                      enabledBorder: enabledBorder,
                      focusedBorder: focusedBorder,
                      errorBorder: errorBorder,
                      border: border,
                      helperText: 'Enter leased land',
                      helperStyle: helperStyle,
                      prefix: Container(
                        color: Colors.grey.shade200,
                        child: const Text(
                          'Ha ',
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

                  // total land
                  Center(
                    child: helper.buildTextFormField(
                      context: context,
                      labelText: 'Enter Total Land',
                      labelStyle: labelStyle,
                      controller: total,
                      textStyle: textStyle,
                      keyboardType: TextInputType.number,
                      enabledBorder: enabledBorder,
                      focusedBorder: focusedBorder,
                      errorBorder: errorBorder,
                      border: border,
                      helperText: 'Enter total land',
                      helperStyle: helperStyle,
                      prefix: Container(
                        color: Colors.grey.shade200,
                        child: const Text(
                          'Ha ',
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

                  // finish button
                  Center(
                    child: SizedBox(
                      width: width * .65,
                      child: MaterialButton(
                        textColor: Colors.white,
                        color: Colors.green.shade600,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        padding: const EdgeInsets.all(20),
                        child: const Text(
                          'Finish',
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () {
                          service.updateFarmer(body: {
                            'land_owned': int.parse(owned.text.toString()),
                            'land_in_production':
                                int.parse(production.text.toString()),
                            'leased_land': int.parse(leased.text.toString()),
                            'total_land': int.parse(total.text.toString()),
                          }).then((value) {
                            helper.buildSnackBar(
                                context, value, Colors.green.shade600);
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        EnumeratorHomeView(
                                          user: widget.user,
                                        )),
                                (Route<dynamic> route) => false);
                          }).catchError((err) {
                            helper.buildSnackBar(
                                context,
                                err.toString().replaceAll('Exception:', ''),
                                Colors.red.shade600);
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
