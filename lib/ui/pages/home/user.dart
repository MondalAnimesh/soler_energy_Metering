import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:solar_energy/main.dart';
import 'package:solar_energy/module/provider/app_state.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Appstate>(builder: (context, value, child) {
      return Scaffold(
          appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: const Text(
                "Dashboard",
                style: TextStyle(color: Colors.black),
              ),
              actions: [
                PopupMenuButton(
                  offset: const Offset(0.0, 60.0),
                  icon: const Icon(Icons.account_circle_sharp,
                      color: Colors.black),
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuItem<String>>[
                    PopupMenuItem<String>(
                      onTap: value.updateUserData,
                      child: const Center(child: Text("Refresh")),
                    ),
                    PopupMenuItem<String>(
                      onTap: () async {
                        bool out = await value.user.logout();
                        if (out) {
                          EasyLoading.showSuccess("Logout successfully");
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MyApp()),
                              (route) => false);
                        }
                      },
                      child: const Center(child: Text("logout")),
                    ),
                  ],
                ),
              ]),
          backgroundColor: Colors.black.withOpacity(0.05),
          body: ListView(
            padding: const EdgeInsets.all(15),
            children: [
              const Text(
                "Welcome",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              Text(
                value.user.userName.text,
                style:
                    const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              // ListTile(
              //   leading: SizedBox(
              //     height: MediaQuery.of(context).size.height * .1,
              //     width: MediaQuery.of(context).size.width * .15,
              //     child: const CircleAvatar(
              //       backgroundImage: AssetImage("assets/images/main.png"),
              //     ),
              //   ),
              //   title: const Text(
              //     "name",
              //     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              //   ),
              //   subtitle: const Text(
              //     "Plant details ",
              //   ),
              // ),
              Card(
                margin: const EdgeInsets.all(15),
                elevation: 3,
                child: Wrap(
                  alignment: WrapAlignment.spaceAround,
                  children: [
                    Column(
                      children: const [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "energy generated",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text("Solar energy",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              // color: Color.fromARGB(255, 209, 173, 42)),
                            )),
                      ],
                    ),
                    CircularPercentIndicator(
                      radius: 60.0,
                      lineWidth: 13.0,
                      animation: true,
                      animateFromLastPercent: true,
                      percent: 0.4,
                      center: const Text(
                        "40.0%",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: Colors.blue,
                    ),
                  ],
                ),
              ),
              Card(
                  margin: const EdgeInsetsDirectional.only(start: 15, end: 15),
                  elevation: 3,
                  child: (Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            "current",
                            style: TextStyle(fontSize: 18),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: LinearPercentIndicator(
                              width: MediaQuery.of(context).size.width * .5,
                              animation: true,
                              animateFromLastPercent: true,
                              lineHeight: 20.0,
                              animationDuration: 2000,
                              percent: 0.8,
                              center: const Text("80.0%"),
                              progressColor: Colors.red,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            "voltage",
                            style: TextStyle(fontSize: 18),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: LinearPercentIndicator(
                              width: MediaQuery.of(context).size.width * .5,
                              animation: true,
                              animateFromLastPercent: true,
                              lineHeight: 20.0,
                              animationDuration: 2000,
                              percent: 1.0,
                              center: const Text("100.0%"),
                              progressColor: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            "power",
                            style: TextStyle(fontSize: 18),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: LinearPercentIndicator(
                              width: MediaQuery.of(context).size.width * .5,
                              animation: true,
                              animateFromLastPercent: true,
                              lineHeight: 20.0,
                              animationDuration: 2000,
                              percent: 0.5,
                              center: const Text("50.0%"),
                              progressColor: Colors.blue,
                            ),
                          ),
                        ],
                      )
                    ],
                  ))),

              const SizedBox(
                height: 30,
              ),

              // SizedBox(
              //   height: MediaQuery.of(context).size.height * 0.4,
              //   child: GridView(
              //     padding: const EdgeInsets.all(20),
              //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //       crossAxisCount: 2,
              //       crossAxisSpacing: 8,
              //       mainAxisSpacing: 8,
              //       childAspectRatio: 1,
              //     ),
              //     children: [
              //       Card(
              //         elevation: 2,
              //         child: Container(
              //           height: 100,
              //           width: 100,
              //           color: Colors.white,
              //         ),
              //       ),
              //       Card(
              //         elevation: 2,
              //         child: Container(
              //           height: 100,
              //           width: 100,
              //           color: Colors.white,
              //         ),
              //       )
              //     ],
              //   ),
              // ),
              Card(
                margin: const EdgeInsetsDirectional.only(start: 15, end: 15),
                elevation: 3,
                child: Center(
                    child: SfSparkBarChart(
                  //Enable the trackball
                  trackball: const SparkChartTrackball(
                      activationMode: SparkChartActivationMode.tap),

                  labelDisplayMode: SparkChartLabelDisplayMode.all,
                  data: const <double>[
                    1,
                    5,
                    0,
                    1,
                    7,
                    13,
                    7,
                  ],
                )),
              )
            ],
          ));
    });
  }
}
