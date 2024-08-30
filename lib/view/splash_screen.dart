import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:i_bot/view/home.dart';
import 'package:i_bot/widget/ui/custom_textstyle.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _gotosplash();
  }

  Future<void> _gotosplash() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 500,
                    width: 350,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          "assets/Screenshot_2024-08-29_145039-removebg-preview.png",
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Text(
                      'Let’s make your day great right now',
                      textAlign: TextAlign.center,
                      style: CustomTextStyle.highboldTxtStyle,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * .20,
              child: AnimatedTextKit(
                animatedTexts: [
                  TyperAnimatedText(
                    'Connect with i bot...',
                    textStyle: CustomTextStyle.swipeTextStyle,
                    speed: const Duration(milliseconds: 90),
                  ),
                ],
                totalRepeatCount: 1,
                pause: const Duration(milliseconds: 1000),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
