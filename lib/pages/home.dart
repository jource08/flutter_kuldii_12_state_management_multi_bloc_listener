import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/counter.dart';
import '../bloc/theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    CounterBloc mycounter = context.read<CounterBloc>();
    ThemeBloc mytheme = context.read<ThemeBloc>();
    return Scaffold(
      appBar: AppBar(title: const Text("HOME")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // call to theme bloc
          mytheme.changeTheme();
        },
      ),
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // listen to theme change
          MultiBlocListener(
            listeners: [
              BlocListener<ThemeBloc, bool>(
                listener: (context, state) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("switched to dark mode"),
                    duration: Duration(seconds: 1),
                  ));
                },
                listenWhen: (previous, current) {
                  if (!current) {
                    return true;
                  } else {
                    return false;
                  }
                },
              ),
              //listen to counter bloc
              BlocListener<CounterBloc, int>(
                listener: (context, state) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Diatas 10"),
                    duration: Duration(seconds: 1),
                  ));
                },
                listenWhen: (previous, current) {
                  if (current > 10) {
                    return true;
                  } else {
                    return false;
                  }
                },
              ),
            ],
            child: BlocBuilder<CounterBloc, int>(
              bloc: mycounter,
              builder: (context, state) {
                return Text(
                  "$state",
                  style: const TextStyle(fontSize: 50),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () {
                    mycounter.remove();
                  },
                  icon: const Icon(Icons.remove)),
              IconButton(
                  onPressed: () {
                    mycounter.add();
                  },
                  icon: const Icon(Icons.add))
            ],
          )
        ],
      )),
    );
  }
}
