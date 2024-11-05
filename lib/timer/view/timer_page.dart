import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iba_course_2/ticker.dart';
import 'package:iba_course_2/timer/timer.dart';

class TimerPage extends StatelessWidget {
  const TimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TimerBloc(ticker: const Ticker()),
      child: const TimerView(),
    );
  }
}

class TimerView extends StatelessWidget {
  const TimerView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          Background(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 100),
                child: Center(child: TimerText()),
              ),
              Actions(),
            ],
          ),
        ],
      ),
    );
  }
}

class TimerText extends StatelessWidget {
  const TimerText({super.key});

  @override
  Widget build(BuildContext context) {
    final duration = context.select((TimerBloc bloc) => bloc.state.duration);
    final minutesStr =
        ((duration / 60) % 60).floor().toString().padLeft(2, '0');
    final secondsStr = (duration % 60).toString().padLeft(2, '0');
    return Text(
      '$minutesStr:$secondsStr',
      style: Theme.of(context)
          .textTheme
          .displayLarge
          ?.copyWith(fontWeight: FontWeight.w500),
    );
  }
}

class Actions extends StatelessWidget {
  const Actions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ...switch (state) {
              TimerInitial() => [
                  FloatingActionButton(
                    child: const Icon(Icons.play_arrow),
                    onPressed: () => context
                        .read<TimerBloc>()
                        .add(TimerStarted(duration: state.duration)),
                  ),
                ],
              TimerRunInProgress() => [
                  FloatingActionButton(
                    child: const Icon(Icons.pause),
                    onPressed: () {
                      context.read<TimerBloc>().add(const TimerPaused());
                    },
                  ),
                  FloatingActionButton(
                    child: const Icon(Icons.replay),
                    onPressed: () {
                      context.read<TimerBloc>().add(const TimerReset());
                    },
                  ),
                ],
              TimerRunPause() => [
                  FloatingActionButton(
                    child: const Icon(Icons.play_arrow),
                    onPressed: () {
                      context.read<TimerBloc>().add(const TimerResumed());
                    },
                  ),
                  FloatingActionButton(
                    child: const Icon(Icons.replay),
                    onPressed: () {
                      context.read<TimerBloc>().add(const TimerReset());
                    },
                  ),
                ],
              TimerRunComplete() => [
                  FloatingActionButton(
                    child: const Icon(Icons.replay),
                    onPressed: () {
                      context.read<TimerBloc>().add(const TimerReset());
                    },
                  ),
                ]
            },
          ],
        );
      },
    );
  }
}

class Background extends StatelessWidget {
  const Background({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade50,
              Colors.blue.shade500,
            ],
          ),
        ),
      ),
    );
  }
}
