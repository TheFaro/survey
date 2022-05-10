import 'package:flutter/material.dart';
import 'package:snau_survey/api/api.dart';
import 'package:snau_survey/models/models.dart';
import 'package:snau_survey/views/views.dart';

class SurveyListView extends StatefulWidget {
  const SurveyListView({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  State<SurveyListView> createState() => _SurveyListViewState();
}

class _SurveyListViewState extends State<SurveyListView> {
  Helpers helper = Helpers();
  Future<List<Survey>>? _surveys;
  SurveyService service = SurveyService();

  @override
  void initState() {
    super.initState();

    _surveys = service.getSurveyList(
        module: widget.user.level == 1 ? 'enumerator' : 'bsp');

    _surveys!.then((value) {
      if (value.isNotEmpty) {
        helper.buildSnackBar(
          context,
          'Successfully retrieved survey list.',
          Colors.green.shade600,
        );
      } else {
        helper.buildSnackBar(
          context,
          'Survey list is empty.',
          Colors.deepOrange,
        );
      }
    }).catchError((err) {
      helper.buildSnackBar(
        context,
        err.toString().replaceAll("Exception:", ""),
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
          'Survey List',
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
            child: FutureBuilder<List<Survey>>(
              future: _surveys,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    break;
                  case ConnectionState.waiting:
                    return SizedBox(
                      width: width,
                      height: height,
                      child: const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Color.fromRGBO(17, 68, 131, 1),
                        ),
                      ),
                    );
                  case ConnectionState.active:
                    break;
                  case ConnectionState.done:
                    if (snapshot.hasData) {
                      List<Survey> surveys = snapshot.data!;

                      return Padding(
                        padding: const EdgeInsets.all(0),
                        child: ListView.builder(
                          shrinkWrap: true,
                          // gridDelegate:
                          //     const SliverGridDelegateWithFixedCrossAxisCount(
                          //   childAspectRatio: 1,
                          //   crossAxisSpacing: 20,
                          //   mainAxisSpacing: 20,
                          //   crossAxisCount: 2,
                          // ),
                          itemCount: surveys.length,
                          itemBuilder: (context, index) {
                            Survey survey = surveys[index];

                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(height: 25),
                                Center(
                                  child: InkWell(
                                    onTap: () {
                                      // show dialog
                                      helper.buildSurveyChoiceDialog(
                                        context: context,
                                        survey: survey,
                                      );
                                    },
                                    child: Card(
                                      elevation: 15,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Container(
                                        width: width * .85,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // image
                                            Container(
                                              height: 150,
                                              decoration: const BoxDecoration(
                                                color: Colors.blue,
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(15),
                                                  topLeft: Radius.circular(15),
                                                ),
                                              ),
                                            ),

                                            // survey survey name
                                            Padding(
                                              padding: const EdgeInsets.all(15),
                                              child: Text(
                                                '${index + 1}. ${survey.surveyName}',
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),

                                            // survey description
                                            Padding(
                                              padding: const EdgeInsets.all(15),
                                              child: Text(
                                                'Description:\n${survey.description}',
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  color: Colors.grey.shade600,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 30),
                              ],
                            );
                          },
                        ),
                      );
                    } else {
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
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                }

                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'An error occurred. Please reload.',
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
