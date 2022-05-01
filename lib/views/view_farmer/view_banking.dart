import 'package:flutter/material.dart';
import 'package:snau_survey/models/models.dart';
import 'package:snau_survey/views/views.dart';

class ViewBankingInfo extends StatefulWidget {
  const ViewBankingInfo({
    Key? key,
    required this.farmer,
    required this.tabController,
  }) : super(key: key);

  final Farmer farmer;
  final TabController tabController;

  @override
  State<ViewBankingInfo> createState() => _ViewBankingInfoState();
}

class _ViewBankingInfoState extends State<ViewBankingInfo> {
  Helpers helper = Helpers();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
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
                  child: helper.buildDataView(
                    context: context,
                    label: 'Have a bank account?',
                    data: widget.farmer.bankAcc,
                  ),
                ),
                const SizedBox(height: 20),

                // mobile bank account
                Center(
                  child: helper.buildDataView(
                    context: context,
                    label: 'Have a mobile bank account?',
                    data: widget.farmer.mobileBank,
                  ),
                ),
                const SizedBox(height: 20),

                // access to funds
                Center(
                  child: helper.buildDataView(
                    context: context,
                    label: 'Have access to funds?',
                    data: widget.farmer.accessToFunds,
                  ),
                ),
                const SizedBox(height: 20),

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
                            widget.tabController.animateTo(3);
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
