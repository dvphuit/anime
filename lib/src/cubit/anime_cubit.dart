import 'package:anime/src/models/anime.dart';
import 'package:anime/src/models/routes.dart';
import 'package:anime/src/resources/repository.dart';

import 'base_cubit.dart';

class AnimeCubit extends BaseCubit {
  final Repository _repo;

  AnimeCubit(this._repo) : super(Initial());

  Future<void> get(AnimeRoute route) async {
    print('get $route');
    try {
      emit(Loading());
      switch (route) {
        case AnimeRoute.BANNER:
          var data = await _repo.getBanner();
          emit(Result(route, data));
          print('emit $route');
          break;
        case AnimeRoute.NEW_EP:
          var data = await _repo.getNewEp();
          emit(Result(route, data));
          print('emit $route');
          break;
        case AnimeRoute.RANK:
          var data = await _repo.getRanking();
          emit(Result(route, data));
          print('emit $route');
          break;
        case AnimeRoute.ACTION:
          break;
        case AnimeRoute.ADVENTURE:
          break;
        case AnimeRoute.COMEDY:
          break;
        case AnimeRoute.SPORT:
          break;
        case AnimeRoute.GAME:
          break;
      }
    } on Exception catch (e) {
      emit(Error("$e"));
    }
  }
}
