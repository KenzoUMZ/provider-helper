// ignore: file_names
import 'dart:math';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:provider_helper/model/plans.dart';
import 'package:http/http.dart' as http;

class InstallersBuilder extends StatelessWidget {
  const InstallersBuilder({super.key});

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
      body: FutureBuilder<List<Provider>>(
        future: fetchProviders(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            return ProvidersPage(providers: snapshot.data!);
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

class ProvidersPage extends StatefulWidget {
  const ProvidersPage({super.key, required this.providers});

  final List<Provider> providers;

  @override
  State<ProvidersPage> createState() => _ProvidersPageState();
}

class _ProvidersPageState extends State<ProvidersPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: widget.providers.length,
      separatorBuilder: (context, index) => const SizedBox(
        height: 10,
      ),
      itemBuilder: (context, index) {
        fetchProviders(http.Client());
        return cardBuilder(
            widget.providers[index].isp,
            widget.providers[index].download_speed,
            widget.providers[index].upload_speed.toString(),
            widget.providers[index].type_of_internet,
            widget.providers[index].price_per_month.toString());
      },
    );
  }

  

  Widget cardBuilder(String isp, int downloadSpeed, String uploadSpeed,
      String typeOfInternet, String price) {
    return BlurryContainer(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        blur: 5,
        color: Colors.primaries[Random().nextInt(Colors.primaries.length)]
            .withOpacity(0.1),
        child: Row(
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
                      showParameter(downloadSpeed.toString(), 'Download'),
                      showParameter(uploadSpeed.toString(), 'Upload'),
                      showParameter(typeOfInternet.toUpperCase(), 'Type')
                    ],
                  ))
            ]),
            showPrice(price)
          ],
        ));
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
      padding: const EdgeInsets.only(left: 100),
      child: Column(
        children: [
          Text(
            value,
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
  bool get wantKeepAlive => true;
}
