import 'package:flutter/material.dart';
import 'package:snau_survey/api/api.dart';
import 'package:snau_survey/models/models.dart';
import 'package:snau_survey/views/views.dart';

class SurveyPagesView extends StatefulWidget {
  const SurveyPagesView({
    Key? key,
    required this.survey,
    required this.viewing,
  }) : super(key: key);

  final Survey survey;
  final bool viewing;

  @override
  State<SurveyPagesView> createState() => _SurveyPagesViewState();
}

class _SurveyPagesViewState extends State<SurveyPagesView> {
  Helpers helper = Helpers();
  SurveyService service = SurveyService();

  late PageController controller;
  double scroll = 0;
  int counter = 0;
  int pageIndex = 0;
  bool pageReturned = false;
  bool pageMoved = false;
  String secondButton = "Next";
  String currentPage = "";

  @override
  void initState() {
    super.initState();

    print('We have been initiated.');

    controller = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    print('We are beginning our creation process.');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.survey.surveyName,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromRGBO(17, 68, 131, 1),
        iconTheme: IconTheme.of(context).copyWith(
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SizedBox(
            child: Stack(children: [
              // page inputs scroll view
              buildPageInputs(context),

              // navigation options
              Container(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0x00FFFFFF),
                        Color(0xFFFFFFFF),
                      ],
                      begin: FractionalOffset(0.0, 0.0),
                      end: FractionalOffset(0.0, 1.0),
                      tileMode: TileMode.clamp,
                    ),
                  ),
                  child: Flex(
                    direction: Axis.horizontal,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        fit: FlexFit.loose,
                        child: MaterialButton(
                          onPressed: () {
                            if (scroll == 0) {
                              helper.buildSnackBar(
                                context,
                                'This is the first page.',
                                Colors.grey.shade600,
                              );
                            } else if (scroll > 0) {
                              int count = widget.survey.pages!.length - 1;
                              if (counter != count - 1) {
                                setState(() {
                                  secondButton = 'Next';
                                });
                              }

                              counter--;
                              pageIndex--;
                              setState(() {
                                secondButton = 'Next';
                                currentPage =
                                    widget.survey.pages![pageIndex].page;
                              });

                              scroll = scroll - width;
                              controller.animateTo(
                                scroll,
                                duration: const Duration(milliseconds: 700),
                                curve: Curves.easeIn,
                              );

                              //Navigator.pop(context);
                            }
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 16,
                          ),
                          elevation: 3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Icon(
                                Icons.arrow_back,
                                color: Colors.black87,
                              ),
                              Text(
                                'Back',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          color: Colors.white,
                          disabledColor: Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Flexible(
                        fit: FlexFit.loose,
                        child: MaterialButton(
                          onPressed: () {
                            int count = widget.survey.pages!.length - 1;

                            if (count == counter) {
                              // go to previous screen : Survey list
                              Navigator.pop(context);
                            } else {
                              if (counter == count - 1) {
                                setState(() {
                                  secondButton = "Finish";
                                });
                              }

                              counter++;
                              pageIndex++;

                              setState(() {
                                currentPage =
                                    widget.survey.pages![pageIndex].page;
                              });

                              scroll = scroll + width;
                              controller.animateTo(
                                scroll,
                                duration: const Duration(milliseconds: 700),
                                curve: Curves.easeIn,
                              );
                            }
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 16,
                          ),
                          elevation: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                secondButton,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          color: const Color.fromRGBO(17, 68, 131, 1),
                          disabledColor: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  // function to build the page inputs scroll view
  Widget buildPageInputs(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width,
      height: height,
      child: PageView.builder(
          controller: controller,
          scrollDirection: Axis.horizontal,
          itemCount: widget.survey.pages!.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            SurveyPage page = widget.survey.pages![index];

            if (page.futureInputs == null) {
              page.futureInputs = service.getPageInputs(
                pageId: page.id,
              );

              print('Future page inputs is null.');
            } else {
              print('Future page inputs is null.');
            }

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: SizedBox(
                width: width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // page header / page name
                    Container(
                      padding: const EdgeInsets.only(
                        top: 24,
                        left: 24,
                        right: 24,
                      ),
                      child: Text(
                        page.page,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    // page sub title / page description
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      child: Text(
                        widget.survey.description,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    // page inputs builder
                    page.buildSurveyPageView(
                      context: context,
                      viewing: widget.viewing,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
