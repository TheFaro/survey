import 'package:flutter/material.dart';
import 'package:snau_survey/models/models.dart';
import 'package:snau_survey/views/views.dart';

class ViewLandInfo extends StatefulWidget {
  const ViewLandInfo(
      {Key? key, required this.farmer, required this.tabController})
      : super(key: key);

  final Farmer farmer;
  final TabController tabController;

  @override
  State<ViewLandInfo> createState() => _ViewLandInfoState();
}

class _ViewLandInfoState extends State<ViewLandInfo> {
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

              // land owned
              Center(
                child: helper.buildDataView(
                  context: context,
                  label: 'Land Owned',
                  data: widget.farmer.landOwned.toString(),
                ),
              ),
              const SizedBox(height: 20),

              // land in production
              Center(
                child: helper.buildDataView(
                  context: context,
                  label: 'Land in Production',
                  data: widget.farmer.productionLand.toString(),
                ),
              ),
              const SizedBox(height: 20),

              // leased land
              Center(
                child: helper.buildDataView(
                  context: context,
                  label: 'Leased Land',
                  data: widget.farmer.leasedLand.toString(),
                ),
              ),
              const SizedBox(height: 20),

              // total land
              Center(
                child: helper.buildDataView(
                  context: context,
                  label: 'Total Land',
                  data: widget.farmer.totalLand.toString(),
                ),
              ),
              const SizedBox(height: 35),

              // back button
              Center(
                child: SizedBox(
                  width: width * .65,
                  child: MaterialButton(
                    textColor: Colors.white,
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    padding: const EdgeInsets.all(20),
                    child: const Text(
                      'Back',
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () {
                      widget.tabController.animateTo(3);
                    },
                    elevation: 10,
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        )),
      ),
    );
  }
}
