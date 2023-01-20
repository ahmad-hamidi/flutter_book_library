import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:intl/intl.dart';

class EcommerceBenchmark extends StatefulWidget {
  const EcommerceBenchmark({Key? key}) : super(key: key);

  @override
  State<EcommerceBenchmark> createState() => _EcommerceBenchmarkState();
}

class _EcommerceBenchmarkState extends State<EcommerceBenchmark> {
  bool isLoading = false;
  String searchText = "";

  List<_SalesData> data = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("E-Commerce Benchmark"),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextField(
                      style: TextStyle(fontSize: 18),
                      keyboardType: TextInputType.text,
                      onChanged: (text) {
                        searchText = text;
                      },
                      decoration: InputDecoration(
                        hintText: 'Cari produk',
                        hintStyle: TextStyle(fontSize: 18),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.solid,
                          ),
                        ),
                        filled: true,
                        contentPadding: EdgeInsets.all(16),
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.all(16),
                    child: ElevatedButton(
                        child: Text("Cari", style: TextStyle(fontSize: 18)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          minimumSize: const Size.fromHeight(50), // NEW
                        ),
                        onPressed: () {
                          getData();
                        }),
                  )),
                ],
              ),
            ),
            SizedBox(height: 16),
            isLoading
                ? Expanded(child: _buildLoading())
                : searchText.trim().length == 0
                    ? SizedBox()
                    : _buildSparkLineChar()
          ],
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      enabled: true,
      child: _buildLoadingBar(),
    );
  }

  Widget _buildSparkLineChar() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        //Initialize the spark charts widget
        child: SfSparkBarChart.custom(
          //Enable the trackball
          labelDisplayMode: SparkChartLabelDisplayMode.none,
          highPointColor: Colors.red,
          lowPointColor: Colors.green,
          xValueMapper: (int index) {
            print('sip ${data[index].year}');
            //return "wkwk $index";
            return data[index].year;
          },
          yValueMapper: (int index) {
            print('pke ${data[index].sales}');
            return data[index].sales;
          },
          //Enable the trackball
          trackball: SparkChartTrackball(
              tooltipFormatter: (model) {
                return "${model.x} | ${model.y?.rupiah}";
              },
              activationMode: SparkChartActivationMode.tap),
          labelStyle: TextStyle(fontSize: 24),
          dataCount: data.length,
        ),
      ),
    );
  }

  void getData() {
    _showLoading();
    _parsingData();
    Future.delayed(Duration(seconds: 3)).then((value) {
      _showLoading(isShow: false);
    });
  }

  void _showLoading({bool isShow = true}) {
    isLoading = isShow;
    setState(() {});
  }

  Widget _buildLoadingBar() {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0))),
    );
  }

  void _parsingData() {
    data.clear();
    data.add(
      _SalesData(
          'Tokopedia | bit.ly/Cuan${Random().nextInt(999999)}',
          Random().nextInt(999999).toDouble(),
          "https://www.tokopedia.com/garniermen/garnier-men-acno-fight-12-in-1-foam-100ml-pack-of-3"),
    );
    data.add(
      _SalesData(
          'Shopee | bit.ly/Cuan${Random().nextInt(999999)}',
          Random().nextInt(999999).toDouble(),
          "https://www.tokopedia.com/garniermen/garnier-men-acno-fight-12-in-1-foam-100ml-pack-of-3"),
    );
    data.add(
      _SalesData(
          'Bukalapak | bit.ly/Cuan${Random().nextInt(999999)}',
          Random().nextInt(999999).toDouble(),
          "https://www.tokopedia.com/garniermen/garnier-men-acno-fight-12-in-1-foam-100ml-pack-of-3"),
    );
    data.add(
      _SalesData(
          'Blibli | bit.ly/Cuan${Random().nextInt(999999)}',
          Random().nextInt(999999).toDouble(),
          "https://www.tokopedia.com/garniermen/garnier-men-acno-fight-12-in-1-foam-100ml-pack-of-3"),
    );
    data.add(
      _SalesData(
          'Lazada | bit.ly/Cuan${Random().nextInt(999999)}',
          Random().nextInt(999999).toDouble(),
          "https://www.tokopedia.com/garniermen/garnier-men-acno-fight-12-in-1-foam-100ml-pack-of-3"),
    );
    data.add(
      _SalesData(
          'Sociolla | bit.ly/Cuan${Random().nextInt(999999)}',
          Random().nextInt(999999).toDouble(),
          "https://www.tokopedia.com/garniermen/garnier-men-acno-fight-12-in-1-foam-100ml-pack-of-3"),
    );
    data.add(
      _SalesData(
          'Blanja | bit.ly/Cuan${Random().nextInt(999999)}',
          Random().nextInt(999999).toDouble(),
          "https://www.tokopedia.com/garniermen/garnier-men-acno-fight-12-in-1-foam-100ml-pack-of-3"),
    );
  }
}

class _SalesData {
  _SalesData(this.year, this.sales, this.link);

  final String year, link;
  final double sales;
}

extension Currency on num {
  String get rupiah =>
      NumberFormat.currency(locale: 'id_ID', decimalDigits: 0, symbol: 'Rp. ')
          .format(this);
}
