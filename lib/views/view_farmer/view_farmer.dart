import 'package:flutter/material.dart';
import 'package:snau_survey/models/models.dart';
import 'package:snau_survey/views/views.dart';

class ViewFarmerView extends StatefulWidget {
  const ViewFarmerView({Key? key, required this.farmer}) : super(key: key);

  final Farmer farmer;

  @override
  _ViewFarmerState createState() => _ViewFarmerState();
}

class _ViewFarmerState extends State<ViewFarmerView>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'View Farmer',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          iconTheme: IconTheme.of(context).copyWith(
            color: Colors.white,
          ),
          backgroundColor: const Color.fromRGBO(17, 68, 131, 1),
          bottom: TabBar(
            controller: tabController,
            tabs: const [
              Tab(
                  icon: Icon(
                    Icons.person_rounded,
                    color: Colors.white,
                  ),
                  text: "Personal"),
              Tab(
                  icon: Icon(Icons.house_rounded, color: Colors.white),
                  text: "Household"),
              Tab(
                  icon:
                      Icon(Icons.account_balance_rounded, color: Colors.white),
                  text: "Banking"),
              Tab(
                  icon: Icon(
                    Icons.card_membership_rounded,
                    color: Colors.white,
                  ),
                  text: "Membership"),
              Tab(
                  icon: Icon(Icons.landscape_rounded, color: Colors.white),
                  text: "Land"),
            ],
            labelStyle: const TextStyle(fontSize: 12.5, color: Colors.white),
            isScrollable: false,
            indicatorColor: Colors.white,
            indicatorWeight: 3,
            labelColor: Colors.white,
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            controller: tabController,
            children: [
              ViewPersonalInfo(
                farmer: widget.farmer,
                tabController: tabController,
              ),
              ViewHouseHold(
                farmer: widget.farmer,
                tabController: tabController,
              ),
              ViewBankingInfo(
                farmer: widget.farmer,
                tabController: tabController,
              ),
              ViewMembershipInfo(
                farmer: widget.farmer,
                tabController: tabController,
              ),
              ViewLandInfo(
                farmer: widget.farmer,
                tabController: tabController,
              ),
            ],
            physics: const NeverScrollableScrollPhysics(),
          ),
        ),
      ),
    );
  }
}
