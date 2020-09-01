import 'package:anime/src/models/anime.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart';

abstract class Scraper {
  String baseUrl;

  Future<Document> getDocument(String url) async {
    var res = await Client().get(Uri.parse(url));
    print(url);
    if (res.statusCode == 200) {
      return parse(res.body);
    }
    throw Exception("can not parse document.");
  }

  Future init();

  List<Anime> getSlide();

  Future<List<Anime>> fetchAnimes(int page);

  Future<List<Anime>> getTop();
}
