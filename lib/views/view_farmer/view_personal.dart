import 'package:flutter/material.dart';
import 'package:snau_survey/models/models.dart';
import 'package:snau_survey/views/views.dart';

class ViewPersonalInfo extends StatefulWidget {
  const ViewPersonalInfo(
      {Key? key, required this.farmer, required this.tabController})
      : super(key: key);

  final Farmer farmer;
  final TabController tabController;

  @override
  State<ViewPersonalInfo> createState() => _ViewPersonalInfoState();
}

class _ViewPersonalInfoState extends State<ViewPersonalInfo> {
  Helpers helper = Helpers();
  @override
  void initState() {
    super.initState();
  }

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
                // national id
                Center(
                  child: helper.buildDataView(
                    context: context,
                    label: "National ID",
                    data: widget.farmer.nationalId,
                  ),
                ),
                const SizedBox(height: 20),

                // name
                Center(
                  child: helper.buildDataView(
                    context: context,
                    label: "First Name",
                    data: widget.farmer.name,
                  ),
                ),
                const SizedBox(height: 20),

                // second Name
                Center(
                  child: helper.buildDataView(
                    context: context,
                    label: "Second Name",
                    data: widget.farmer.secondName,
                  ),
                ),
                const SizedBox(height: 20),

                // last name
                Center(
                  child: helper.buildDataView(
                    context: context,
                    label: 'Surname',
                    data: widget.farmer.surname,
                  ),
                ),
                const SizedBox(height: 20),

                // gender
                Center(
                  child: helper.buildDataView(
                    context: context,
                    label: 'Gender',
                    data: widget.farmer.gender,
                  ),
                ),
                const SizedBox(height: 20),

                // date of birth
                Center(
                  child: helper.buildDataView(
                    context: context,
                    label: "Date of Birth",
                    data: widget.farmer.DOB,
                  ),
                ),
                const SizedBox(height: 20),

                // phone
                Center(
                  child: helper.buildDataView(
                    context: context,
                    label: 'Phone Number',
                    data: widget.farmer.phone,
                  ),
                ),
                const SizedBox(height: 20),

                // next of kin phone number
                Center(
                  child: helper.buildDataView(
                    context: context,
                    label: 'Next of Kin Phone',
                    data: widget.farmer.nextOfKinPhone,
                  ),
                ),
                const SizedBox(height: 20),

                // email address
                Center(
                  child: helper.buildDataView(
                    context: context,
                    label: 'Email Address',
                    data: widget.farmer.email,
                  ),
                ),
                const SizedBox(height: 20),

                // marital status
                Center(
                  child: helper.buildDataView(
                    context: context,
                    label: 'Marital Status',
                    data: widget.farmer.maritalStatus,
                  ),
                ),
                const SizedBox(height: 20),

                // level of education
                Center(
                  child: helper.buildDataView(
                    context: context,
                    label: 'Level of Education',
                    data: widget.farmer.education,
                  ),
                ),
                const SizedBox(height: 20),

                // region
                Center(
                  child: helper.buildDataView(
                    context: context,
                    label: 'Region',
                    data: widget.farmer.region,
                  ),
                ),
                const SizedBox(height: 20),

                // nearest rda
                Center(
                  child: helper.buildDataView(
                    context: context,
                    label: 'Nearest RDA',
                    data: widget.farmer.nearestRDA,
                  ),
                ),
                const SizedBox(height: 20),

                // constituency
                Center(
                  child: helper.buildDataView(
                    context: context,
                    label: 'Constituency',
                    data: widget.farmer.constituency,
                  ),
                ),
                const SizedBox(height: 20),

                // umphakatsi
                Center(
                  child: helper.buildDataView(
                    context: context,
                    label: 'Umphakatsi',
                    data: widget.farmer.umphakatsi,
                  ),
                ),
                const SizedBox(height: 20),

                // agro ecological zone
                Center(
                  child: helper.buildDataView(
                    context: context,
                    label: 'Agro Ecological Zone',
                    data: widget.farmer.agroZone,
                  ),
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
                        // TODO: increment tab bar controller index.
                        widget.tabController.animateTo(1);
                      },
                      elevation: 10,
                    ),
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
