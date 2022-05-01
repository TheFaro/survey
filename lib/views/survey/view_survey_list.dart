import 'package:flutter/material.dart';
import 'package:snau_survey/api/api.dart';
import 'package:snau_survey/models/models.dart';
import 'package:snau_survey/views/search_delegate/main.dart';
import 'package:snau_survey/views/views.dart';

class ViewSurveyListScreen extends StatefulWidget {
  const ViewSurveyListScreen({Key? key, required this.survey})
      : super(key: key);

  final Survey survey;

  @override
  State<ViewSurveyListScreen> createState() => _ViewSurveyListScreenState();
}

class _ViewSurveyListScreenState extends State<ViewSurveyListScreen> {
  Future<List<Farmer>>? _farmers;
  Helpers helper = Helpers();
  SurveyService service = SurveyService();

  @override
  void initState() {
    super.initState();

    // get farmers who have
    _farmers = service.getSurveyRespondents(
        surveyId: widget.survey.id, surveyName: widget.survey.surveyName);

    _farmers!.then((List<Farmer> values) {
      if (values.isEmpty) {
        helper.buildSnackBar(
          context,
          'No responses recorded.',
          Colors.grey.shade600,
        );
      } else {
        helper.buildSnackBar(
          context,
          'Successfully retrieved.',
          Colors.green.shade600,
        );
      }
    }).catchError((err) {
      helper.buildSnackBar(
        context,
        err.toString().replaceAll('Exception:', ''),
        Colors.red.shade600,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Previous Survey List',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        iconTheme: IconTheme.of(context).copyWith(
          color: Colors.white,
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.search_rounded),
              color: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyApp(),
                  ),
                );
              }),
        ],
        backgroundColor: const Color.fromRGBO(17, 68, 131, 1),
      ),
      body: SafeArea(
        child: SizedBox(
          width: width,
          child: FutureBuilder<List<Farmer>>(
            future: _farmers,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.active:
                  break;
                case ConnectionState.waiting:
                  return SizedBox(
                    width: width,
                    height: height,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Color.fromRGBO(17, 68, 131, 1),
                      ),
                    ),
                  );

                case ConnectionState.none:
                  break;
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    return SizedBox(
                      width: width,
                      height: height,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            snapshot.error
                                .toString()
                                .replaceAll('Exception:', ''),
                            style: TextStyle(
                              color: Colors.red.shade600,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    );
                  } else {
                    List<Farmer> farmers = snapshot.data!;

                    if (farmers.isEmpty) {
                      return SizedBox(
                        width: width,
                        height: height,
                        child: Container(
                          alignment: Alignment.center,
                          color: const Color.fromRGBO(17, 68, 131, 0.8),
                          child: const Text(
                            'No responses recorded.',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          padding: const EdgeInsets.all(20),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: farmers.length,
                        itemBuilder: (context, index) {
                          Farmer farmer = farmers[index];

                          return InkWell(
                            onTap: () {
                              // TODO :
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Center(
                                child: Card(
                                  color: Colors.grey.shade300,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  elevation: 10,
                                  child: ListTile(
                                    leading: Text('${index + 1}'),
                                    title: Text(
                                      '${farmer.name} ${farmer.surname}',
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    subtitle: Container(
                                      decoration: const BoxDecoration(
                                        color: Color.fromRGBO(17, 68, 131, 1),
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(5),
                                          bottomRight: Radius.circular(5),
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // national id
                                          ListTile(
                                            title: const Text(
                                              'National ID:',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                              ),
                                            ),
                                            subtitle: Text(
                                              farmer.nationalId.toString(),
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),

                                          // email
                                          ListTile(
                                            title: const Text(
                                              'Email Address:',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.white,
                                              ),
                                            ),
                                            subtitle: Text(
                                              farmer.email,
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),

                                          // phone
                                          ListTile(
                                            title: const Text(
                                              'Phone Number:',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.white,
                                              ),
                                            ),
                                            subtitle: Text(
                                              farmer.phone,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  }
              }
              return Container(
                width: width,
                height: height,
                color: const Color.fromRGBO(17, 68, 131, 0.8),
                padding: const EdgeInsets.all(20),
                child: const Text(
                  'An error occurred.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
