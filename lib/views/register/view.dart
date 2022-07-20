import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:snau_survey/api/api.dart';
import 'package:snau_survey/models/models.dart';
import 'package:snau_survey/views/views.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<RegisterView> {
  AccessService service = AccessService();
  Future<List<Organization>>? _orgs;
  Helpers helper = Helpers();

  Organization _currentSelectedValue = Organization(
    id: -1,
    name: '',
    phone: '',
    email: '',
  );

  String _currentSelectedGender = "Gender";

  late List<Organization> _organizations = [
    _currentSelectedValue,
  ];

  final List<String> _genders = ["Gender", "Female", "Male"];
  final GlobalKey<FormState> _emailKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  TextEditingController nationalId = TextEditingController();
  TextEditingController surname = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController designation = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController level = TextEditingController();

  bool obscureText = true;
  bool obscureText1 = true;
  bool match = false;

  @override
  void initState() {
    super.initState();

    _orgs = service.getOrganizations().catchError((err) {
      helper.buildSnackBar(context, err.toString().replaceAll("Exception:", ''),
          Colors.red.shade600);
    });

    _orgs!.then((List<Organization> orgs) {
      _organizations.insertAll(1, orgs);
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  width: width,
                  height: height * .3,
                  child: Padding(
                    padding: const EdgeInsets.all(42),
                    child: Wrap(
                      direction: Axis.vertical,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: const [
                        // title
                        Text(
                          'SURVEYOR',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w100,
                          ),
                        ),

                        // sub title
                        Text(
                          'Let\'s help you harvest data. Data is gold.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w100,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // form
                Center(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      ),
                    ),
                    width: width * 0.9,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 70,
                          ),

                          // drop down organizations
                          SizedBox(
                            width: width * .7,
                            child: FormField<Organization>(
                              builder: (FormFieldState<Organization> state) {
                                return InputDecorator(
                                  decoration: InputDecoration(
                                    labelText: 'Select Organization',
                                    labelStyle: const TextStyle(
                                        color: Color.fromRGBO(17, 68, 131, 1)),
                                    errorStyle: const TextStyle(
                                      color: Colors.redAccent,
                                      fontSize: 16,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          width: 1.0,
                                          color:
                                              Color.fromRGBO(17, 68, 131, 1)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          width: 1.0,
                                          color:
                                              Color.fromRGBO(17, 68, 131, 1)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 2.0,
                                          color:
                                              Color.fromRGBO(17, 68, 131, 1)),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          width: 1.5,
                                          color: Colors.red.shade900),
                                    ),
                                  ),
                                  isEmpty: _currentSelectedValue.name == "",
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<Organization>(
                                      value: _currentSelectedValue,
                                      isDense: true,
                                      onChanged: (Organization? value) {
                                        setState(() {
                                          _currentSelectedValue = value!;
                                          state.didChange(value);
                                        });
                                      },
                                      items: _organizations
                                          .map((Organization value) {
                                        return DropdownMenuItem<Organization>(
                                            value: value,
                                            child: Text(
                                              value.name,
                                              style: const TextStyle(
                                                color: Color.fromRGBO(
                                                    17, 68, 131, 1),
                                              ),
                                            ));
                                      }).toList(),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 20),

                          // name
                          SizedBox(
                            width: width * .7,
                            child: TextFormField(
                              controller: name,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                labelText: 'Name',
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
                                prefixIcon: const Icon(Icons.person_rounded,
                                    color: Color.fromRGBO(17, 68, 131, 1)),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                          // surname
                          SizedBox(
                            width: width * .7,
                            child: TextFormField(
                              controller: surname,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                labelText: 'Surname',
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
                                prefixIcon: const Icon(Icons.person_rounded,
                                    color: Color.fromRGBO(17, 68, 131, 1)),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                          // email
                          SizedBox(
                            width: width * .7,
                            height: height * .07,
                            child: Form(
                              key: _emailKey,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
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
                          const SizedBox(
                            height: 20,
                          ),

                          // phone
                          SizedBox(
                            width: width * .7,
                            height: height * .07,
                            child: TextFormField(
                              controller: phone,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'Phone Number',
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
                                prefixIcon: const Icon(Icons.phone,
                                    color: Color.fromRGBO(17, 68, 131, 1)),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                          // gender
                          SizedBox(
                            width: width * .7,
                            height: height * .07,
                            child: FormField<String>(
                              builder: (FormFieldState<String> state) {
                                return InputDecorator(
                                  decoration: InputDecoration(
                                    labelText: 'Gender',
                                    labelStyle: const TextStyle(
                                        color: Color.fromRGBO(17, 68, 131, 1)),
                                    errorStyle: const TextStyle(
                                      color: Colors.redAccent,
                                      fontSize: 16,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          width: 1.0,
                                          color:
                                              Color.fromRGBO(17, 68, 131, 1)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          width: 1.0,
                                          color:
                                              Color.fromRGBO(17, 68, 131, 1)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 2.0,
                                          color:
                                              Color.fromRGBO(17, 68, 131, 1)),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          width: 1.5,
                                          color: Colors.red.shade900),
                                    ),
                                    prefixIcon: const Icon(Icons.wc_rounded,
                                        color: Color.fromRGBO(17, 68, 131, 1)),
                                  ),
                                  isEmpty: _currentSelectedGender == "Gender",
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: _currentSelectedGender,
                                      isDense: true,
                                      onChanged: (String? value) {
                                        setState(() {
                                          _currentSelectedGender = value!;
                                          state.didChange(value);
                                        });
                                      },
                                      items: _genders.map((String value) {
                                        return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              style: const TextStyle(
                                                color: Color.fromRGBO(
                                                    17, 68, 131, 1),
                                              ),
                                            ));
                                      }).toList(),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                          // designation
                          SizedBox(
                            width: width * .7,
                            height: height * .07,
                            child: TextFormField(
                              controller: designation,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                labelText: 'Designation',
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
                                prefixIcon: const Icon(Icons.work_rounded,
                                    color: Color.fromRGBO(17, 68, 131, 1)),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                          // level
                          SizedBox(
                            width: width * .7,
                            height: height * .07,
                            child: TextFormField(
                              controller: level,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                labelText: 'Level',
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
                                prefixIcon: const Icon(
                                    Icons.leaderboard_rounded,
                                    color: Color.fromRGBO(17, 68, 131, 1)),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                          // password
                          SizedBox(
                            width: width * .7,
                            height: height * .07,
                            child: TextFormField(
                              controller: password,
                              keyboardType: TextInputType.visiblePassword,
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
                          const SizedBox(
                            height: 20,
                          ),

                          // confirm password
                          SizedBox(
                            width: width * .7,
                            height: height * .07,
                            child: TextFormField(
                              controller: confirmPassword,
                              obscureText: obscureText1,
                              keyboardType: TextInputType.visiblePassword,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (val) {
                                if (val != password.text.toString()) {
                                  return "Passwords do not match";
                                }

                                match = true;
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: 'Confirm Password',
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
                          const SizedBox(
                            height: 20,
                          ),

                          // register button
                          SizedBox(
                            width: width * .7,
                            child: MaterialButton(
                              textColor: Colors.white,
                              color: const Color.fromRGBO(17, 68, 131, 1),
                              onPressed: () {
                                if (_emailKey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Processing Data')));
                                }
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              child: const Text(
                                'Sign Up',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w100,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),

                          // login instead.
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  "Already have an account? ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w100,
                                    color: Color.fromRGBO(17, 68, 131, 1),
                                    fontSize: 15,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    Future.delayed(
                                        const Duration(milliseconds: 1000), () {
                                      Navigator.pushReplacement(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType
                                              .leftToRightWithFade,
                                          child: const LoginView(),
                                          duration:
                                              const Duration(milliseconds: 400),
                                        ),
                                      );
                                    });
                                  },
                                  child: const Text(
                                    'Sign In',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                      color: Color.fromRGBO(17, 68, 131, 1),
                                    ),
                                  ),
                                ),
                              ]),
                        ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
