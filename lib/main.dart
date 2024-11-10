import 'package:weather_switch/animation/weather_animation.dart';
import 'package:weather_switch/constant/app_color.dart';
import 'package:weather_switch/constant/app_constant.dart';
import 'package:weather_switch/constant/image.dart';
import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';

void main() {
  runApp(LayoutBuilder(
    builder: (context, constraints) {
      return SizeConfigInit(
          referenceHeight: 812,
          referenceWidth: 375,
          builder: (context, orientation) => const MyApp());
    },
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late WeatherAnimation animation = WeatherAnimation(this);

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          Center(
            child: AnimatedBuilder(
              animation: animation.animationController,
              builder: (context, child) => GestureDetector(
                onTap: animation.forward,
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: 369.w,
                  height: 145.h,
                  decoration: BoxDecoration(
                      color: animation.opacityDarkBackground.value == 1
                          ? null
                          : AppColor.blueColor,
                      borderRadius: BorderRadius.circular(1000),
                      boxShadow: animation.opacityDarkBackground.value == 1
                          ? []
                          : [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  offset: const Offset(1, 5),
                                  blurRadius: 9),
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  offset: const Offset(0, -1),
                                  blurRadius: 12)
                            ]),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(1000),
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.centerLeft,
                      children: [
                        Positioned.fill(
                            child: FadeTransition(
                                opacity: animation.opacityDarkBackground,
                                child: Image.asset(Images.darkBackground))),
                        _buildCloudView(Images.cloud),
                        _buildCloudView(Images.cloudBack),
                        _buildCircleView(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ]));
  }

  Widget _buildCircleView() {
    return Transform.translate(
      offset: Offset(animation.offsetTransition.value, 0),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          SizedBox(
            width: 120.w,
            height: 120.w,
            child: Stack(
              children: [
                Transform.rotate(
                    angle: animation.rotationSun.value,
                    child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Image.asset(Images.sun))),
                Positioned(
                  right: animation.offsetMoon.value,
                  width: 120.w,
                  height: 120.w,
                  child: Transform.rotate(
                    angle: animation.rotateMoon.value,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Image.asset(
                        Images.moon,
                        width: 120.w,
                        height: 120.w,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ...List.generate(3, _buildOutlineOpacity)
        ],
      ),
    );
  }

  Widget _buildCloudView(String image) {
    return AnimatedBuilder(
      animation: animation.cloudAnim,
      builder: (context, child) => Positioned(
        left: 0,
        right: 0,
        bottom: animation.cloudAnim.value,
        child: Image.asset(image),
      ),
    );
  }

  Widget _buildOutlineOpacity(int index) {
    final offset = -(index * outlineSpacing).toDouble();
    return Positioned(
        left: offset,
        right: offset,
        top: offset,
        bottom: offset,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.1),
            shape: BoxShape.circle,
          ),
        ));
  }
}
