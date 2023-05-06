import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/cubit/counter_cubit.dart';

class SecondScreen extends StatefulWidget {
  final String title;
  final Color color;

  const SecondScreen({Key? key, required this.title, required this.color})
      : super(key: key);

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: widget.color,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('You have pushed the button this many times:'),
            BlocConsumer<CounterCubit, CounterState>(
              listener: (context, state) {
                ScaffoldMessenger.of(context).removeCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.incrementedOrDecremented!),
                  duration: const Duration(seconds: 1),
                ));
              },
              builder: (context, state) {
                return Text(state.counterValue.toString(),
                    style: Theme.of(context).textTheme.headlineMedium);
              },
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  heroTag: '${widget.title} 1',
                  onPressed: () {
                    context.read<CounterCubit>().decrement();
                    // BlocProvider.of<CounterCubit>(context).decrement();
                  },
                  tooltip: 'Decrement',
                  child: const Icon(Icons.remove),
                ),
                FloatingActionButton(
                  heroTag: '${widget.title} 2',
                  onPressed: () {
                    context.read<CounterCubit>().increment();
                    // BlocProvider.of<CounterCubit>(context).increment();
                  },
                  tooltip: 'Increment',
                  child: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/');
              },
              color: Colors.blueAccent,
              child: const Text('Go to Home Screen'),
            ),
            const SizedBox(
              height: 24,
            ),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/third');
              },
              color: Colors.greenAccent,
              child: const Text('Go to Third Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
