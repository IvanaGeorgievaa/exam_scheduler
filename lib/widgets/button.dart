import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonFormField extends StatelessWidget {
  final Color _textColor;
  final Color _backgroundColor;
  final String _text;
  final EdgeInsets _margins;
  final Function() _onPressedFunction;

  const ButtonFormField(this._margins, this._onPressedFunction, this._text,
      this._backgroundColor, this._textColor,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _margins,
      child: ElevatedButton(
        onPressed: () {
          _onPressedFunction();
        },
        child: Text(_text),
        style: ElevatedButton.styleFrom(
          backgroundColor: _backgroundColor,
          textStyle: TextStyle(color: _textColor),
          padding: const EdgeInsets.all(8.0),
          minimumSize: const Size(300, 50),
        ),
      ),
    );
  }
}
