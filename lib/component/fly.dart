import 'dart:ui';

import '../FlameGame.dart';

class Fly {
  final FlameGame game;
  Rect flyRect;
  Paint flyPaint;
  bool isDead = false;
  bool isOffScreen = false;
  Offset targetLocation;

  double get speed => game.tileSize * 3;

  Fly(this.game, double x, double y){
    flyRect = Rect.fromLTWH(x, y, game.tileSize, game.tileSize);
    flyPaint = Paint();
    flyPaint.color = Color(0xff6ab04c);

    setTargetLocation();
  }
  void render(Canvas c) {
    c.drawRect(flyRect, flyPaint);
  }

  void update(double t) {
    if(isDead){
      flyRect = flyRect.translate(0,game.tileSize * 12 * t);
      if (flyRect.top > game.screenSize.height) {
        isOffScreen = true;
      }
    }

    double stepDistance = speed * t;
    Offset toTarget = targetLocation - Offset(flyRect.left, flyRect.top);
    if (stepDistance < toTarget.distance) {
      Offset stepToTarget = Offset.fromDirection(toTarget.direction, stepDistance);
      flyRect = flyRect.shift(stepToTarget);
    } else {
      flyRect = flyRect.shift(toTarget);
      setTargetLocation();
    }
  }

  void onTapDown(){
    isDead = true;
    flyPaint.color = Color(0xffff4757);
    game.spawnFly();
  }

  void setTargetLocation() {
    double x = game.random.nextDouble() * (game.screenSize.width - (game.tileSize * 2.025));
    double y = game.random.nextDouble() * (game.screenSize.height - (game.tileSize * 2.025));
    targetLocation = Offset(x, y);
  }
}