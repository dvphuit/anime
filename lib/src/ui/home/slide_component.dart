import 'package:anime/src/cubit/anime_cubit.dart';
import 'package:anime/src/cubit/base_cubit.dart';
import 'package:anime/src/models/anime.dart';
import 'package:anime/src/ui/app_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';

class SlideComponent extends StatefulWidget {
  SlideComponent({Key key});

  @override
  State<StatefulWidget> createState() {
    return _SlideState();
  }
}

class _SlideState extends State<SlideComponent> {
  var _position = 0.0;
  final _controller = PageController(viewportFraction: 1);

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
    return CubitBuilder<AnimeCubit, ViewState>(builder: (context, state) {
      if (state is Loading) {
        print("Loading");
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is Error) {
        print("Error");
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.cloud_off, size: 50),
            Text(state.msg, textAlign: TextAlign.center),
          ],
        );
      }
      if (state is Result) {
        print("result ${state.route}");
        return SizedBox(
          height: 150,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              _buildPagerViewSlider(state.data),
              IgnorePointer(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      tileMode: TileMode.clamp,
                      begin: Alignment(0, 1),
                      end: Alignment(0, 0.4),
                      stops: [0, .8],
                      colors: [primaryColor, Colors.transparent],
                    ),
                  ),
                ),
              ),
              Indicator(state.data, _position),
            ],
          ),
        );
      }
      return Container();
    });
  }

  Widget _buildPagerViewSlider(List<Anime> data) {
    return PageView.builder(
        controller: _controller,
        itemCount: data.length,
        pageSnapping: true,
        itemBuilder: (BuildContext context, int i) {
          var anime = data[i];
          return Stack(
            fit: StackFit.expand,
            children: [
              CachedNetworkImage(
                imageUrl: anime.coverUrl,
                fit: BoxFit.fill,
                placeholder: (context, url) => new Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => new Icon(Icons.error),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                alignment: Alignment.bottomCenter,
                child: Text(anime.name,
                    style: TextStyle(
                        color: Colors.white,
                        letterSpacing: -0.5,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        shadows: [
                          Shadow(
                            color: Colors.black,
                            blurRadius: 5,
                          ),
                        ])),
              ),
            ],
          );
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
        child: CustomPaint(painter: IndicatorPainter(widget.length, widget.position), child: Container(height: 16)));
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
      canvas.drawCircle(Offset(startX + _padding * i, centerY), _radius, _dotPaint);
    }

    //draw circle
    canvas.drawCircle(Offset(centerX, centerY), _radius + 2, _circlePaint);
  }

  var startX = 0.0;

  void _style1(Canvas canvas, Size size) {
    var _dotPaint = Paint()
      ..color = Colors.grey.shade400
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    var _indicatorPaint = Paint()
      ..color = accentColor
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    //draw dots
    var centerX = size.width / 2;
    startX = centerX - (_length ~/ 2) * _padding;
    var centerY = size.height / 2;
    for (var i = 0; i < _length; i++) {
      canvas.drawLine(Offset(startX + _padding * i, centerY), Offset(startX + _padding * i + 5, centerY), _dotPaint);
    }

    //draw transition
    var value = 2 * (_position.round() - _position);
    var sx = value > 0 ? startX + _padding * (_position.ceil() - value) : startX + _padding * _position.toInt();
    var ex = value > 0 ? startX + _padding * _position.round() : startX + _padding * (_position.toInt() - value);
    canvas.drawLine(Offset(sx, centerY), Offset(ex + 5, centerY), _indicatorPaint);
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
