import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_tracker_flutter/app/home/tab_item.dart';

class CupertinoHomeScaffold extends StatelessWidget {
  const CupertinoHomeScaffold(
      {required this.currentTap,
      required this.onSelected,
      required this.widgetBuilders});
  final TabItem currentTap;
  final ValueChanged<TabItem> onSelected;
  final Map<TabItem, WidgetBuilder> widgetBuilders;

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          _buildItem(TabItem.jobs),
          _buildItem(TabItem.entries),
          _buildItem(TabItem.account),
        ],
        onTap: (index) => onSelected(TabItem.values[index]),
      ),
      tabBuilder: (context, index) {
        final item = TabItem.values[index];
        return CupertinoTabView(
          builder: (context) {
            return widgetBuilders[item]!(context);
          },
        );
      },
    );
  }

  BottomNavigationBarItem _buildItem(TabItem tabItem) {
    final itemData = TabItemData.allTaps[tabItem];
    return BottomNavigationBarItem(
      icon: Icon(itemData!.icon),
      label: itemData.title,
    );
  }
}
