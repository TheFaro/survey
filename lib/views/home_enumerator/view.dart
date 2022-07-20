import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:snau_survey/api/api.dart';
import 'package:snau_survey/models/models.dart';
import 'package:snau_survey/views/views.dart';

class EnumeratorHomeView extends StatefulWidget {
  const EnumeratorHomeView({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  _EnumeratorHomeState createState() => _EnumeratorHomeState();
}

class _EnumeratorHomeState extends State<EnumeratorHomeView> {
  AccessService accessService = AccessService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Home: Enumerator',
          textAlign: TextAlign.start,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        iconTheme: IconTheme.of(context).copyWith(
          color: Colors.white,
        ),
        backgroundColor: const Color.fromRGBO(17, 68, 131, 1),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: width,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // demographics
                  // TODO: total

                  // TODO: females

                  // TODO: males

                  // actions : buttons
                  const SizedBox(height: 40),
                  Center(
                    child: GestureDetector(
                      child: Card(
                        color: Colors.white,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Container(
                          width: width * .5,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: const EdgeInsets.all(12),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // icon
                                Icon(
                                  Icons.edit,
                                  color: Colors.green.shade600,
                                ),
                                const SizedBox(width: 30),

                                // text
                                const Text(
                                  'Register Farmer',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ]),
                        ),
                      ),
                      onTap: () {
                        // go to register farmer view
                        Navigator.push(
                            context,
                            PageTransition(
                                child: RegisterFarmerView(user: widget.user),
                                type: PageTransitionType.rightToLeftWithFade));
                      },
                    ),
                  ),
                  const SizedBox(height: 25),

                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            child: const ViewFarmersListView(),
                            type: PageTransitionType.fade,
                          ),
                        );
                      },
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Container(
                          width: width * .5,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // icon
                              Icon(
                                Icons.edit_rounded,
                                color: Colors.blue.shade400,
                              ),
                              const SizedBox(width: 30),

                              //text
                              const Text(
                                'View Farmer',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),

                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                              child: SurveyListView(user: widget.user),
                              type: PageTransitionType.leftToRight),
                        );
                      },
                      child: Card(
                        elevation: 10,
                        child: Container(
                          width: width * .5,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.format_list_numbered_rounded,
                                color: Colors.black,
                              ),
                              SizedBox(width: 30),
                              Text(
                                'Survey',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),

                  // logout
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        accessService.logout().then(
                              (value) => Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const LoginView()),
                                  (route) => false),
                            );
                      },
                      child: Card(
                        elevation: 10,
                        child: Container(
                          width: width * .5,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.logout,
                                color: Colors.black,
                              ),
                              SizedBox(width: 30),
                              Text(
                                'Logout',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
