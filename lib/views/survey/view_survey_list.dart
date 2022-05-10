import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:snau_survey/api/api.dart';
import 'package:snau_survey/models/models.dart';
import 'package:snau_survey/views/search_delegate/main.dart';
import 'package:snau_survey/views/views.dart';

class ViewSurveyListScreen extends StatefulWidget {
  const ViewSurveyListScreen(
      {Key? key, required this.survey, required this.viewSurvey})
      : super(key: key);

  final Survey survey;
  final bool viewSurvey;

  @override
  State<ViewSurveyListScreen> createState() => _ViewSurveyListScreenState();
}

class _ViewSurveyListScreenState extends State<ViewSurveyListScreen> {
  Future<List<Farmer>>? _farmers;
  Helpers helper = Helpers();
  SurveyService service = SurveyService();
  RegisterFarmerService farmerService = RegisterFarmerService();
  AccessService accessService = AccessService();

  @override
  void initState() {
    super.initState();

    if (widget.viewSurvey) {
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
    } else {
      // first get enumerator Id
      accessService.getUserId().then((int value) {
        // get farmers
        _farmers =
            farmerService.getFarmers(enumeratorId: value).catchError((err) {
          helper.buildSnackBar(
            context,
            err.toString().replaceAll('Exception:', ''),
            Colors.red.shade600,
          );
        });
      }).catchError((err) {
        helper.buildSnackBar(context,
            err.toString().replaceAll("Exception:", ''), Colors.red.shade600);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.viewSurvey ? 'Previous Survey List' : 'Take Survey',
          style: const TextStyle(
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
                              //  - first get the survey pages
                              //  - then go to the survey

                              service
                                  .getSurveyPages(surveyId: widget.survey.id)
                                  .then((List<SurveyPage> values) {
                                // assingnign pages to survey,
                                setState(() {
                                  widget.survey.pages = values;
                                });

                                if (widget.survey.pages != null &&
                                    widget.survey.pages!.isEmpty) {
                                  print('The survey pages list is empty.');
                                } else {
                                  print("I have found some survey pages.");
                                }
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SurveyPagesView(
                                      survey: widget.survey,
                                      viewing: false,
                                    ),
                                  ),
                                );
                              }).catchError((err) {
                                helper.buildSnackBar(
                                  context,
                                  err.toString().replaceAll('Exception:', ''),
                                  Colors.red.shade600,
                                );
                              });
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
                                    leading: Text(
                                      '${index + 1}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    title: Text(
                                      '${farmer.name} ${farmer.surname}',
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 20,
                                    ),
                                    subtitle: Container(
                                      decoration: const BoxDecoration(
                                        color: Color.fromRGBO(17, 68, 131, 1),
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(5),
                                          bottomRight: Radius.circular(5),
                                          topRight: Radius.circular(5),
                                          topLeft: Radius.circular(5),
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
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
                                              textAlign: TextAlign.start,
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
