import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/enums.dart';
import '../../logic/cubit/counter_cubit.dart';
import '../../logic/cubit/internet_cubit.dart';

class HomeScreen extends StatefulWidget {
  final String title;
  final Color color;

  const HomeScreen({Key? key, required this.title, required this.color})
      : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text('You have pushed the button this many times:'),
            BlocBuilder<InternetCubit, InternetState>(
              builder: (context, internetState) {
                if (internetState is InternetConnected &&
                    internetState.connectionType == ConnectionType.mobile) {
                  return Text(
                    'Mobile',
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(color: Colors.green),
                  );
                } else if (internetState is InternetConnected &&
                    internetState.connectionType == ConnectionType.wifi) {
                  return Text(
                    'Wifi',
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(color: Colors.green),
                  );
                } else if (internetState is InternetDisconnected) {
                  return Text(
                    'Disconnected',
                    style: Theme.of(context).textTheme.displaySmall!,
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
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
            Builder(builder: (context) {
              var counterState = context.watch<CounterCubit>().state;
              var internetState = context.watch<InternetCubit>().state;
              if (internetState is InternetConnected) {
                return Text(
                    'Counter: ${counterState.counterValue}\nInternet: ${internetState.connectionType.toString()}');
              } else {
                return Text(
                    'Counter: ${counterState.counterValue} Internet: Disconected');
              }
            }),
            const SizedBox(
              height: 24,
            ),
            Builder(builder: (context) {
              var counterValue = context
                  .select((CounterCubit element) => element.state.counterValue);
              return Text(
                'Counter: $counterValue',
                style: Theme.of(context).textTheme.titleLarge,
              );
            }),
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
                Navigator.of(context).pushNamed('/second');
              },
              color: Colors.redAccent,
              child: const Text('Go to Second Screen'),
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
