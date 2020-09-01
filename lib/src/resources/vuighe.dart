import 'package:anime/src/models/anime.dart';
import 'package:anime/src/resources/scaper.dart';
import 'package:html/dom.dart';

class VuiGhe extends Scraper {

  @override
  String get baseUrl => "https://vuighe.net/";
  List<Anime> _slides;

  @override
  Future<List<Anime>> fetchAnimes(int page) async {
    return null;
  }

  @override
  Future init() async {
    var doc = await getDocument(baseUrl);
    parseSlides(doc);
    return;
  }

  List<Anime> parseSlides(Document doc) {
    _slides = List<Anime>();
    var elements = doc.querySelectorAll('.slider-item > a');
    elements.forEach((element) {
      var anime = Anime(
          name: element.children[0].attributes['alt'],
          coverUrl: element.children[0].attributes['data-src'],
          href: element.attributes['href']);
      _slides.add(anime);
    });
    return _slides;
  }

  @override
  Future<List<Anime>> getTop() {
    return null;
  }

  @override
  List<Anime> getSlide() => _slides;
}
