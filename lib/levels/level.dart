import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'dart:async';

class Level extends World {
  late TiledComponent level;

  @override
  FutureOr<void> onLoad() async {
    level = await TiledComponent.load('Board4.tmx', Vector2.all(32));
    add(level);
    return super.onLoad();
  }
}
