import 'dart:ui';
import 'package:first_flame_game/component/fly.dart';
import 'package:flame/game/game.dart';
import 'package:flame/flame.dart';
import 'package:flame/gestures.dart';
import 'dart:math';
import 'package:flutter/gestures.dart';
import 'package:first_flame_game/component/backyard.dart';
import 'package:first_flame_game/component/HouseFly.dart';

class FlameGame extends Game with TapDetector{
  Size screenSize;
  double tileSize;
  List<Fly> flyList;
  Random random;
  Backyard background;


  FlameGame(){
    initialize();
  }

  Future<void> initialize() async{
    flyList = <Fly>[];//<Fly>[] substitui List<Fly>();
    random = Random();
    resize(await Flame.util.initialDimensions());
    background = Backyard(this);
    spawnFly();
  }

  void render(Canvas canvas) {
    background.render(canvas);

    flyList.forEach((Fly fly) => fly.render(canvas));

  }

  void update(double t) {
    flyList.forEach((Fly fly) => fly.update(t));
    flyList.removeWhere((Fly fly) => fly.isOffScreen);
  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 9;
  }

  void spawnFly() {
    double x = random.nextDouble() * (screenSize.width - tileSize);
    double y = random.nextDouble() * (screenSize.height - tileSize);
    flyList.add(HouseFly(this, x, y));
  }

  @override
  void onTapDown(TapDownDetails details){
    for (int i = 0; i < flyList.length; i++) {
      if (flyList[i].flyRect.contains(details.globalPosition)) {
        flyList[i].onTapDown();
      }
    }
  }

}