import 'package:anylearn/dto/quote_dto.dart';
import 'package:flutter/material.dart';

class HomeQuote extends StatelessWidget {
  final QuoteDTO quote;

  const HomeQuote({key, required this.quote}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: Container(
              padding: EdgeInsets.all(20.0),
              height: 80.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(image: AssetImage("assets/images/quote-bg.png"), fit: BoxFit.cover),
              ),
              child: Text.rich(
                TextSpan(
                  text: quote.text,
                  style: TextStyle(fontSize: 12, color: Colors.white),
                  children: [
                    TextSpan(
                        text: " " + quote.author,
                        style: TextStyle(fontStyle: FontStyle.italic, fontSize: 11, color: Colors.pink[50]))
                  ],
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 10.0,
            child: Container(
              width: 33.0,
              height: 27.0,
              child: Image.asset("assets/images/quote-top.png"),
            ),
          ),
          Positioned(
            right: 10.0,
            bottom: 0,
            child: Container(
              width: 33.0,
              height: 27.0,
              child: Image.asset("assets/images/quote-bottom.png"),
            ),
          ),
        ],
      ),
    );
  }
}
