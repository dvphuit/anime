import 'package:anime/src/models/anime.dart';
import 'package:anime/src/ui/app_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SlideComponent extends StatefulWidget {
  final List<Anime> animes;

  SlideComponent({Key key, this.animes});

  @override
  State<StatefulWidget> createState() {
    return _SlideState();
  }
}

class _SlideState extends State<SlideComponent> {
  var _position = 0.0;
  final _controller = PageController(viewportFraction: .92);

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      _position = _controller.page;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 130,
          child: _buildPagerViewSlider(),
        ),
        Indicator(widget.animes.length, _position)
      ],
    );
  }


  Widget _buildPagerViewSlider() {
    return PageView.builder(
        controller: _controller,
        itemCount: widget.animes.length,
        pageSnapping: true,
        itemBuilder: (BuildContext context, int i) {
          var anime = widget.animes[i];
          return Card(
              elevation: 2,
              clipBehavior: Clip.antiAlias,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: anime.coverUrl,
                    fit: BoxFit.fill,
                    placeholder: (context, url) =>
                        new Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => new Icon(Icons.error),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    alignment: Alignment.bottomLeft,
                    child: Text(anime.name,
                        style: TextStyle(
                            color: Colors.white,
                            letterSpacing: -0.5,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(1),
                                offset: Offset(0, 0),
                                blurRadius: 10,
                              ),
                            ])),
                  )
                ],
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2)));
        });
  }
}

class Indicator extends StatefulWidget {
  final int length;
  final double position;

  Indicator(this.length, this.position);

  @override
  State<StatefulWidget> createState() => IndicatorState();
}

class IndicatorState extends State<Indicator> {
  var index = 0.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: CustomPaint(
            painter: IndicatorPainter(widget.length, widget.position),
            child: Container(height: 8)));
  }

  void callback(int i) {
    setState(() {
      index = i.toDouble();
    });
  }
}

class IndicatorPainter extends CustomPainter {
  var _length = 0;
  var _padding = 10;
  var _radius = 2.5;
  var _position = 1.0;

  IndicatorPainter(int length, double position) {
    this._length = length;
    this._position = position;
  }

  @override
  void paint(Canvas canvas, Size size) {
    _style1(canvas, size);
//    _style2(canvas, size);
  }

  _style2(Canvas canvas, Size size) {
    var _dotPaint = Paint()
      ..color = accentColor
      ..style = PaintingStyle.fill;

    var _circlePaint = Paint()
      ..color = accentColor
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;

    //draw dots
    var centerX = size.width / 2;
    var startX = centerX - _padding * _position;
    var centerY = size.height / 2;
    for (var i = 0; i < _length; i++) {
      canvas.drawCircle(
          Offset(startX + _padding * i, centerY), _radius, _dotPaint);
    }

    //draw circle
    canvas.drawCircle(Offset(centerX, centerY), _radius + 2, _circlePaint);
  }

  var startX = 0.0;

  void _style1(Canvas canvas, Size size) {
    var _dotPaint = Paint()
      ..color = Colors.grey.shade400
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.square;

    var _indicatorPaint = Paint()
      ..color = accentColor
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.square;

    //draw dots
    var centerX = size.width / 2;
    startX = centerX - (_length ~/ 2) * _padding;
    var centerY = size.height / 2;
    for (var i = 0; i < _length; i++) {
      canvas.drawLine(Offset(startX + _padding * i, centerY),
          Offset(startX + _padding * i + 5, centerY), _dotPaint);
    }

    //draw transition
    var value = 2 * (_position.round() - _position);
    var sx = value > 0
        ? startX + _padding * (_position.ceil() - value)
        : startX + _padding * _position.toInt();
    var ex = value > 0
        ? startX + _padding * _position.round()
        : startX + _padding * (_position.toInt() - value);
    canvas.drawLine(
        Offset(sx, centerY), Offset(ex + 5, centerY), _indicatorPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  @override
  bool hitTest(Offset position) {
    var index = ((position.dx - startX) / _padding).round();
    print("clicked $index");
    return false;
  }
}
