import 'package:anime/src/models/anime.dart';
import 'package:anime/src/resources/scaper.dart';
import 'package:anime/src/resources/vuighe.dart';

class Repository {
  Scraper scrapper = VuiGhe();

  Future init() async {
    await scrapper.init();
  }

  List<Anime> getSlide() => scrapper.getSlide();

  Future<List<Anime>> fetchAnimes(int page) async {
    return scrapper.fetchAnimes(page);
  }
}
