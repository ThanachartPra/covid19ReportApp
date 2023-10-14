import 'package:flutter/material.dart';
import 'package:covid19/main.dart';
import 'package:flutter_charts/flutter_charts.dart';

class covid19TablePages extends StatefulWidget {
  const covid19TablePages({Key? key}) : super(key: key);
  State<covid19TablePages> createState() => covid19PagesState();
}

class covid19PagesState extends State<covid19TablePages> {
  void setYears(value) {
    setState(() {
      getYear = value;
      lstData();
    });
  }

  void setMonth(value) {
    setState(() {
      getMonth = value;
      lstData();
    });
  }

  final ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Row(
        children: <Widget>[
          Container(
              width: constraints.maxWidth,
              child: Scrollbar(
                thickness: 10.0,
                thumbVisibility: true,
                controller: controller,
                child: ListView.builder(
                  controller: controller,
                  itemCount: 1,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            typeDropdownMonth(),
                            typeDropdownYears(),
                          ],
                        ),
                        SizedBox(
                          width: constraints.maxWidth,
                          child: TableDataCovid19(),
                        )
                      ],
                    );
                  },
                ),
              )),
        ],
      );
    });
  }

  Widget typeDropdownYears() {
    return DropdownButton(
        value: getYear,
        icon: Icon(Icons.arrow_drop_down),
        elevation: 4,
        items: lstYear.map<DropdownMenuItem<int>>((int value) {
          return DropdownMenuItem(value: value, child: Text('20$value'));
        }).toList(),
        onChanged: (int? value) {
          setYears(value);
        });
  }

  Widget typeDropdownMonth() {
    return DropdownButton(
        value: getMonth,
        icon: Icon(Icons.arrow_drop_down),
        elevation: 12,
        items: lstMonth.map<DropdownMenuItem<int>>((int value) {
          return DropdownMenuItem(value: value, child: Text('$value'));
        }).toList(),
        onChanged: (int? value) {
          setMonth(value);
        });
  }
}

//Function Zone ================================================================

//Widget Zone ==================================================================

Widget dataChartPlot(
    List<String> Type, List<List<double>> Data, List<Color> Color) {
  LabelLayoutStrategy? xContainerLabelLayoutStrategy;
  ChartData chartData;
  ChartOptions chartOptions = const ChartOptions();
  xContainerLabelLayoutStrategy = DefaultIterativeLabelLayoutStrategy(
    options: chartOptions,
  );
  chartData = ChartData(
    dataRows: Data,
    xUserLabels: DatePlot,
    dataRowsLegends: Type,
    dataRowsColors: Color,
    chartOptions: chartOptions,
  );
  var verticalBarChartContainer = VerticalBarChartTopContainer(
    chartData: chartData,
    xContainerLabelLayoutStrategy: xContainerLabelLayoutStrategy,
  );

  var verticalBarChart = VerticalBarChart(
    painter: VerticalBarChartPainter(
      verticalBarChartContainer: verticalBarChartContainer,
    ),
  );
  return verticalBarChart;
}

class TableDataCovid19 extends StatelessWidget {
  const TableDataCovid19({super.key});

  @override
  Widget build(BuildContext context) {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: <TableRow>[
        TableRow(
          children: <Widget>[
            Container(
                color: Colors.cyan,
                child: Center(
                  child: Text(
                    'Date',
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontStyle: FontStyle.normal,
                      color: Colors.black,
                    ),
                  ),
                )),
            Container(
                color: Colors.cyan,
                child: Center(
                  child: Text(
                    'Cases',
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontStyle: FontStyle.normal,
                      color: Colors.black,
                    ),
                  ),
                )),
            Container(
                color: Colors.cyan,
                child: Center(
                  child: Text(
                    'Recovereds',
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontStyle: FontStyle.normal,
                      color: Colors.black,
                    ),
                  ),
                )),
            Container(
                color: Colors.cyan,
                child: Center(
                  child: Text(
                    'Deaths',
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontStyle: FontStyle.normal,
                      color: Colors.black,
                    ),
                  ),
                )),
          ],
        ),
        for (int i = 1; i <= 31; i++) ...[
          TableRow(
            children: <Widget>[
              Container(
                  color: Colors.cyanAccent,
                  child: Center(
                    child: Text(
                      '${i}/${getMonth}/${getYear}',
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontStyle: FontStyle.normal,
                        color: Colors.black,
                      ),
                    ),
                  )),
              Container(
                  color: Colors.cyanAccent,
                  child: Center(
                    child: Text(
                      '${cases['${getMonth}/${i}/${getYear}']}',
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontStyle: FontStyle.normal,
                        color: Colors.black,
                      ),
                    ),
                  )),
              Container(
                  color: Colors.cyanAccent,
                  child: Center(
                    child: Text(
                      '${recovered['${getMonth}/${i}/${getYear}']}',
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontStyle: FontStyle.normal,
                        color: Colors.black,
                      ),
                    ),
                  )),
              Container(
                  color: Colors.cyanAccent,
                  child: Center(
                    child: Text(
                      '${deaths['${getMonth}/${i}/${getYear}']}',
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontStyle: FontStyle.normal,
                        color: Colors.black,
                      ),
                    ),
                  )),
            ],
          ),
        ]
      ],
    );
  }
}
