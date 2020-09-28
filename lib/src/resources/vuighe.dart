import 'package:anime/src/models/anime.dart';
import 'package:anime/src/resources/scaper.dart';
import 'package:html/dom.dart';

class VuiGhe extends Scraper {
  @override
  String get baseUrl => "https://vuighe.net/";

  @override
  Future<List<Anime>> getBanner() async {
    var doc = await getDocument(baseUrl);
    var elements = doc.querySelectorAll('.slider-item > a');
    return elements.map((e) => _parse(e)).toList();
  }

  @override
  Future<List<Anime>> getRanking() async {
    var doc = await getDocument('$baseUrl/bang-xep-hang');
    var elements = doc.querySelectorAll('.tray-item > a');
    return elements.map((e) => _parse(e)).toList();
  }

  @override
  Future<List<Anime>> getNewEp() async {
    var doc = await getDocument('$baseUrl/tap-moi-nhat');
    var elements = doc.querySelectorAll('.tray-item > a');
    return elements.map((e) => _parse(e)).toList();
  }

  Anime _parse(Element element) {
    return Anime(
        name: element.children[0].attributes['alt'],
        coverUrl: element.children[0].attributes['data-src'],
        href: element.attributes['href']);
  }

}
