import 'package:flutter/material.dart';
import 'package:snau_survey/api/api.dart';
import 'package:snau_survey/views/views.dart';

class MembershipInfoView extends StatefulWidget {
  const MembershipInfoView({Key? key, required this.tabController})
      : super(key: key);

  final TabController tabController;

  @override
  _MembershipInfoState createState() => _MembershipInfoState();
}

class _MembershipInfoState extends State<MembershipInfoView> {
  Helpers helper = Helpers();
  RegisterFarmerService service = RegisterFarmerService();

  // member of snau
  List<String> _snauMemberList = ["", "Yes", "No"];
  String _currentSnau = "";

  // affiliation
  List<String> _affiliationList = [
    "",
  ];
  String _currentAffiliations = "";

  TextEditingController cooperative = TextEditingController();
  TextEditingController association = TextEditingController();

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

  // calls to setstate
  void snauCallBack(String value) {
    setState(() {
      _currentSnau = value;
    });
  }

  void affiliationCallBack(String value) {
    setState(() {
      _currentAffiliations = value;
    });
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

                // member of snau
                Center(
                  child: helper.buildDropdownField(
                    context: context,
                    selectedValue: _currentSnau,
                    list: _snauMemberList,
                    setState: snauCallBack,
                    helperText: "Are you a member of SNAU ?",
                    helperStyle: helperStyle,
                    labelText: 'Select Option',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),

                // select affiliation
                Center(
                  child: helper.buildDropdownField(
                    context: context,
                    selectedValue: _currentAffiliations,
                    list: _affiliationList,
                    setState: affiliationCallBack,
                    helperText: "Select if applies",
                    helperStyle: helperStyle,
                    labelText: 'Select Affiliation Membership',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),

                // cooperative
                Center(
                  child: helper.buildTextFormField(
                    context: context,
                    labelText: 'Enter Co-operative',
                    labelStyle: labelStyle,
                    controller: cooperative,
                    textStyle: textStyle,
                    keyboardType: TextInputType.text,
                    enabledBorder: enabledBorder,
                    focusedBorder: focusedBorder,
                    errorBorder: errorBorder,
                    border: border,
                    helperText: 'Enter co-operative',
                    helperStyle: helperStyle,
                  ),
                ),
                const SizedBox(height: 20),

                // association
                Center(
                  child: helper.buildTextFormField(
                    context: context,
                    labelText: 'Enter Association',
                    labelStyle: labelStyle,
                    controller: association,
                    textStyle: textStyle,
                    keyboardType: TextInputType.text,
                    enabledBorder: enabledBorder,
                    focusedBorder: focusedBorder,
                    errorBorder: errorBorder,
                    border: border,
                    helperText: 'Enter association',
                    helperStyle: helperStyle,
                  ),
                ),
                const SizedBox(height: 35),

                // back and next buttons
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
                            widget.tabController.animateTo(2);
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
                              'esnau_member': _currentSnau,
                              'affliation': _currentAffiliations,
                              'cooperatives': cooperative.text.toString(),
                              'association': association.text.toString(),
                            }).then((value) {
                              helper.buildSnackBar(
                                context,
                                value,
                                Colors.green.shade600,
                              );
                              widget.tabController.animateTo(4);
                            }).catchError(
                              (err) {
                                helper.buildSnackBar(
                                  context,
                                  err.toString().replaceAll('Exception:', ''),
                                  Colors.red.shade600,
                                );
                              },
                            );
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
