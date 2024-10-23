import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Events
abstract class SequenceEvent extends Equatable {
  const SequenceEvent();
}

class GenerateSequence extends SequenceEvent {
  final int n;
  final int buttonIndex;

  const GenerateSequence(this.n, this.buttonIndex);

  @override
  List<Object> get props => [n, buttonIndex];
}

// States
abstract class SequenceState extends Equatable {
  const SequenceState();
}

class SequenceInitial extends SequenceState {
  @override
  List<Object> get props => [];
}

class SequenceLoaded extends SequenceState {
  final List<String> sequence;

  const SequenceLoaded(this.sequence);

  @override
  List<Object> get props => [sequence];
}

// BLoC
class SequenceBloc extends Bloc<SequenceEvent, SequenceState> {
  SequenceBloc() : super(SequenceInitial()) {
    on<GenerateSequence>(_onGenerateSequence);
  }

  void _onGenerateSequence(
      GenerateSequence event, Emitter<SequenceState> emit) {
    int n = event.n;
    int buttonIndex = event.buttonIndex;

    List<String> result;

    switch (buttonIndex) {
      case 1:
        result = _generate1toN(n);
        break;
      case 2:
        result = _generateNto1toN(n);
        break;
      case 3:
        result = _generateAlternating(n);
        break;
      case 4:
        result = _generateLimaTujuh(n);
        break;
      default:
        result = [];
    }

    emit(SequenceLoaded(result));
  }

  List<String> _generate1toN(int n) {
    return List.generate(n, (index) => (index + 1).toString());
  }

  List<String> _generateNto1toN(int n) {
    List<String> result = [];
    for (int i = 1; i <= n; i++) {
      result.add(i.toString());
    }
    for (int i = n - 1; i >= 1; i--) {
      result.add(i.toString());
    }
    return result;
  }

  List<String> _generateAlternating(int n) {
    List<String> result = [];
    int number = n;
    for (int i = 0; i < 6; i++) {
      result.add(number.toString());
      number += (i % 2 == 0) ? 5 : 11;
    }
    return result;
  }

  List<String> _generateLimaTujuh(int n) {
    List<String> result = [];
    for (int i = 1; i <= n; i++) {
      if (i % 5 == 0) {
        result.add("LIMA");
      } else if (i % 7 == 0) {
        result.add("TUJUH");
      } else {
        result.add(i.toString());
      }
    }
    return result;
  }
}
