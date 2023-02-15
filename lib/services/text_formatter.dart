import 'package:intl/intl.dart';

class TextFormatter {
  static String formatPrice(int value) {
    var numberFormat = NumberFormat("#,##0", "id_ID");
    return numberFormat.format(value);
  }

  static String alternateText(String text, String alternativeText) {
    return text == '' ? alternativeText : text;
  }

  static String stringToHTML(String content) {
    // regex for replace all url to html link
    String content0 = content.trim();
    final urlRegExp = RegExp(
        r"((https?:www\.)|(https?://)|(www\.))[-a-zA-Z0-9@:%._+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(/[-a-zA-Z0-9()@:%_+.~#?&/=]*)?");
    final urlMatches = urlRegExp.allMatches(content0);
    List<String> urls = urlMatches.map(
            (urlMatch) => content0.substring(urlMatch.start, urlMatch.end))
        .toList().toSet().toList(); // distinct urls

    // replace all url to html link
    for (var x in urls) {
      String link = '<a href="$x">$x</a>';
      content0 = content0.replaceAll(x, link);
    }

    /*RegExp exp = new RegExp(r'(?:(?:https?|ftp)://)?[\w/\-?=%.]+\.[\w/\-?=%.]+');
    Iterable<RegExpMatch> matches = exp.allMatches(content);

    matches.forEach((match) {
      // print(text.substring(match.start, match.end));
      String _val = _content.substring(match.start, match.end);
      String _link = '<a href=\"$_val\">$_val<\/a>';
      _val = _val.replaceAll('/', '\/');
      logInfo("$_val => $_link", label: 'link');
      _content = _content.replaceAll(_val, _link);
    });*/

    // replace break lines
    content0 = content0.replaceAll('\n\n\n\n', '<br>');
    content0 = content0.replaceAll('\n\n\n', '<br>');
    content0 = content0.replaceAll('\n\n', '<br>');
    content0 = content0.replaceAll('\n', '<br>');

    return "<p>$content0</p>";
  }

  static String htmlToString(String content) {
    // replace with custom tag
    content = content.replaceAll('<br>', '%br%');
    content = content.replaceAll('<p>', '%p%');
    content = content.replaceAll('</p>', '%/p%');
    content = content.replaceAll('<p>&nbsp;</p>', '');
    // content = content.replaceAll('\r\n', '\n');
    content = content.replaceAll('\r\n\r\n', '');
    // remove all html tags (escape custom tags)
    content = Bidi.stripHtmlIfNeeded(content);
    // replace break line custom tags
    content = content.replaceAll('&nbsp;', ' ');
    content = content.replaceAll(RegExp(' +'), ' ');
    content = content.replaceAll('%br%', '\n');
    content = content.replaceAll('%p%', '\n');
    content = content.replaceAll('%/p%', '');
    // remove duplicate whitespaces
    content = content.trim();

    return content;
  }
}

String toDash(String value) {
  return value == '' ? '-' : value;
}