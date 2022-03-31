import 'package:html/parser.dart';

class ParseContent {
  String content;

  ParseContent(this.content);

  parser() {
    var doc = parse(content);
    String parsedString = doc.documentElement!.text;

    return parsedString;
  }
}
