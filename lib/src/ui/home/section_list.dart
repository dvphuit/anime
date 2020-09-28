import 'package:anime/src/models/anime.dart';
import 'package:flutter/material.dart';

class SectionList extends StatefulWidget {
  final String title;
  final List<Anime> list;

  SectionList({Key key, @required this.title, @required this.list});

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<SectionList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Column(
        children: [_title(), _list()],
      ),
    );
  }

  Widget _title() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 16, right: 8),
          width: 10,
          height: 5,
          color: Colors.red,
        ),
        Text(
          widget.title,
          style: TextStyle(fontSize: 16),
        )
      ],
    );
  }

  Widget _list() {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, __) => _buildBox(color: Colors.orange),
      ),
    );
  }

  Widget _buildBox({Color color}) => Container(margin: EdgeInsets.all(12), height: 100, width: 200, color: color);
}
