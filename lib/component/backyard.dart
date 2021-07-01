import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:first_flame_game/FlameGame.dart';

class Backyard{
  final FlameGame game;
  Sprite bgSprite;
  Rect backgroundRect;

  Backyard(this.game){
    bgSprite = Sprite('bg/backyard.png');

    backgroundRect = Rect.fromLTWH(0, game.screenSize.height -(game.tileSize*23), game.tileSize * 9, game.tileSize*23);
  }

  void render(Canvas c){
    bgSprite.renderRect(c, backgroundRect);
  }

  void update(double t){}
}