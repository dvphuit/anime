import 'package:anime/src/models/anime.dart';
import 'package:anime/src/resources/data_impl.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart';

abstract class Scraper  implements IDataRoutes{
  String baseUrl;

  Future<Document> getDocument(String url) async {
    var res = await Client().get(Uri.parse(url));
    print(url);
    if (res.statusCode == 200) {
      return parse(res.body);
    }
    throw Exception("can not parse document.");
  }

}
