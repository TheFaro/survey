import 'package:flutter/material.dart';
import 'package:snau_survey/models/models.dart';
import 'package:snau_survey/views/views.dart';

class SurveyPage {
  final int id;
  final int surveyGroup;
  final String page;
  Future<List<PageInputs>>? futureInputs;
  Helpers helper = Helpers();

  SurveyPage({
    required this.id,
    required this.surveyGroup,
    required this.page,
  });

  factory SurveyPage.fromJson(Map<String, dynamic> json) => SurveyPage(
        id: json['id'].toString().isEmpty || json['id'] == null
            ? -1
            : int.parse(json['id'].toString()),
        surveyGroup: json['survey_group'].toString().isEmpty ||
                json['survey_group'] == null
            ? -1
            : int.parse(json['survey_group'].toString()),
        page: json['page'].toString().isEmpty || json['page'] == null
            ? ''
            : json['page'].toString(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'survey_group': surveyGroup,
        'page': page,
      };

  // defining a builder for page inputs based on the type of input
  Widget buildSurveyPageView({
    required BuildContext context,
    required bool viewing,
  }) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    print("We are about to build.");
    return SingleChildScrollView(
      child: SizedBox(
        width: width,
        child: FutureBuilder<List<PageInputs>>(
            future: futureInputs,
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
                          color: Color.fromRGBO(17, 68, 131, 1),
                          strokeWidth: 2,
                        ),
                      ));
                case ConnectionState.active:
                  break;
                case ConnectionState.done:
                  if (snapshot.hasData) {
                    print('Inside has data \n');
                    List<PageInputs> inputs = snapshot.data!;

                    // create listview object
                    return ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: inputs.length,
                        itemBuilder: (context, index) {
                          PageInputs input = inputs[index];

                          if (viewing) {
                            // check type condition for creating required input.
                            return Column(
                              children: [
                                const SizedBox(height: 25),
                                Center(
                                  child: input.type == 'text'
                                      ? helper.buildDataView(
                                          context: context,
                                          label: input.label,
                                          data: input.data == null
                                              ? ""
                                              : input.data!)
                                      : input.type == 'number'
                                          ? helper.buildDataView(
                                              context: context,
                                              label: input.label,
                                              data: input.data == null
                                                  ? ""
                                                  : input.data!)
                                          : input.type == 'date'
                                              ? helper.buildDataView(
                                                  context: context,
                                                  label: input.label,
                                                  data: input.data == null
                                                      ? ""
                                                      : input.data!)
                                              : input.type == 'textarea'
                                                  ? helper.buildDataView(
                                                      context: context,
                                                      label: input.label,
                                                      data: input.data == null
                                                          ? ""
                                                          : input.data!)
                                                  : const Padding(
                                                      padding:
                                                          EdgeInsets.all(20),
                                                      child: Text(
                                                        'Do not know this input type.',
                                                      ),
                                                    ),
                                )
                              ],
                            );
                          } else {
                            // check type condition for creating required input.
                            return Column(
                              children: [
                                const SizedBox(
                                  height: 25,
                                ),
                                Center(
                                  child: input.type == 'text'
                                      ? input.buildSingleInput(context: context)
                                      : input.type == 'number'
                                          ? input.buildNumberInput(
                                              context: context)
                                          : input.type == 'date'
                                              ? input.buildDateInput(
                                                  context: context)
                                              : input.type == 'textarea'
                                                  ? input.buildTextAreaInput(
                                                      context: context)
                                                  : const Padding(
                                                      padding:
                                                          EdgeInsets.all(20),
                                                      child: Text(
                                                        'Do not know this input type.',
                                                      ),
                                                    ),
                                )
                              ],
                            );
                          }
                        });
                  } else {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          snapshot.error
                              .toString()
                              .replaceAll('Exception:', ''),
                          style: TextStyle(
                            color: Colors.red.shade600,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
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
            }),
      ),
    );
  }
}
