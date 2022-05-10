import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:snau_survey/views/views.dart';
import 'package:snau_survey/api/api.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreenView> {
  AccessService service = AccessService();
  Helpers helper = Helpers();

  @override
  void initState() {
    super.initState();

    service
        .checkLoginStatus()
        .then(
          (Map<String, dynamic> value) => !value['logged']
              ? Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginView()))
              : Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EnumeratorHomeView(
                      user: value['user'],
                    ),
                  ),
                ),
        )
        .catchError((err) {
      helper.buildSnackBar(
        context,
        err.toString().replaceAll('Exception:', ''),
        Colors.red.shade600,
      );

      Navigator.pushReplacement(
        context,
        PageTransition(child: const LoginView(), type: PageTransitionType.fade),
      );
    });
    //Future.delayed(const Duration(), () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginView())));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // logo
                Container(
                  width: width * .3,
                  height: height * .3,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/raised_fist.png'),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // title
                const Text(
                  'SURVEYOR',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 50),

                // sub title
                const Text(
                  'Let\'s help you harvest data. Data is gold.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                const CircularProgressIndicator(
                  color: Colors.white,
                ),
              ]),
        ),
      ),
    );
  }
}
