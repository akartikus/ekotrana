import 'dart:async';
import 'package:ekotrana/comnand_event.dart';
import 'package:ekotrana/exercise.dart';

class CommandBloc {
  Exercise _exercise = Exercise(3, 30);
  bool _isPlaying;
  Timer timer;

  StreamController<Exercise> _exerciseController = StreamController<Exercise>();
  StreamSink<Exercise> get _decExercise => _exerciseController.sink;
  Stream<Exercise> get outExercise => _exerciseController.stream;

  StreamController<String> _messageController = StreamController<String>();
  StreamSink<String> get _setMessage => _messageController.sink;
  Stream<String> get outMessage => _messageController.stream;

  final _actionEventController = StreamController<CommandEvent>();
  Sink<CommandEvent> get counterEventSink => _actionEventController.sink;

  CommandBloc() {
    _isPlaying = false;
    _actionEventController.stream.listen(_handleCommand);
    new Timer.periodic(new Duration(seconds: 1), (timer) {
      _countDown();
    });
  }

  void _countDown() {
    if (_isPlaying) {
      _decExercise.add(_exercise);
      if (!_exercise.isFinish()) {
        _exercise.decrement();
      }
    } else {
      _setMessage.add("Time Out");
    }
  }

  void _handleCommand(CommandEvent event) {
    if (event is CommandPlay) {
      _isPlaying = !_isPlaying;
    }

    if (event is CommandStop) {
      _exercise = Exercise(3, 30);
      _decExercise.add(_exercise);
      _isPlaying = false;
    }
  }

  void dispose() {
    _messageController.close();
    _exerciseController.close();
    _actionEventController.close();
  }
}
