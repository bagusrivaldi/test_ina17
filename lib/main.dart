import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_ina17/bloc/sequence_bloc.dart';
import 'bloc/sequence_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Sequence Generator',
      home: BlocProvider(
        create: (_) => SequenceBloc(),
        child: SequenceScreen(),
      ),
    );
  }
}

class SequenceScreen extends StatefulWidget {
  @override
  _SequenceScreenState createState() => _SequenceScreenState();
}

class _SequenceScreenState extends State<SequenceScreen> {
  final TextEditingController _controller = TextEditingController();
  int selectedButtonIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Sequence Generator')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input Section
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Input N',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),

            // Button Section
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 2,
              children: [
                ElevatedButton(
                  onPressed: () => _onButtonPressed(context, 1),
                  child: Text('1'),
                ),
                ElevatedButton(
                  onPressed: () => _onButtonPressed(context, 2),
                  child: Text('2'),
                ),
                ElevatedButton(
                  onPressed: () => _onButtonPressed(context, 3),
                  child: Text('3'),
                ),
                ElevatedButton(
                  onPressed: () => _onButtonPressed(context, 4),
                  child: Text('4'),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Result Section
            Expanded(
              child: BlocBuilder<SequenceBloc, SequenceState>(
                builder: (context, state) {
                  if (state is SequenceInitial) {
                    return Center(child: Text('Enter a number to generate sequence.'));
                  } else if (state is SequenceLoaded) {
                    return ListView(
                      children: state.sequence
                          .map((e) => Text(
                                e,
                                style: TextStyle(fontSize: 24),
                              ))
                          .toList(),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onButtonPressed(BuildContext context, int buttonIndex) {
    final inputText = _controller.text;
    if (inputText.isNotEmpty) {
      final n = int.parse(inputText);
      BlocProvider.of<SequenceBloc>(context).add(GenerateSequence(n, buttonIndex));
    }
  }
}
