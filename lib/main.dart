import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gt_client/app_const.dart';
import 'package:gt_client/dto/measurement_dto.dart';
//<uses-permission android:name="android.permission.INTERNET"/>


void main() {
  runApp(MaterialApp(home: MyHomePage(title: "Get Tempure")));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Get Tempure',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),
      ),
      home: const MyHomePage(title: 'Get Tempure'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextStyle TS = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.greenAccent,
  );
  var _token;
  List<MeasurementDTO> measurementList = [];
  MeasurementDTO? lastEl;

  Future<void> fetchData() async {
    try {
      Response tokenResponse = await Dio().post(AppConst.token_route, data: "{\"username\": \"oleg\",\"password\": \"oleg\"}");
      setState(() {
        _token = tokenResponse.data["data"]["accessToken"];
      });

      Response dataResponse = await Dio().get(AppConst.measurement_route, options: Options(headers: {"Authorization": "Bearer $_token"}));
      List<dynamic> jsonData = dataResponse.data;
      setState(() {
        measurementList = jsonData.map((x) => MeasurementDTO.fromJson(x)).toList();
        //measurementList = measurementList.sublist(measurementList.length-6, measurementList.length);
        lastEl = measurementList.last;
      });
      //print(dataResponse.data);
    } catch (e) {
      print('Error fetching token: $e');
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text("Date-Time: ", style: TS),
          Text(lastEl?.time.toString() ?? "??", style: TS),
          ],
        ),
          SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text("Temperature: ", style: TS),
          Text(lastEl?.temperature.toString() ?? "??", style: TS),
            Text(" °C ", style: TS),
          ],
        ),
          SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text("Humidity: ", style: TS),
          Text(lastEl?.humidity.toString() ?? "??", style: TS),
            Text(" %", style: TS),
          ],
        )
      ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchData,
        tooltip: 'Refresh Data',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
