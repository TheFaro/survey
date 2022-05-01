import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:snau_survey/api/api.dart';
import 'package:snau_survey/models/models.dart';
import 'package:snau_survey/views/views.dart';

class ViewFarmersListView extends StatefulWidget {
  const ViewFarmersListView({Key? key}) : super(key: key);

  @override
  _ViewFarmersListState createState() => _ViewFarmersListState();
}

class _ViewFarmersListState extends State<ViewFarmersListView> {
  Future<List<Farmer>>? _farmers;
  Helpers helper = Helpers();
  RegisterFarmerService service = RegisterFarmerService();

  @override
  void initState() {
    super.initState();
    _farmers = service.getFarmers(enumeratorId: "enumeratorId");
    _farmers!.catchError((err) {
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
    // double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Enumerator Farmers',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        iconTheme: IconTheme.of(context).copyWith(
          color: Colors.white,
        ),
        backgroundColor: const Color.fromRGBO(17, 68, 131, 1),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: width,
            child: FutureBuilder<List<Farmer>>(
              future: _farmers,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color.fromRGBO(17, 68, 131, 1),
                    ),
                  );
                } else {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        snapshot.error.toString().replaceAll("Exception:", ''),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                        ),
                      ),
                    );
                  } else {
                    List<Farmer> farmers = snapshot.data!;
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: farmers.length,
                      itemBuilder: (context, index) {
                        Farmer farmer = farmers[index];

                        return Column(children: [
                          ListTile(
                            title: Text(
                              "${index + 1}. " +
                                  farmer.name +
                                  " " +
                                  farmer.surname,
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                            subtitle: Text(
                              "\t\t ${farmer.nationalId}",
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(17, 68, 131, 1),
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                  child: ViewFarmerView(farmer: farmer),
                                  type: PageTransitionType.fade,
                                ),
                              );
                            },
                          ),
                          const Divider(
                            thickness: 2,
                            color: Color.fromRGBO(17, 68, 131, 1),
                          ),
                          const SizedBox(height: 4),
                        ]);
                      },
                    );
                  }
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
