import 'dart:async';
import 'package:ekotrana/comnand_event.dart';
import 'package:ekotrana/exercice.dart';

class CommandBloc {
  Exercice _exercice = Exercice(3, 30);
  bool _isPlaying;
  Timer timer;

  StreamController<Exercice> _exerciceController = StreamController<Exercice>();
  StreamSink<Exercice> get _decExercice => _exerciceController.sink;
  Stream<Exercice> get outExercice => _exerciceController.stream;

  StreamController<String> _messageController = StreamController<String>();
  StreamSink<String> get _setMessage => _messageController.sink;
  Stream<String> get outMessage => _messageController.stream;

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
      _decExercice.add(_exercice);
      if (!_exercice.isFinish()) {
        _exercice.decrement();
      }
    } else {
      _setMessage.add("Time Out");
    }
  }

  void _handleLogic(CommandEvent event) {
    if (event is CommandPlay) {
      _isPlaying = !_isPlaying;
    }

    if (event is CommandStop) {
      _exercice = Exercice(3, 30);
      _decExercice.add(_exercice);
      _isPlaying = false;
    }
  }

  void dispose() {
    _messageController.close();
    _exerciceController.close();
    _actionEventController.close();
  }
}
