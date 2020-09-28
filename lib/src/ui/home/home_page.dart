import 'package:anime/src/cubit/anime_cubit.dart';
import 'package:anime/src/cubit/base_cubit.dart';
import 'package:anime/src/models/anime.dart';
import 'package:anime/src/models/routes.dart';
import 'package:anime/src/resources/repository.dart';
import 'package:anime/src/ui/home/section_list.dart';
import 'package:anime/src/ui/home/slide_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:anime/src/models/routes.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class Section {
  final AnimeRoute route;
   List<Anime> list;

  Section(this.route, this.list);
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin<HomePage> {
  AnimeCubit _cubit;
  List<Section> _routes = List<Section>()
    ..add(Section(AnimeRoute.BANNER, []));
//    ..add(Section(AnimeRoute.NEW_EP, []));

  @override
  void initState() {
    super.initState();
    if (_cubit == null) {
      _cubit = AnimeCubit(Repository());
      _routes.forEach((section) {
        _cubit.get(section.route);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CubitProvider(
      create: (context) => _cubit,
      child: ListView.builder(
        itemCount: _routes.length,
        itemBuilder: (_, i) {
          if(_routes[i].route == AnimeRoute.BANNER){
            return SlideComponent();
          }else{
            return SectionList(title: "abc", list: []);
          }
        },
      ),
    );
  }

   _cubitProvider(int index) {
     CubitProvider(
      create: (context) => _cubit,
      child: CubitBuilder<AnimeCubit, ViewState>(builder: (context, state) {
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
          return _routes[index].list = state.data;
        }
        return Container();
      }),
    );
  }
//
//  Widget _section(AnimeRoute route, List<Anime> list) {
//    switch (route) {
//      case AnimeRoute.BANNER:
//        print("banner loaded");
//        return SlideComponent(animes: list);
//        break;
//      case AnimeRoute.NEW_EP:
//        print("new_ep loaded");
//        return SectionList(title: route.toString(), list: []);
//        break;
//      case AnimeRoute.RANK:
//        print("rank loaded");
//        return Container();
//        break;
//      default:
//        return Container();
//    }
//  }

  @override
  bool get wantKeepAlive => false;
}
