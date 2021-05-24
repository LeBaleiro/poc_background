import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';
import 'package:http/http.dart' as http;

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('https://gabul-movies.herokuapp.com/v1/graphql'));
    request.body =
        '''{"query":"mutation MyMutation {\\r\\n  __typename\\r\\n  insert_location(objects: {lat: \\"8\\", long: \\"8\\", device_id: \\"Lê teste lalala\\"}) {\\r\\n    affected_rows\\r\\n  }\\r\\n}","variables":{}}''';

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final lala = await response.stream.bytesToString();
      print("$lala lala");
    } else {
      print(response.reasonPhrase);
    }
    return Future.value(true);
  });
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Future.delayed(Duration(seconds: 30)).then((value) {
    Workmanager().initialize(callbackDispatcher).then((value) {
      Workmanager().registerPeriodicTask(
        "test_workertask",
        "test_workertask",
        frequency: Duration(minutes: 15),
      );
    });
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
