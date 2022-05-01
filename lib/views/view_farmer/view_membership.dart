import 'package:flutter/material.dart';
import 'package:snau_survey/models/models.dart';
import 'package:snau_survey/views/views.dart';

class ViewMembershipInfo extends StatefulWidget {
  const ViewMembershipInfo({
    Key? key,
    required this.farmer,
    required this.tabController,
  }) : super(key: key);

  final Farmer farmer;
  final TabController tabController;
  @override
  State<ViewMembershipInfo> createState() => _ViewMembershipInfoState();
}

class _ViewMembershipInfoState extends State<ViewMembershipInfo> {
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

                // member of snau
                Center(
                  child: helper.buildDataView(
                    context: context,
                    label: 'Are you a member of SNAU?',
                    data: widget.farmer.esnauMember,
                  ),
                ),
                const SizedBox(height: 20),

                // select affiliation
                Center(
                  child: helper.buildDataView(
                    context: context,
                    label: 'Affiliation',
                    data: widget.farmer.affiliation,
                  ),
                ),
                const SizedBox(height: 20),

                // cooperative
                Center(
                  child: helper.buildDataView(
                    context: context,
                    label: 'Cooperative',
                    data: widget.farmer.cooperatives,
                  ),
                ),
                const SizedBox(height: 20),

                // association
                Center(
                  child: helper.buildDataView(
                    context: context,
                    label: 'Association',
                    data: widget.farmer.association,
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
                            widget.tabController.animateTo(4);
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
