import 'package:flutter/material.dart';

import '../../page_index.dart';
import '../index.dart';

class LabVoteResultPage extends StatefulWidget {
  final int id;

  LabVoteResultPage({Key key, this.id}) : super(key: key);

  @override
  createState() => _LabVoteResultPageState();
}

class _LabVoteResultPageState extends State<LabVoteResultPage> {
  List<Option> options = [];

  ResponseBean baseData;

  LoaderState status = LoaderState.Loading;

  @override
  void initState() {
    super.initState();

    getData(widget.id);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(title: Text('')),
      body: LoaderContainer(
        loaderState: status,
        contentView: ListView.separated(
            itemBuilder: (_, index) => ItemVoteOptions(option: options[index]),
            separatorBuilder: (_, index) => Gaps.vGap5,
            itemCount: options.length),
      ),
    );
  }

  void getData(int id) async {
    baseData = await ApiService.getQDailyVoteResult(id);

    options.addAll(baseData.everyoneAttitude);
    setState(() {
      status = LoaderState.Succeed;
    });
  }
}
