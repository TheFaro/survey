import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snau_survey/api/api.dart';
import 'package:snau_survey/views/views.dart';

class ResetPasswordView extends StatefulWidget{
  const ResetPasswordView({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPasswordView>{

  late String email;
  TextEditingController password1 = TextEditingController();
  TextEditingController password2 = TextEditingController();
  bool obscureText1 = true;
  bool obscureText2 = true;
  AccessService service = AccessService();
  Helpers helper = Helpers();
  bool match = false;

  @override
  void initState() {
    super.initState();

    getForgotPasswordEmail();
  }

  Future<void> getForgotPasswordEmail() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? temp = prefs.getString('email_forgot_password');
    if(temp != null){
      email = temp;
    }
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),

              // title
              const Padding(
                padding: EdgeInsets.only(
                  left: 42,
                  right: 42,
                  top: 12,
                  bottom: 12,
                ),
                child: Text(
                  'Reset Password',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // subtitle
              const Padding(
                padding: EdgeInsets.only(
                  left: 42,
                  right: 42,
                  top: 12,
                  bottom: 12,
                ),
                child: Text(
                  'Set the new password for your account to login with successfully.',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 160),

              // password 1
              Center(
                child: SizedBox(
                  width: width * .75,
                  child: TextFormField(
                    controller: password1,
                    obscureText: obscureText1,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(
                          color: Colors.blue.shade900
                      ),
                      enabled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(width: 1.0, color: Colors.blue.shade900),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(width: 1.0, color: Colors.blue.shade900),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2.0, color: Colors.blue.shade900),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(width: 1.5,color: Colors.red.shade900),
                      ),
                      prefixIcon: const Icon(Icons.lock, color: Color.fromRGBO(17, 68, 131, 1)),
                      suffix: TextButton(
                        onPressed: (){
                          setState(() {
                            obscureText1 = !obscureText1;
                          });
                        },
                        child: Text(
                          obscureText1 ? 'Show' : 'Hide',
                          style: const TextStyle(
                            color: Color.fromRGBO(17, 68, 131, 1),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // password 2
              Center(
                child: SizedBox(
                  width: width * .75,
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: password2,
                    obscureText: obscureText2,
                    validator: (password){
                      if(password != password1.text.toString()){
                        return "Passwords do not match";
                      }

                      match = true;
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Re-Type Password',
                      labelStyle: TextStyle(
                          color: Colors.blue.shade900
                      ),
                      enabled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(width: 1.0, color: Colors.blue.shade900),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(width: 1.0, color: Colors.blue.shade900),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2.0, color: Colors.blue.shade900),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(width: 1.5,color: Colors.black38),
                      ),
                      prefixIcon: const Icon(Icons.lock, color: Color.fromRGBO(17, 68, 131, 1)),
                      suffix: TextButton(
                        onPressed: (){
                          setState(() {
                            obscureText2 = !obscureText2;
                          });
                        },
                        child: Text(
                          obscureText2 ? 'Show' : 'Hide',
                          style: const TextStyle(
                            color: Color.fromRGBO(17, 68, 131, 1),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 60),

              // reset password button
              Center(
                child: MaterialButton(
                    textColor: Colors.white,
                    color: const Color.fromRGBO(17, 68, 131, 1),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    elevation: 5,
                    child: const Text(
                      'Reset Password',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                    padding: EdgeInsets.only(
                      left: width * .27,
                      right: width * .27,
                      top: 20,
                      bottom: 20,
                    ),
                    onPressed: (){

                      if(match){
                        service.resetPassword(password: password1.text).then((String val){
                          helper.buildSnackBar(context, val, Colors.red.shade500);

                        }).catchError((err){
                          helper.buildSnackBar(context, err.toString().replaceAll('Exception:', ''), Colors.red.shade500);
                        });
                      }else{
                        helper.buildSnackBar(context, 'Password do not match.', Colors.red.shade500);
                      }
                    }
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}