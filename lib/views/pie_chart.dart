import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:developer';

class PieChart extends StatefulWidget {
  const PieChart({super.key});

  @override
  State<PieChart> createState() => _PieChartState();
}

class _PieChartState extends State<PieChart> {
  int deletedItemCount = 0;
  int noteItemCount = 0;
  int archivedItemsCount = 0;

  // late var deletedItemCount = getDeletedItems();
  List<PieData> chartData = [];

  void addPieData() {
    chartData.add(PieData(deletedItemCount, "Deleted Notes"));
    chartData.add(PieData(archivedItemsCount, "Archived Notes"));
    chartData.add(PieData(noteItemCount, "Notes"));
    setState(() {});
  }

  Future<void> getDeletedItems() async {
    final result = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('notes')
        .where('isDeleted', isEqualTo: true)
        .get();
    deletedItemCount = result.docs.length;
    log('$deletedItemCount');
  }

  Future<void> getArchivedItems() async {
    final result = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('notes')
        .where('isArchive', isEqualTo: true)
        .get();
    archivedItemsCount = result.docs.length;
    log('$archivedItemsCount');
  }

  Future<void> notesItems() async {
    final result = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('notes')
        .where('isDeleted', isEqualTo: false)
        .where('isArchive', isEqualTo: false)
        .get();
    noteItemCount = result.docs.length;
    log('$noteItemCount');
  }

  @override
  void initState() {
    super.initState();
    getDeletedItems();
    notesItems();
    getArchivedItems();
    addPieData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes Pie Data"),
      ),
      body: Column(
        children: [
          Container(
              height: 400,
              margin: const EdgeInsets.all(10),
              child: SfCircularChart(
                backgroundColor: Colors.black,
                title: ChartTitle(
                    text:
                        'Notes Analysis \n Note count: $noteItemCount \n archiv count: $archivedItemsCount\n deleteCount: $deletedItemCount'),
                legend: Legend(isVisible: true),
                series: [
                  PieSeries<PieData, String>(
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                    explode: true,
                    explodeIndex: 4,
                    dataSource: chartData,
                    xValueMapper: (PieData data, _) => data.xData,
                    yValueMapper: (PieData data, _) => data.yData,
                    dataLabelMapper: (PieData data, _) => data.xData,
                  )
                ],
              )),
        ],
      ),
    );
  }
}

class PieData {
  final int yData;
  final String xData;

  PieData(this.yData, this.xData);
}
