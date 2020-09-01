import 'package:anime/src/models/anime.dart';
import 'package:anime/src/resources/scaper.dart';

class AnimeHay extends Scraper {
  @override
  String get baseUrl => "http://animehay.tv/";

  @override
  Future<List<Anime>> fetchAnimes(int page) async {
    var list = List<Anime>();
    var url = baseUrl + "phim-moi-cap-nhap?page=$page";
    var doc = await getDocument(url);
    var elements = doc.querySelectorAll('.ah-pad-film > a');
    elements.forEach((element) {
      var anime = Anime(
          name: element.children[3].text,
          coverUrl: element.children[0].attributes['src'],
          rate: element.children[2].text,
          href: element.attributes['href'],
          chap: element.children[1].text.trim());
      list.add(anime);
    });
    return list;
  }

  @override
  Future<List<Anime>> getTop() {
    return null;
  }

  @override
  Future init() {
    // TODO: implement init
    throw UnimplementedError();
  }

  @override
  List<Anime> getSlide() {
    return null;
  }

}
