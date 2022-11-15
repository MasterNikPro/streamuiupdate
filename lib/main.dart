import 'package:flutter/material.dart';
import 'package:streambuilderapilive/ApiDir/currency_api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

TextEditingController tx = TextEditingController();
bool flag = false;

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          color: Colors.black,
          child: StreamBuilder<double>(
              stream: CurrencyApi.getPrice(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Container(color:Colors.black,child: Center(child: const CircularProgressIndicator()));
                  default:
                    if (snapshot.hasError) {
                      return const Text('Some error occurred!');
                    } else {
                      final bitcoins = snapshot.data!.toStringAsFixed(2);

                      return Column(children: [
                        Image.network(
                            "https://imageio.forbes.com/specials-images/imageserve/61119c500f0713e04e419c4e/Bitcoin-currency-icon/960x0.jpg?format=jpg&width=960"),
                        Container(
                          margin: const EdgeInsets.only(top: 30, bottom: 10),
                          child: Text(
                            "BTC:$bitcoins",
                            style: const TextStyle(
                                fontSize: 21, color: Colors.white),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left:10,top: 30, bottom: 10,right: 10,),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            style: const TextStyle(color: Colors.white),
                            controller: tx,
                            decoration: InputDecoration(
                              label: const Text(
                                "Enter Sum to convert",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 3, color: Colors.white),
                                //<-- SEE HERE
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                            ),
                          ),
                        ),
                        tx.text.isNotEmpty
                            ? Container(
                                margin:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                child: Text(
                                  "Converted Sum ${((1 * (int.parse(tx.text) / double.parse(bitcoins))))}",
                                  style: const TextStyle(color: Colors.white,fontSize: 21),
                                ))
                            : Container(
                                margin:
                                    const EdgeInsets.only(top: 10, bottom: 25),
                                child: const Text("enter value to convert",
                                    style: TextStyle(color: Colors.white)))
                      ]);
                    }
                }
              }),
        ),
      ),
    );
  }
}
