import 'package:anime/src/models/anime.dart';

abstract class IDataRoutes{
  Future<List<Anime>> getBanner();

  Future<List<Anime>> getNewEp();

  Future<List<Anime>> getRanking();

}