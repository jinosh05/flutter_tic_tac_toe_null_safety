import 'package:audioplayers/audioplayers.dart';
import 'package:rxdart/rxdart.dart';

class SoundService {
  // ignore: close_sinks
  BehaviorSubject<bool>? _enableSound$;
  BehaviorSubject<bool>? get enableSound$ => _enableSound$;
  late AudioPlayer _fixedplayer;
  late AudioCache _player;

  SoundService() {
    _enableSound$ = BehaviorSubject<bool>.seeded(true);
    _fixedplayer = AudioPlayer();
    _player = AudioCache();
    _player.loadAll(['x.mp3', 'o.mp3', "click.mp3"]);
  }

  playSound(String sound) {
    bool isSoundEnabled = _enableSound$!.value;
    if (isSoundEnabled) {
      _fixedplayer.play(AssetSource("$sound.mp3"));
      // _fixedplayer.play("$sound.mp3");
    }
  }
}
