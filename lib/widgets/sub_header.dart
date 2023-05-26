import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SubHeaderTitle extends StatelessWidget {
  const SubHeaderTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Padding(
            padding: EdgeInsets.only(top: 30.0, left: 15.0, right: 15.0, bottom: 5.0), //apply padding to all four sides
            child: Text(
                "Trouvez le repas parfait pour vos invités à chaque occasion",
                style : GoogleFonts.dmSans(
                    textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                textAlign: TextAlign.center),
          ),
        ),
      ],
    );
  }
}
