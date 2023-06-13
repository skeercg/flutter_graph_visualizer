import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'edge.dart';
import 'graph_model.dart';
import 'theme.dart';

class GraphData extends StatefulWidget {
  const GraphData({super.key});

  @override
  State<GraphData> createState() => _GraphDataState();
}

class _GraphDataState extends State<GraphData> {
  late final TextEditingController _textEditingController;
  late final ScrollController _textFieldScrollController;
  late final ScrollController _listViewScrollController;
  int _linesCount = 1;

  @override
  void initState() {
    super.initState();
    _textFieldScrollController = ScrollController()
      ..addListener(() {
        _listViewScrollController.jumpTo(_textFieldScrollController.offset);
      });
    _listViewScrollController = ScrollController();
    _textEditingController = TextEditingController()
      ..addListener(() {
        setState(() {
          _linesCount = _textEditingController.text.split('\n').length;

          final edges = _textEditingController.text.split('\n').map((e) {
            final vertices = e.split(' ').map(int.tryParse);
            return Edge(vertices.first, vertices.last);
          }).toList();

          Provider.of<GraphModel>(context, listen: false).setEdges(edges);
        });
      });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _listViewScrollController.dispose();
    _textFieldScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Graph Data:'),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: AppColors.seondary,
                width: 40,
                height: 350,
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context)
                      .copyWith(scrollbars: false),
                  child: ListView.builder(
                    controller: _listViewScrollController,
                    physics: const NeverScrollableScrollPhysics(),
                    padding:
                        const EdgeInsets.only(right: 10, top: 5, bottom: 5),
                    itemBuilder: (context, index) => Text(
                      '${index + 1}',
                      textAlign: TextAlign.end,
                      style: AppFonts.font14,
                    ),
                    itemCount: _linesCount,
                  ),
                ),
              ),
              SizedBox(
                width: 320,
                height: 350,
                child: TextField(
                  controller: _textEditingController,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  maxLines: null,
                  style: AppFonts.font14,
                  cursorColor: Colors.black,
                  scrollController: _textFieldScrollController,
                  scrollPadding: const EdgeInsets.only(top: 5, bottom: 5),
                  decoration: const InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
}
