import 'package:anime/src/models/anime.dart';
import 'package:anime/src/resources/data_impl.dart';
import 'package:anime/src/resources/scaper.dart';
import 'package:anime/src/resources/vuighe.dart';

class Repository implements IDataRoutes {
  Scraper scrapper = VuiGhe();

  @override
  Future<List<Anime>> getBanner() async => scrapper.getBanner();

  @override
  Future<List<Anime>> getNewEp() async => scrapper.getNewEp();

  @override
  Future<List<Anime>> getRanking() async => scrapper.getRanking();
}
