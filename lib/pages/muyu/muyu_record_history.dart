import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'models/muyu_merit_record.dart';

class MuYuRecordHistory extends StatelessWidget {
  final List<MuYuMeritRecord> recordList;

  MuYuRecordHistory({Key? key, required this.recordList}) : super(key: key);
  DateFormat format = DateFormat('yyyy年MM月dd日 HH:mm:ss');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: ListView.builder(
        itemBuilder: _buildItem,
        itemCount: recordList.length,
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() => AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        title: const Text(
          '功德记录',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      );

  Widget _buildItem(BuildContext context, int index) {
    MuYuMeritRecord record = recordList[index];
    String date =
        format.format((DateTime.fromMillisecondsSinceEpoch(record.timestamp)));
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue,
        backgroundImage: AssetImage(record.image),
      ),
      title: Text('功德 +${record.value}'),
      subtitle: Text(record.audio),
      trailing: Text(
        date,
        style: const TextStyle(fontSize: 12, color: Colors.grey),
      ),
    );
  }
}
