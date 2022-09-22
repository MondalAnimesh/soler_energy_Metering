import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class User extends StatefulWidget {
  const User({super.key});

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Dashboard",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .1,
            width: MediaQuery.of(context).size.width * .15,
            child: const CircleAvatar(
              backgroundImage: AssetImage("assets/images/main.png"),
            ),
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 241, 235, 235),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          const Text(
            "Walcome",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          const Text(
            "Name",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
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
          Center(
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
          ))
        ],
      ),
    );
  }
}
