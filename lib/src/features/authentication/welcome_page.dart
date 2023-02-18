import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    final String WelcomeWave = 'lib/src/images/svgs/welcome_wave.svg';
    final Widget WelcomeWaveSvg =
        SvgPicture.asset(WelcomeWave, semanticsLabel: 'Acme Logo');

    return MaterialApp(
        home: Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: Container(
                      color: Theme.of(context).splashColor,
                      child: Column(children: <Widget>[
                        Text("Welcome To InStock"),
                        Text("A Small Business' Best Friend"),
                      ]),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.7 - 2,
                    child: WelcomeWaveSvg,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
