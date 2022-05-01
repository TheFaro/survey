import 'package:flutter/material.dart';
import 'package:snau_survey/views/views.dart';

class BSPHomeView extends StatefulWidget {
  const BSPHomeView({Key? key}) : super(key: key);

  @override
  State<BSPHomeView> createState() => _BSPHomeViewState();
}

class _BSPHomeViewState extends State<BSPHomeView> {
  Helpers helpers = Helpers();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home: BSP',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromRGBO(17, 68, 131, 1),
        iconTheme: IconTheme.of(context).copyWith(
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: width,
          ),
        ),
      ),
    );
  }
}
