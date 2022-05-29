import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider_helper/model/installer.dart';
import 'package:http/http.dart' as http;

class InstallersBuilder extends StatefulWidget {
  const InstallersBuilder({Key? key}) : super(key: key);

  @override
  State<InstallersBuilder> createState() => _InstallersBuilderState();
}

class _InstallersBuilderState extends State<InstallersBuilder>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 2, 39),
        title: const Text(
          'Installers',
          maxLines: 2,
          style: TextStyle(
              color: Colors.white, fontSize: 40, fontFamily: 'Montserrat'),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 0, 2, 39),
      body: FutureBuilder<List<Installer>>(
        future: fetchInstallers(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An erorr has occurred'),
            );
          } else if (snapshot.hasData) {
            return InstallersPage(installers: snapshot.data!);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class InstallersPage extends StatelessWidget {
  const InstallersPage({Key? key, required this.installers}) : super(key: key);

  final List<Installer> installers;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemCount: installers.length,
        separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
        itemBuilder: (context, index) {
          fetchInstallers(http.Client());
          return cardBuilder(
              installers[index].name,
              installers[index].pricePerKm.toString(),
              installers[index].rating);
        });
  }

  Widget cardBuilder(String name, String pricePerKm, int rating) {
    return SizedBox(
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  color: Colors
                      .primaries[Random().nextInt(Colors.primaries.length)]),
            ),
            child: Stack(
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    name,
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
                              '\$' + pricePerKm.toString(), 'Price per km'),
                        ],
                      ))
                ]),
                Positioned(top: 20, left: 250, child: showRating(rating)),
                Positioned(
                    top: 10, left: 253, child: showProgressIndicator(rating))
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

  Widget showRating(int value) {
    return Container(
      child: Column(
        children: [
          Text(
            value.toString(),
            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
          ),
         Container (padding: const EdgeInsets.only(top: 20),child:const Text(
            'Rating',
            style: TextStyle(color: Colors.white, fontSize: 15),
          )),
        ],
      ),
    );
  }

  Widget showProgressIndicator(int value) {
    return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.shade300),
      value: value / 10,
    );
  }
}
