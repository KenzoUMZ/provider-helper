// ignore: file_names
import 'package:flutter/material.dart';
import 'package:provider_helper/model/constants.dart';

class PlansFilter extends StatefulWidget {
  const PlansFilter({Key? key}) : super(key: key);

  @override
  State<PlansFilter> createState() => _PlansFilterState();
}

class _PlansFilterState extends State<PlansFilter> {
  int? groupValue;
  var result;
  final Text title = const Text(
    'Filter by State',
    maxLines: 2,
    style:
        TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'Montserrat'),
  );
  var pallete = <Color>[
    const Color.fromRGBO(14, 28, 38, 1),
    const Color.fromRGBO(14, 28, 38, 1),
    const Color.fromRGBO(14, 28, 38, 1),
    const Color.fromRGBO(14, 28, 38, 1),
    const Color.fromRGBO(14, 28, 38, 1),
    const Color.fromRGBO(14, 28, 38, 1),
    const Color.fromRGBO(14, 28, 38, 1),
  ];
  Future refresh() async {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title,
        backgroundColor: Color.fromRGBO(14, 28, 38, 1),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 19, 39, 53),
        onPressed: () => {_sendDataBack(context)},
        child: const Text(
          'Apply',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
          decoration: BoxDecoration(gradient: LinearGradient(colors: pallete)),
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Radio<int>(
                      splashRadius: 20,
                      value: index,
                      groupValue: groupValue,
                      // TRY THIS: Try setting the toggleable value to false and
                      // see how that changes the behavior of the widget.
                      toggleable: true,
                      onChanged: (int? value) {
                        setState(() {
                          groupValue = value;
                          result = states[index];
                        });
                      },
                      activeColor: Colors.white,
                      fillColor: MaterialStateColor.resolveWith(
                          (states) => Colors.white)),
                  Text(
                    states[index],
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              );
            },
            itemCount: states.length,
          )),
    );
  }

  void _sendDataBack(BuildContext context) {
    String textToSendBack = result;
    Navigator.pop(context, textToSendBack);
  }
}
