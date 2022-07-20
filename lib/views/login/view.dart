import 'package:page_transition/page_transition.dart';
import 'package:snau_survey/api/api.dart';
import 'package:snau_survey/models/models.dart';
import 'package:snau_survey/views/views.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginView> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool obscureText = true;
  final GlobalKey<FormState> _emailKey = GlobalKey<FormState>();
  AccessService service = AccessService();
  Helpers helper = Helpers();
  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                padding: const EdgeInsets.only(
                  left: 30,
                ),
                height: height * .3,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      // title
                      Text(
                        'SURVEYOR',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),

                      // subtitle
                      Text(
                        'Let\'s help you harvest data. Data is gold.',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.w200,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ]),
              ),

              // form
              Center(
                child: Container(
                  width: width * .9,
                  height: height * .7,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // email
                      SizedBox(
                        width: width * .7,
                        height: height * .07,
                        child: Form(
                          key: _emailKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: TextFormField(
                            controller: email,
                            keyboardType: TextInputType.emailAddress,
                            validator: (val) {
                              String pattern =
                                  r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                  r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                  r"{0,253}[a-zA-Z0-9])?)*$";

                              RegExp regex = RegExp(pattern);

                              if (val == null || val.isEmpty) {
                                return "Please enter your email address.";
                              } else if (val.isNotEmpty &&
                                  !regex.hasMatch(val)) {
                                return "Please enter a valid email address.";
                              }

                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Email Address',
                              labelStyle: const TextStyle(
                                  color: Color.fromRGBO(17, 68, 131, 1)),
                              enabled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    width: 1.0,
                                    color: Color.fromRGBO(17, 68, 131, 1)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    width: 1.0,
                                    color: Color.fromRGBO(17, 68, 131, 1)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 2.0,
                                    color: Color.fromRGBO(17, 68, 131, 1)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    width: 1.5, color: Colors.red.shade900),
                              ),
                              prefixIcon: const Icon(Icons.email_rounded,
                                  color: Color.fromRGBO(17, 68, 131, 1)),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),

                      // password
                      SizedBox(
                        width: width * .7,
                        height: height * .07,
                        child: TextFormField(
                          controller: password,
                          obscureText: obscureText,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: const TextStyle(
                                color: Color.fromRGBO(17, 68, 131, 1)),
                            enabled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  width: 1.0,
                                  color: Color.fromRGBO(17, 68, 131, 1)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  width: 1.0,
                                  color: Color.fromRGBO(17, 68, 131, 1)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 2.0,
                                  color: Color.fromRGBO(17, 68, 131, 1)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  width: 1.5, color: Colors.red.shade900),
                            ),
                            prefixIcon: const Icon(Icons.lock,
                                color: Color.fromRGBO(17, 68, 131, 1)),
                            suffix: TextButton(
                              onPressed: () {
                                setState(() {
                                  obscureText = !obscureText;
                                });
                              },
                              child: Text(
                                obscureText ? 'Show' : 'Hide',
                                style: const TextStyle(
                                  color: Color.fromRGBO(17, 68, 131, 1),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),

                      // forgot password
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ForgotPasswordView(),
                              ));
                        },
                        child: const Text(
                          'Forgot password?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 14,
                            color: Color.fromRGBO(17, 68, 131, 1),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),

                      // login button
                      SizedBox(
                        width: width * .7,
                        child: MaterialButton(
                          textColor: Colors.white,
                          color: const Color.fromRGBO(17, 68, 131, 1),
                          onPressed: () {
                            setState(() {
                              loading = true;
                            });
                            if (_emailKey.currentState!.validate()) {
                              service
                                  .loginRequest(
                                      email: email.text,
                                      password: password.text)
                                  .then((Map<String, dynamic> res) {
                                helper.buildSnackBar(
                                    context, res['message'], Colors.green);

                                setState(() {
                                  loading = false;
                                });

                                Navigator.pushReplacement(
                                    context,
                                    PageTransition(
                                        child: EnumeratorHomeView(
                                          user: res['user'],
                                        ),
                                        type: PageTransitionType
                                            .rightToLeftWithFade));
                              }).catchError((err) {
                                setState(() {
                                  loading = false;
                                });
                                helper.buildSnackBar(
                                  context,
                                  err.toString().replaceAll("Exception:", ''),
                                  Colors.red.shade600,
                                );
                              });
                            }
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          child: const Text(
                            'Log In',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),

                      SizedBox(
                        child: Visibility(
                          visible: loading,
                          child: const LinearProgressIndicator(
                            color: Color.fromRGBO(17, 68, 131, 1),
                          ),
                        ),
                        width: width * .65,
                      ),
                      const SizedBox(height: 40),

                      // sign up text
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Don't have an account? ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              color: Color.fromRGBO(17, 68, 131, 1),
                              fontSize: 15,
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              Future.delayed(const Duration(milliseconds: 1000),
                                  () {
                                Navigator.pushReplacement(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: const RegisterView(),
                                    duration: const Duration(milliseconds: 400),
                                  ),
                                );
                              });
                            },
                            child: const Text(
                              'Sign Up',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: Color.fromRGBO(17, 68, 131, 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
