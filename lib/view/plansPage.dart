// ignore: file_names
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider_helper/controllers/plansFetch.dart';
import 'package:provider_helper/model/plans.dart';
import 'package:http/http.dart' as http;
import 'package:provider_helper/view/plansFilters.dart';

class PlansPage extends StatefulWidget {
  const PlansPage({super.key});

  @override
  State<PlansPage> createState() => _PlansPageState();
}

class _PlansPageState extends State<PlansPage>
    with AutomaticKeepAliveClientMixin {
  late Future<List<Plan>> _futurePlan;
  late String state = '';
  final Text title = const Text(
    'Plans',
    maxLines: 2,
    style:
        TextStyle(color: Colors.white, fontSize: 40, fontFamily: 'Montserrat'),
  );
  @override
  void initState() {
    super.initState();
    _futurePlan = fetchPlans(http.Client());
  }

  var mainColor = Color.fromRGBO(25, 0, 40, 1);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _awaitReturnValueFromSecondScreen(context);
          },
          child: Icon(
            Icons.filter_alt_outlined,
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
        ),
        appBar: AppBar(
          backgroundColor: mainColor,
          title: title,
        ),
        backgroundColor: mainColor,
        body: RefreshIndicator(
            color: Colors.black,
            onRefresh: () {
              setState(() {
                _futurePlan = fetchPlansByState(http.Client(), state);
              });
              return Future<void>.delayed(const Duration(seconds: 2));
            },
            child: FutureBuilder<List<Plan>>(
                future: _futurePlan,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('An error has occurred'),
                    );
                  } else if (snapshot.hasData) {
                    return PlansList(snapshot.data!);
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                })));
  }

  Widget PlansList(List<Plan> plans) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return cardBuilder(
              plans[index].isp,
              plans[index].downloadSpeed,
              plans[index].uploadSpeed.toString(),
              plans[index].typeOfInternet,
              plans[index].pricePerMonth.toString());
        },
        separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
        itemCount: plans.length);
  }

  Widget cardBuilder(String isp, int downloadSpeed, String uploadSpeed,
      String typeOfInternet, String price) {
    return SizedBox(
        child: Container(
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                border: Border.all(
                    color: Colors
                        .primaries[Random().nextInt(Colors.primaries.length)]),
                borderRadius: BorderRadius.circular(20)),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: Stack(
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    isp,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                      padding: const EdgeInsets.only(left: 30, top: 20),
                      child: Row(
                        children: [
                          showParameter('$downloadSpeed mbps', 'Download'),
                          showParameter('$uploadSpeed mbps', 'Upload'),
                          showParameter(typeOfInternet.toUpperCase(), 'Type')
                        ],
                      ))
                ]),
                Positioned(top: 20, right: 25, child: showPrice(price))
              ],
            )));
  }

  Widget showParameter(String data, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: [
          Text(
            data,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Text(
            label,
            style: const TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }

  Widget showPrice(String value) {
    return Container(
      padding: EdgeInsets.only(left: 50),
      child: Column(
        children: [
          Text(
            '\$$value',
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const Text(
            'Price',
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  void _awaitReturnValueFromSecondScreen(BuildContext context) async {
    // start the SecondScreen and wait for it to finish with a result
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const PlansFilter(),
        ));

    // after the SecondScreen result comes back update the Text widget with it
    setState(() {
      if (result != 'None') {
        state = result;
      } else {
        state = '';
      }
    });
  }
}
