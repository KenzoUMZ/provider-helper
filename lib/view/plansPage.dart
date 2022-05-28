// ignore: file_names
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider_helper/model/installer.dart';
import 'package:provider_helper/model/plans.dart';
import 'package:http/http.dart' as http;

class PlansBuilder extends StatelessWidget {
  const PlansBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            'Plans',
            maxLines: 2,
            style: TextStyle(
                color: Colors.white, fontSize: 40, fontFamily: 'Montserrat'),
          )),
      backgroundColor: Colors.black,
      body: FutureBuilder<List<Plan>>(
        future: fetchPlans(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            return PlansPage(plans: snapshot.data!);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class PlansPage extends StatefulWidget {
  const PlansPage({super.key, required this.plans});

  final List<Plan> plans;

  @override
  State<PlansPage> createState() => _ProvidersPageState();
}

class _ProvidersPageState extends State<PlansPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      itemCount: widget.plans.length,
      separatorBuilder: (context, index) => const SizedBox(
        height: 10,
      ),
      itemBuilder: (context, index) {
        fetchPlans(http.Client());
        return cardBuilder(
            widget.plans[index].isp,
            widget.plans[index].downloadSpeed,
            widget.plans[index].uploadSpeed.toString(),
            widget.plans[index].typeOfInternet,
            widget.plans[index].pricePerMonth.toString());
      },
    );
  }

  Widget cardBuilder(String isp, int downloadSpeed, String uploadSpeed,
      String typeOfInternet, String price) {
    return SizedBox(
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                    color: Colors
                        .primaries[Random().nextInt(Colors.primaries.length)])),
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
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        children: [
                          showParameter(
                              downloadSpeed.toString() + ' mbps', 'Download'),
                          showParameter(
                              uploadSpeed.toString() + ' mbps', 'Upload'),
                          showParameter(typeOfInternet.toUpperCase(), 'Type')
                        ],
                      ))
                ]),
                Positioned(top: 20, left: 250, child: showPrice(price))
              ],
            )));
  }

  Widget showParameter(String data, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
      child: Column(
        children: [
          Text(
            '\$' + value,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const Text(
            'Price',
            style: TextStyle(color: Colors.white, fontSize: 15),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
