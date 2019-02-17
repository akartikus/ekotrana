class Exercice {
  int _timer, _repetition, _counter;
  Exercice(this._repetition, this._timer) {
    this._counter = this._timer;
  }

  void decrement() {
    if (_repetition > 0) {
      if (_counter == 0) {
        _repetition--;
        _counter = _timer;
      }
      _counter--;
    }
  }

  int get counter => _counter;
  int get repetition => _repetition;

  bool isFinish() {
    return (_counter == 0 && _repetition == 0);
  }
}
