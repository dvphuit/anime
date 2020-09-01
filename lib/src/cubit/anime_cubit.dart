import 'package:anime/src/models/anime.dart';
import 'package:anime/src/resources/repository.dart';

import 'base_cubit.dart';

class AnimeCubit extends BaseCubit {
  final Repository _repo;

  AnimeCubit(this._repo) : super(Initial());

  List<Anime> getSlide() => _repo.getSlide();

  Future<void> init() async {
    try {
      emit(Loading());
      await _repo.init();
      emit(Loaded());
    } on Exception catch (e) {
      emit(Error("$e"));
    }
  }

  Future<void> fetchAnime(int page) async {
    try {
      emit(Loading());
      final data = await _repo.fetchAnimes(page);
      emit(Result(data));
    } on Exception catch (e) {
      emit(Error("$e"));
    }
  }
}
