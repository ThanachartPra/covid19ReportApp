import 'package:covid19/Pages/covid19TablePages.dart';
import 'package:covid19/Pages/covid19MainPages.dart';
import 'package:covid19/Pages/covid19ChartPages.dart';

import 'package:flutter/material.dart';

import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

List<List<double>> CasesDataPlots = [casesData];
List<List<double>> DeathsDataPlots = [deathData];
List<List<double>> RecoveredsDataPlots = [recoveredData];
List<String> CasesTypePlot = ['Cases [1:100,000]'];
List<String> DeathsTypePlot = ['Deaths [1:100,000]'];
List<String> RecoveredsTypePlot = ['Recovereds [1:100,000]'];
List<Color> CasesColors = [Color.fromRGBO(0, 255, 0, 60)];
List<Color> DeathsColors = [Color.fromRGBO(255, 0, 0, 60)];
List<Color> RecoveredsColors = [Color.fromRGBO(0, 174, 255, 60)];
List<String> DatePlot = [
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
  '7',
  '8',
  '9',
  '10',
  '11',
  '12',
  '13',
  '14',
  '15',
  '16',
  '17',
  '18',
  '19',
  '20',
  '21',
  '22',
  '23',
  '24',
  '25',
  '26',
  '27',
  '28',
  '29',
  '30',
  '31'
];
List<double> TestData = [
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0
];
List<double> casesData = [
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0
];
List<double> deathData = [
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0
];
List<double> recoveredData = [
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0
];
List<int> lstYear = [20, 21, 22, 23];
int getYear = 23;
List<int> lstMonth = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
int getMonth = 12;
double testDataNow = 0.0;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    getData();
    return MaterialApp(
      title: 'Covid19 Report',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Covid19 Report'),
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
  int intCurrentIndex = 1;

  final screen = [
    const covid19ChartPages(),
    const covid19MainPages(),
    const covid19TablePages(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(widget.title),
      ),
      body: screen[intCurrentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: intCurrentIndex,
        onTap: (index) => setState(() {
          intCurrentIndex = index;
        }),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Chart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.circle),
            label: 'Main',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_on),
            label: 'Table',
          ),
        ],
      ),
    );
  }
}

var jsonData;
Map<String, dynamic> cases = {};
Map<String, dynamic> deaths = {};
Map<String, dynamic> recovered = {};
Future<String> getData() async {
  final url =
      Uri.parse('https://disease.sh/v3/covid-19/historical/all?lastdays=0');
  http.Response response =
      await http.get(url, headers: {"Content-Type": "application/json"});
  jsonData = json.decode(response.body);
  cases = jsonData['cases'];
  deaths = jsonData['deaths'];
  recovered = jsonData['recovered'];
  return ("ok");
}

void lstData() async {
  TestData.removeRange(0, TestData.length);
  for (int i = 1; i <= 31; i++) {
    if ((cases['${getMonth}/${i}/${getYear}'] != null)) {
      testDataNow = cases['${getMonth}/${i}/${getYear}'] / 10000;
      TestData.add(testDataNow);
    } else {
      TestData.add(0.0);
    }
  }
  casesData.replaceRange(0, 31, TestData);
  TestData.removeRange(0, TestData.length);
  for (int i = 1; i <= 31; i++) {
    if ((cases['${getMonth}/${i}/${getYear}'] != null)) {
      testDataNow = deaths['${getMonth}/${i}/${getYear}'] / 10000;
      TestData.add(testDataNow);
    } else {
      TestData.add(0.0);
    }
  }
  deathData.replaceRange(0, 31, TestData);
  TestData.removeRange(0, TestData.length);
  for (int i = 1; i <= 31; i++) {
    if ((cases['${getMonth}/${i}/${getYear}'] != null)) {
      testDataNow = recovered['${getMonth}/${i}/${getYear}'] / 10000;
      TestData.add(testDataNow);
    } else {
      TestData.add(0.0);
    }
  }
  recoveredData.replaceRange(0, 31, TestData);
}
