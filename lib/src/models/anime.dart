class Anime {
  final String name;
  final String coverUrl;
  final String rate;
  final String href;
  final String chap;
  final String views;

  Anime(
      {this.name, this.coverUrl, this.rate, this.href, this.chap, this.views});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Anime && other.name == name && other.href == href;
  }

  @override
  int get hashCode => name.hashCode ^ href.hashCode;

  @override
  String toString() {
    return "{$name, $coverUrl, $rate, $href, $chap, $views";
  }
}
