import 'package:flutter/material.dart';

import 'custom_progress.dart';
import 'custom_text.dart';

abstract class _CustomButton extends StatelessWidget {
  final Function onPressed;
  final Color activeColor;
  final Color disabledColor;
  final Color textColor;
  final String text;
  final double border;
  final double elevation;
  final TextStyle textStyle;
  final TxtCase txtCase;
  final FontWeight fontWeight;
  final double textSize;
  final bool enableEffectClicked;
  final String Function(String value) builderText;

  const _CustomButton({
    this.onPressed,
    this.enableEffectClicked = true,
    this.activeColor,
    this.disabledColor,
    this.textColor,
    this.builderText,
    this.text,
    this.txtCase,
    this.textStyle,
    this.textSize = 16.0,
    this.fontWeight,
    this.border = 8.0,
    this.elevation = 8.0,
  })  : assert(disabledColor != null),
        assert(text != null);

  body({@required Widget child, @required BuildContext context}) {
    var _activeColor = activeColor ?? Theme.of(context).accentColor;

    return ClipRRect(
      borderRadius: BorderRadius.circular(border),
      child: MaterialButton(
        splashColor: (enableEffectClicked) ? null : Colors.transparent,
        highlightColor: (enableEffectClicked) ? null : Colors.transparent,
        disabledColor: disabledColor,
        elevation: elevation,
        color: _activeColor,
        height: 50,
        minWidth: double.infinity,
        child: child,
        onPressed: onPressed,
      ),
    );
  }
}

class DefaultButton extends _CustomButton {
  DefaultButton({
    @required String value,
    double border,
    double elevation,
    TextStyle textStyle,
    TxtCase txtCase = TxtCase.None,
    FontWeight fontWeight,
    Color textColor,
    Color activeColor,
    Color disabledColor,
    String Function(String value) builderText,
    @required Function onPressed,
  })  : assert(value != null),
        super(
            text: value,
            activeColor: activeColor,
            disabledColor: disabledColor ?? Colors.grey[200],
            textColor: textColor ?? Colors.white,
            textStyle: textStyle,
            elevation: elevation,
            builderText: builderText,
            txtCase: txtCase,
            border: border ?? 8.0,
            fontWeight: fontWeight ?? FontWeight.normal,
            onPressed: onPressed);

  @override
  Widget build(BuildContext context) => body(
      context: context,
      child: Txt(
        text,
        builderText: builderText,
        textColor: textColor,
        txtCase: txtCase,
        fontWeight: fontWeight,
        textStyle: textStyle,
        textSize: textSize,
      ));
}

class CustomProgressButton extends _CustomButton {
  CustomProgressButton({
    this.isLoading = false,
    this.ignorePlatform = false,
    @required String value,
    double border,
    double elevation,
    TextStyle textStyle,
    FontWeight fontWeight,
    Color textColor,
    Color activeColor,
    Color disabledColor,
    TxtCase txtCase = TxtCase.None,
    String Function(String value) builderText,
    @required Function onPressed,
  })  : assert(value != null),
        assert(isLoading != null),
        super(
            text: value,
            activeColor: activeColor,
            disabledColor: disabledColor ?? Colors.grey[200],
            textColor: textColor ?? Colors.white,
            textStyle: textStyle,
            txtCase: txtCase,
            builderText: builderText,
            elevation: elevation ?? 0.0,
            border: border ?? 8.0,
            fontWeight: fontWeight ?? FontWeight.normal,
            onPressed: (isLoading) ? null : onPressed);

  final bool isLoading;

  final bool ignorePlatform;

  @override
  Widget build(BuildContext context) {
    if (!isLoading)
      return body(
          context: context,
          child: Txt(
            text,
            txtCase: txtCase,
            builderText: builderText,
            textColor: textColor,
            fontWeight: fontWeight,
            textStyle: textStyle,
            textSize: textSize,
          ));
    else
      return body(
          context: context,
          child: Center(
            child: CustomProgress(
              color: activeColor,
              ignorePlatform: ignorePlatform,
            ),
          ));
  }
}
