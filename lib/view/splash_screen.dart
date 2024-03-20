import 'dart:async';

import 'package:covid_19_app/view/worlds_states.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
      vsync: this)..repeat();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 5),
    () => Navigator.push(context, MaterialPageRoute(builder: (context)=> const WorldsStates())),
    );
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2B2A2B),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(animation: _controller,
                child: Container(
                  height: 200,
                  width: 200,
                  child: const Center(
                    child: Image(image: AssetImage('asset/image/virus.png')),
                  ),
                ),
                builder: (BuildContext  context, Widget? child){
              return Transform.rotate(angle: _controller.value * 2.0 * math.pi,
              child: child,
              );
                }),
            SizedBox(height: MediaQuery.of(context).size.height * .08,),
            SizedBox(height: 50,),
            const Align(
              alignment: Alignment.center,
              child: Text("Covid-19 App",style: TextStyle(
                color: Colors.white,
                fontFamily: String.fromEnvironment(AutofillHints.birthday),
                fontWeight: FontWeight.bold,
                fontSize: 19,
                letterSpacing: 8
              ),),
            )
          ],
        ),
      ),
    );
  }
}
