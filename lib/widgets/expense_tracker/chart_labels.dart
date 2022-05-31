import 'package:flutter/material.dart';

Widget chartLabels(BuildContext context, double gida, double ulasim,
    double fatura, double abonelik, double diger) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            color: const Color(0xfff8b250),
            child: Padding(
              padding: EdgeInsets.all(6),
              child: Center(
                child: Text(
                  "Gıda\n$gida ₺",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Container(
            color: const Color(0xff845bef),
            child: Padding(
              padding: EdgeInsets.all(6),
              child: Center(
                child: Text(
                  "Ulaşım\n$ulasim ₺",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: const Color(0xff0293ee),
              child: Padding(
                  padding: EdgeInsets.all(6),
                  child: Center(
                    child: Text(
                      "Faturalar\n$fatura ₺",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  )),
            ),
            Container(
              color: const Color(0xff13d38e),
              child: Padding(
                  padding: EdgeInsets.all(6),
                  child: Center(
                    child: Text(
                      "Abonelikler\n$abonelik ₺",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  )),
            ),
            Container(
              color: Colors.pink,
              child: Padding(
                padding: EdgeInsets.all(6),
                child: Center(
                  child: Text(
                    "Diğer\n$diger ₺",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
