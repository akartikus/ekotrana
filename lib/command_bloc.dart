import 'dart:async';
import 'package:ekotrana/comnand_event.dart';

class CommandBloc {
  int _timer = 30;
  int _repetition;
  bool _isPlaying;
  Timer timer;

  StreamController<int> _timerController = StreamController<int>();
  StreamSink<int> get _decTimer => _timerController.sink;
  Stream<int> get outCounter => _timerController.stream;

  final _actionEventController = StreamController<CommandEvent>();
  Sink<CommandEvent> get counterEventSink => _actionEventController.sink;

  CommandBloc() {
    _isPlaying = false;
    _actionEventController.stream.listen(_handleLogic);
    new Timer.periodic(new Duration(seconds: 1), (timer) {
      countDown();
    });
  }

  void countDown() {
    if (_isPlaying) {
      _timer--;
      _decTimer.add(_timer);
    }
  }

  void _handleLogic(CommandEvent event) {
    if (event is CommandPlay) {
      _isPlaying = !_isPlaying;
    }

    if (event is CommandStop) {
      _timer = 30;
      _decTimer.add(_timer);
      _isPlaying = false;
    }
  }

  void dispose() {
    _timerController.close();
    _actionEventController.close();
  }
}
