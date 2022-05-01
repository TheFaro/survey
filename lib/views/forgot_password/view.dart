import 'package:flutter/material.dart';
import 'package:snau_survey/api/api.dart';
import 'package:snau_survey/views/views.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPasswordView> {
  TextEditingController email = TextEditingController();
  final GlobalKey<FormState> _emailKey = GlobalKey<FormState>();
  AccessService service = AccessService();
  Helpers helper = Helpers();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: width,
            height: height,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(height: 70),

                  // title
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 42,
                      top: 12,
                      bottom: 12,
                      right: 12,
                    ),
                    child: Text(
                      'Forgot Password',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),

                  // subtitle
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 42,
                      right: 42,
                    ),
                    child: Text(
                      'Enter your email for the verification process. A 4 digit code will be sent to your email address.',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 160),

                  // email
                  Center(
                    child: SizedBox(
                      width: width * .75,
                      child: Form(
                        key: _emailKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: TextFormField(
                          controller: email,
                          validator: (val) {
                            String pattern =
                                r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                r"{0,253}[a-zA-Z0-9])?)*$";

                            RegExp regex = RegExp(pattern);

                            if (val == null || val.isEmpty) {
                              return "Please enter your email address.";
                            } else if (val.isNotEmpty && !regex.hasMatch(val)) {
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
                  ),
                  const SizedBox(height: 120),

                  // confirm email button
                  Center(
                    child: MaterialButton(
                        textColor: Colors.white,
                        color: const Color.fromRGBO(17, 68, 131, 1),
                        child: const Text(
                          'Confirm email',
                          textAlign: TextAlign.center,
                        ),
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        padding: EdgeInsets.only(
                          left: width * .3,
                          right: width * .3,
                          top: 20,
                          bottom: 20,
                        ),
                        onPressed: () {
                          if (_emailKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Processing Data')));
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ResetPasswordView()));

                            // send request to send OTP to email account
                            /* TODO: service.confirmEmailForgotPassword(email: email.text).then((dynamic val){
                              helper.buildSnackBar(context, 'Check your email for code.', Colors.black38);
                              Future.delayed(const Duration(seconds: 4), (){
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ResetPasswordView()));
                              });
                            }).catchError((err){
                              helper.buildSnackBar(context, err.toString().replaceAll('Exception:', ''), Colors.red.shade500);
                            });*/
                          }
                        }),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
