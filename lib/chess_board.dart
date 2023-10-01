import 'package:bluetoth_chess/levels/level.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'dart:async';
import 'dart:ui';

class Chess extends FlameGame {
  @override
  Color backgroundColor() => const Color.fromARGB(118, 112, 192, 245);
  late final CameraComponent cam;
  final wor = Level();
  @override
  FutureOr<void> onLoad() {
    cam = CameraComponent.withFixedResolution(
        world: wor, width: 512, height: 512);
    cam.viewfinder.anchor = Anchor.topLeft;
    addAll([cam, wor]);
    return super.onLoad();
  }
}
