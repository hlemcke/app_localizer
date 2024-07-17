import 'package:flutter/material.dart';

import 'main.i18n.dart';

class CounterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int count = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('counter.page.title'.i18n),
        ),
        body: SafeArea(
          minimum: EdgeInsets.all(5.0),
          child: _buildBody(),
        ),
      );

  Widget _buildBody() => Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('counter.push.info'.fill([count])),
            Text('counter.push.info'.plural(count)),
            Text(
              '$count',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            IconButton(
              icon: Icon(Icons.plus_one_outlined),
              onPressed: () => setState(() => count++),
            ),
          ],
        ),
      );
}
