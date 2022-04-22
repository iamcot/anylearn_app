import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CustomRadio extends StatelessWidget {
  final String groupValue;
  final String value;
  final String label;
  final VoidCallback func;

  const CustomRadio({required this.groupValue, required this.value, required this.func, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Radio(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            groupValue: groupValue,
            value: value,
            onChanged: (value) {
              func();
            },
          ),
          Text.rich(
            TextSpan(
              text: label,
              style: TextStyle(fontSize: 12.0, color: Colors.grey[800]),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  func();
                },
            ),
          ),
        ],
      ),
    );
  }
}
