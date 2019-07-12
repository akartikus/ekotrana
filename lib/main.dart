import 'package:flutter/material.dart';
import 'package:ekotrana/command_bloc.dart';
import 'package:ekotrana/comnand_event.dart';
import 'package:ekotrana/exercise.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'eKotrana',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  IconData _playIcon = Icons.play_arrow;
  final _commandBloc = CommandBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: StreamBuilder(
          stream: _commandBloc.outExercise,
          initialData: Exercise(3, 30),
          builder: (BuildContext context, AsyncSnapshot<Exercise> snapshot) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '${snapshot.data.counter}',
                        style: Theme.of(context).textTheme.display1,
                      ),
                      Text(
                        '${snapshot.data.repetition}',
                        style: Theme.of(context).textTheme.display1,
                      ),
                    ],
                  )
                ]);
          },
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () => handlePlay(),
            tooltip: 'Play/Pause',
            child: Icon(_playIcon),
          ),
          SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            onPressed: () => handleStop(),
            tooltip: 'Stop',
            child: Icon(Icons.stop),
          ),
        ],
      ),
    );
  }

  void handlePlay() {
    _commandBloc.counterEventSink.add(CommandPlay());
    setState(() {
      _playIcon =
          (_playIcon == Icons.play_arrow) ? Icons.pause : Icons.play_arrow;
    });
  }

  void handleStop() {
    _commandBloc.counterEventSink.add(CommandStop());
    setState(() {
      _playIcon = Icons.play_arrow;
    });
  }
}
