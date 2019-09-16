import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ArticleRichText extends StatefulWidget {
  ArticleRichText({Key key, @required this.words}) : super(key: key);
  final List words;

  @override
  ArticleRichTextState createState() => ArticleRichTextState();
}

class ArticleRichTextState extends State<ArticleRichText> {
  MultiTapGestureRecognizer _getTapRecognizer(String word) {
    if (word == "") return null;
    return MultiTapGestureRecognizer()
      ..longTapDelay = Duration(milliseconds: 400)
      ..onLongTapDown = (i, detail) {
        print("onLongTapDown");
      }
      ..onTap = (i) {
        print("onTap");
      };
  }

  // 字符串是否包含字母
  bool hasLetter(String str) {
    RegExp regHasLetter = new RegExp(r"[a-zA-Z]+");
    return regHasLetter.hasMatch(str);
  }

  TextSpan getTextSpan(String word) {
    return TextSpan(
        style: TextStyle(color: Colors.black87, fontFamily: "NotoSans-Medium", fontSize: 20),
        text: hasLetter(word) ? " " : "",
        children: [
          hasLetter(word)
              ? TextSpan(text: word, recognizer: _getTapRecognizer(word))
              : TextSpan(text: word),
          word == "\n" ? TextSpan(text: "   ") : TextSpan(text: "")
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: '   ',
        children: widget.words.map((d) {
          return getTextSpan(d);
        }).toList(),
      ),
    );
  }
}
