import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';

void main() => runApp(XylophoneApp());

class XylophoneApp extends StatelessWidget {
  static AudioCache player = AudioCache();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              NoteButton(
                  audioCache: player,
                  noteAssetName: 'note1.wav',
                  noteColor: Colors.red
              ),
              NoteButton(
                  audioCache: player,
                  noteAssetName: 'note2.wav',
                  noteColor: Colors.orange
              ),
              NoteButton(
                  audioCache: player,
                  noteAssetName: 'note3.wav',
                  noteColor: Colors.yellow
              ),
              NoteButton(
                  audioCache: player,
                  noteAssetName: 'note4.wav',
                  noteColor: Colors.green
              ),
              NoteButton(
                  audioCache: player,
                  noteAssetName: 'note5.wav',
                  noteColor: Colors.teal
              ),
              NoteButton(
                  audioCache: player,
                  noteAssetName: 'note6.wav',
                  noteColor: Colors.blue
              ),
              NoteButton(
                  audioCache: player,
                  noteAssetName: 'note7.wav',
                  noteColor: Colors.purple
              ),
            ],
          )
        ),
      ),
    );
  }
}

class NoteButton extends StatelessWidget {
  final AudioCache audioCache;
  final String noteAssetName;
  final Color noteColor;

  const NoteButton({
    @required this.audioCache,
    @required this.noteAssetName,
    @required this.noteColor
  }) : assert(audioCache != null),
       assert(noteAssetName != null),
       assert(noteColor != null)

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FlatButton(
        onPressed: () {
          audioCache.play(noteAssetName);
        },
        color: noteColor,
      ),
    );
  }
}

