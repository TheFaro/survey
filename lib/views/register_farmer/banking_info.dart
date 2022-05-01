import 'package:flutter/material.dart';
import 'package:snau_survey/api/api.dart';
import 'package:snau_survey/views/views.dart';

class BankingInfoView extends StatefulWidget {
  const BankingInfoView({Key? key, required this.tabController})
      : super(key: key);

  final TabController tabController;

  @override
  _BankingInfoState createState() => _BankingInfoState();
}

class _BankingInfoState extends State<BankingInfoView> {
  Helpers helper = Helpers();
  RegisterFarmerService service = RegisterFarmerService();

  // bank account
  List<String> _bankList = ["", "Yes", "No"];
  String _currentBank = "";

  // mobile bank account
  List<String> _mobileBankList = ["", "Yes", "No"];
  String _currentMobileBank = "";

  // access to funds
  List<String> _fundsList = ["", "Yes", "No"];
  String _currentFunds = "";

  // call backs to set state
  void bankCallBack(String value) {
    setState(() {
      _currentBank = value;
    });
  }

  void mobileCallBack(String value) {
    setState(() {
      _currentMobileBank = value;
    });
  }

  void fundsCallBack(String value) {
    setState(() {
      _currentFunds = value;
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

                // bank account
                Center(
                  child: helper.buildDropdownField(
                    context: context,
                    selectedValue: _currentBank,
                    list: _bankList,
                    setState: bankCallBack,
                    helperText: 'Do you have a bank account ?',
                    helperStyle: helperStyle,
                    labelText: 'Have bank account ?',
                  ),
                ),
                const SizedBox(height: 20),

                // mobile bank account
                Center(
                  child: helper.buildDropdownField(
                    context: context,
                    selectedValue: _currentMobileBank,
                    list: _mobileBankList,
                    setState: mobileCallBack,
                    helperText: 'Do you have a mobile bank account ?',
                    helperStyle: helperStyle,
                    labelText: 'Have mobile bank account ?',
                  ),
                ),
                const SizedBox(height: 20),

                // access to funds
                Center(
                  child: helper.buildDropdownField(
                    context: context,
                    selectedValue: _currentFunds,
                    list: _fundsList,
                    setState: fundsCallBack,
                    helperText: 'Do you have access to funds ?',
                    helperStyle: helperStyle,
                    labelText: 'Have access to funds ?',
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
                            widget.tabController.animateTo(1);
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
                              'bank_acc': _currentBank,
                              'mobile_bank': _currentMobileBank,
                              'access_to_funds': _currentFunds,
                            }).then((value) {
                              helper.buildSnackBar(
                                context,
                                value,
                                Colors.green.shade600,
                              );
                              widget.tabController.animateTo(3);
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
