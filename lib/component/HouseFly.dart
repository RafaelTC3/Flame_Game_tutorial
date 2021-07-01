import 'package:flame/sprite.dart';
import 'package:first_flame_game/component/fly.dart';
import 'package:first_flame_game/FlameGame.dart';

class HouseFly extends Fly{

  HouseFly(FlameGame game, double x, double y) : super(game, x, y){
    flyingSprite = <Sprite>[];
    flyingSprite.add(Sprite('flies/house-fly-1.png'));
    flyingSprite.add(Sprite('flies/house-fly-2.png'));
    deadSprite = Sprite('flies/house-fly-dead.png');
  }


}
