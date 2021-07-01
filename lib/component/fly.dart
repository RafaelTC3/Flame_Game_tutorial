import 'dart:ui';

import '../FlameGame.dart';
import 'package:flame/sprite.dart';

class Fly {
  final FlameGame game;
  Rect flyRect;
  bool isDead = false;
  bool isOffScreen = false;
  Offset targetLocation;
  List<Sprite> flyingSprite;
  Sprite deadSprite;
  double flyingSpriteIndex = 0;

  double get speed => game.tileSize * 3;

  Fly(this.game, double x, double y){
    flyRect = Rect.fromLTWH(x, y, game.tileSize, game.tileSize);



    setTargetLocation();
  }
  void render(Canvas c) {
    if(isDead) {
      deadSprite.renderRect(c, flyRect.inflate(2));
    } else {
      flyingSprite[flyingSpriteIndex.toInt()].renderRect(c, flyRect.inflate(2));
    }
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
    game.spawnFly();
  }

  void setTargetLocation() {
    double x = game.random.nextDouble() * (game.screenSize.width - (game.tileSize * 2.025));
    double y = game.random.nextDouble() * (game.screenSize.height - (game.tileSize * 2.025));
    targetLocation = Offset(x, y);
  }
}