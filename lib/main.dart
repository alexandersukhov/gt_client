import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gt_client/app_const.dart';
import 'package:gt_client/dto/measurement_dto.dart';

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

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
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
  var _token;
  List<MeasurementDTO> measurementList = [];

  Future<void> fetchToken() async {
    try {
      Response tokenResponse = await Dio().post(AppConst.token_route, data: "{\"username\": \"oleg\",\"password\": \"oleg\"}");
      setState(() {
        _token = tokenResponse.data["data"]["accessToken"];
      });

      Response dataResponse = await Dio().get(AppConst.measurement_route, options: Options(headers: {"Authorization": "Bearer $_token"}));
      List<dynamic> jsonData = dataResponse.data;
      setState(() {
        measurementList = jsonData.map((x) => MeasurementDTO.fromJson(x)).toList();
        measurementList = measurementList.sublist(measurementList.length-6, measurementList.length);
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
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: measurementList.length,
          itemBuilder: (context, index) {
            return Card(child: Text(measurementList[index].toJson().toString()));
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchToken,
        tooltip: 'Refresh Data',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
