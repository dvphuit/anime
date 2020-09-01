import 'package:anime/src/resources/repository.dart';
import 'package:anime/src/ui/home/slide_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';

import '../../cubit/anime_cubit.dart';
import '../../cubit/base_cubit.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  AnimeCubit _cubit;

  @override
  void initState() {
    super.initState();
    if (_cubit == null) {
      _cubit = AnimeCubit(Repository());
      _cubit.init();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Wrap(
      runSpacing: 8,
      children: [
        _header()
      ],
    );
  }

  Widget _header() {
    return CubitProvider(
      create: (context) => _cubit,
      child: CubitBuilder<AnimeCubit, ViewState>(
        builder: (context, state) {
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
                GestureDetector(
                  onTap: () => _cubit.init(),
                  child: Icon(Icons.cloud_off, size: 50),
                ),
                Text(state.msg, textAlign: TextAlign.center),
              ],
            );
          }
          if (state is Loaded) {
            print("Initialized");
            return SlideComponent(animes: _cubit.getSlide());
          }
          if (state is Loaded) {
            return Container();
          }
          return Container();
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
