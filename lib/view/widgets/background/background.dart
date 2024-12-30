  import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Background extends StatelessWidget {
final String url ; 
  const Background({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      child: SvgPicture.asset(url,
              fit: BoxFit.cover,
            ),
    );
  }
}
