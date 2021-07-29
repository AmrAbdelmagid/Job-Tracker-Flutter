import 'package:flutter/material.dart';
import 'package:job_tracker_flutter/app/home/cupertino_home_scaffold.dart';
import 'package:job_tracker_flutter/app/home/jobs_page.dart';
import 'package:job_tracker_flutter/app/home/tab_item.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem _currentTap = TabItem.jobs;
  void _select(TabItem tabItem) {
    setState(() => _currentTap = tabItem);
  }

  Map<TabItem, WidgetBuilder> get widgetBuilders {
    return {
      TabItem.jobs: (_) => JobsPage(),
      TabItem.entries: (_) => Container(),
      TabItem.account: (_) => Container(color: Colors.amber),
    };
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoHomeScaffold(
      currentTap: _currentTap,
      onSelected: _select,
      widgetBuilders: widgetBuilders,
    );
  }
}
