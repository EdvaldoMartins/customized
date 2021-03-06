import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

enum TxtCase { LowerCase, UpperCase, None }

class Rich {
  final TextStyle style;
  final String key;
  final ValueChanged<String> onRichTap;

  Rich({this.style, @required this.key, this.onRichTap}) {
    assert(key != null);
    assert(style != null);
  }
}

class Txt extends StatelessWidget {
  final Color textColor;
  final double textSize;
  final FontWeight fontWeight;
  final String fontFamily;
  final String value;
  final TxtCase txtCase;
  final int maxLine;
  final Rich rich;
  final TextAlign textAlign;
  final TextOverflow textOverflow;
  final TextStyle textStyle;
  final TextDecoration textDecoration;
  final TextDirection textDirection;
  final Locale locale;
  final String Function(String value) builderText;

  Txt(this.value,
      {this.textColor,
      Key key,
      this.builderText,
      this.textSize,
      this.fontWeight,
      this.fontFamily,
      this.txtCase = TxtCase.None,
      this.maxLine = 0,
      this.textAlign,
      this.rich,
      this.locale,
      this.textDecoration = TextDecoration.none,
      this.textDirection,
      this.textStyle,
      this.textOverflow})
      : assert(value != null),
        assert(txtCase != null),
        super(key: key);

  _caseText(String text) {
    switch (txtCase) {
      case TxtCase.LowerCase:
        return text.toLowerCase();
      case TxtCase.UpperCase:
        return text.toUpperCase();
      default:
        return text;
    }
  }

  List<TextSpan> _getSpans({String text, TextStyle style}) {
    List<TextSpan> spans = [];
    try {
      int spanBoundary = 0;
      do {
        final startIndex = text.indexOf(rich.key, spanBoundary);

        if (startIndex == -1) {
          spans.add(TextSpan(style: style, text: text.substring(spanBoundary)));
          return spans;
        }

        if (startIndex > spanBoundary) {
          spans.add(TextSpan(
              style: style, text: text.substring(spanBoundary, startIndex)));
        }

        final endIndex = startIndex + rich.key.length;

        final spanText = text.substring(startIndex, endIndex);

        spans.add(TextSpan(
            text: spanText,
            style: rich.style,
            recognizer: _onRichTap(spanText)));

        spanBoundary = endIndex;
      } while (spanBoundary < text.length);
    } catch (error) {}
    return spans;
  }

  TapGestureRecognizer _onRichTap(String value) {
    if (rich.onRichTap == null) return null;
    return TapGestureRecognizer()..onTap = () => rich.onRichTap(value);
  }

  @override
  Widget build(BuildContext context) {
    String _text = value;

    if (this.builderText != null) {
      _text = builderText(value);
    }

    assert(_text != null);

    _text = _caseText(_text);

    final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);

    TextStyle _effectiveTextStyle = textStyle;

    final TextAlign _textAlign =
        textAlign ?? defaultTextStyle.textAlign ?? TextAlign.start;

    final TextDirection _textDirection =
        textDirection ?? Directionality.of(context);

    final TextOverflow _textOverflow =
        textOverflow ?? defaultTextStyle.overflow;

    final _locale = locale ?? Localizations.localeOf(context, nullOk: true);

    if (textStyle == null || textStyle.inherit) {
      _effectiveTextStyle = defaultTextStyle.style.merge(textStyle);
    }

    if (fontFamily != null) {
      _effectiveTextStyle =
          _effectiveTextStyle.copyWith(fontFamily: fontFamily);
    }

    if (textColor != null) {
      _effectiveTextStyle = _effectiveTextStyle.copyWith(color: textColor);
    }

    if (textSize != null) {
      _effectiveTextStyle = _effectiveTextStyle.copyWith(fontSize: textSize);
    }

    if (textDecoration != null) {
      _effectiveTextStyle =
          _effectiveTextStyle.copyWith(decoration: textDecoration);
    }

    _effectiveTextStyle = _effectiveTextStyle.copyWith(
      locale: _locale,
      decoration: textDecoration,
    );

    if (rich == null)
      return Text(
        _text,
        maxLines: maxLine == 0 ? null : maxLine,
        locale: _locale,
        overflow: _textOverflow,
        textAlign: _textAlign,
        textDirection: _textDirection,
        style: _effectiveTextStyle,
      );

    var spans = _getSpans(text: _text, style: _effectiveTextStyle);

    return Text.rich(
      TextSpan(style: _effectiveTextStyle, children: spans),
      textAlign: _textAlign,
    );
  }
}
