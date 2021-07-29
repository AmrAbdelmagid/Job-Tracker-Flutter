import 'package:flutter/material.dart';
import 'package:job_tracker_flutter/app/account/account_page.dart';
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
    if (tabItem == _currentTap) {
      // pop to first route
      navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
    }
    setState(() => _currentTap = tabItem);
  }

  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.jobs: GlobalKey<NavigatorState>(),
    TabItem.entries: GlobalKey<NavigatorState>(),
    TabItem.account: GlobalKey<NavigatorState>(),
  };

  Map<TabItem, WidgetBuilder> get widgetBuilders {
    return {
      TabItem.jobs: (_) => JobsPage(),
      TabItem.entries: (_) => Container(),
      TabItem.account: (_) => AccountPage(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
          !await navigatorKeys[_currentTap]!.currentState!.maybePop(),
      child: CupertinoHomeScaffold(
        currentTap: _currentTap,
        onSelected: _select,
        widgetBuilders: widgetBuilders,
        navigatorKeys: navigatorKeys,
      ),
    );
  }
}
