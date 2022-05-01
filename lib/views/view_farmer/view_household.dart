import 'package:flutter/material.dart';
import 'package:snau_survey/models/models.dart';
import 'package:snau_survey/views/views.dart';

class ViewHouseHold extends StatefulWidget {
  const ViewHouseHold(
      {Key? key, required this.farmer, required this.tabController})
      : super(key: key);

  final Farmer farmer;
  final TabController tabController;

  @override
  State<ViewHouseHold> createState() => _ViewHouseHoldState();
}

class _ViewHouseHoldState extends State<ViewHouseHold> {
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

                // house size
                Center(
                  child: helper.buildDataView(
                    context: context,
                    label: 'House Size',
                    data: widget.farmer.houseSize.toString(),
                  ),
                ),
                const SizedBox(height: 20),

                // ovcs
                Center(
                  child: helper.buildDataView(
                    context: context,
                    label: 'Number of OVCs',
                    data: widget.farmer.ovcs,
                  ),
                ),
                const SizedBox(height: 20),

                // main source of livelihood
                Center(
                  child: helper.buildDataView(
                    context: context,
                    label: 'Source of livelihood',
                    data: widget.farmer.sourceOfLivelihood,
                  ),
                ),
                const SizedBox(height: 20),

                // main source of income
                Center(
                  child: helper.buildDataView(
                    context: context,
                    label: 'Source of income',
                    data: widget.farmer.sourceOfIncome,
                  ),
                ),
                const SizedBox(height: 20),

                // main source of food
                Center(
                  child: helper.buildDataView(
                    context: context,
                    label: 'Source of Food',
                    data: widget.farmer.sourceOfFood,
                  ),
                ),
                const SizedBox(height: 20),

                // average monthly income
                Center(
                  child: helper.buildDataView(
                    context: context,
                    label: 'Average Monthly Income',
                    data: widget.farmer.avgMonthlyIncome
                        .toDouble()
                        .toStringAsFixed(2),
                  ),
                ),
                const SizedBox(height: 20),

                // average monthly expenditure
                Center(
                  child: helper.buildDataView(
                    context: context,
                    label: 'Average Monthly Expenditure',
                    data: widget.farmer.avgMonthlyExpenditure
                        .toDouble()
                        .toStringAsFixed(2),
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
                            widget.tabController.animateTo(2);
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
