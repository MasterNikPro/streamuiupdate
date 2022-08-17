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

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: StreamBuilder<double>(
            stream: CurrencyApi.getPrice(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(child: CircularProgressIndicator());
                default:
                  if (snapshot.hasError) {
                    return const Center(child: Text('Some error occurred!'));
                  } else {
                    final bitcoins = snapshot.data!.toStringAsFixed(2);

                    return Center(child: Text("currency:$bitcoins",style: const TextStyle(height: 28),),);
                  }
              }
            }),
      ),
    );
  }
}
