import 'dart:async';

import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';

const _timerDuration = Duration(milliseconds: 20);
const _timerOffsetMove = .02;
const _stepStopMove = .05;

class WeatherAnimation {
  late final AnimationController _animationController;

  late final Animation<double> rotationSun;
  late final Animation<double> offsetTransition;
  late final Animation<double> cloudAnim;
  late final Animation<double> opacityDarkBackground;
  late final Animation<double> offsetMoon;
  late final Animation<double> rotateMoon;
  late Timer? timer = null;

  AnimationController get animationController => _animationController;

  WeatherAnimation(TickerProviderStateMixin tickerProviderStateMixin) {
    initAnimationController(tickerProviderStateMixin);
    rotationSun = Tween<double>(begin: 0, end: 2 * 3.14).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.linear));
    offsetTransition = Tween<double>(begin: 0, end: 230.w).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.linear));
    cloudAnim = Tween<double>(begin: 0, end: -145.w).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.linear));
    opacityDarkBackground = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
            parent: _animationController, curve: const Interval(0.6, 1)));
    offsetMoon = Tween<double>(begin: -120.w, end: 0).animate(CurvedAnimation(
        parent: _animationController, curve: const Interval(.5, .7)));
    rotateMoon = Tween<double>(begin: 0, end: 2 * 3.14).animate(CurvedAnimation(
        parent: _animationController, curve: const Interval(.5, 1)));
  }

  void onHold(bool isStart) {
    _cancelTimer();
    if (!isStart) {
      if (animationController.value < 0.5) {
        timer = Timer.periodic(_timerDuration, (timer) {
          _animationController.value -= _timerOffsetMove;
          if (_animationController.value <= 0) {
            _cancelTimer();
          }
        });
      } else {
        timer = Timer.periodic(_timerDuration, (timer) {
          _animationController.value += _timerOffsetMove;
          if (_animationController.value >= 1) {
            _cancelTimer();
          }
        });
      }
      return;
    }
    if (animationController.value < 0.5) {
      timer = Timer.periodic(_timerDuration, (timer) {
        _animationController.value += _timerOffsetMove;
        if (_animationController.value >= _stepStopMove) {
          _cancelTimer();
        }
      });
    } else {
      timer = Timer.periodic(_timerDuration, (timer) {
        _animationController.value -= _timerOffsetMove;
        if (_animationController.value >= 1 - _stepStopMove) {
          _cancelTimer();
        }
      });
    }
  }

  void forward() {
    if (_animationController.isCompleted) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
  }

  void reverse() {}

  void initAnimationController(
      TickerProviderStateMixin tickerProviderStateMixin) {
    _animationController = AnimationController(
        duration: const Duration(seconds: 1), vsync: tickerProviderStateMixin);
  }

  void dispose() {
    _animationController.dispose();
    _cancelTimer();
  }

  void _cancelTimer() {
    if (timer != null) {
      timer!.cancel();
    }
  }
}
