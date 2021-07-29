import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:job_tracker_flutter/app/home/empty_content.dart';

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T? item);

// This builder is to manage the four states of the data List
// (has data, has no data, has error and loading states) in generic way

class ListItemsBuilder<T> extends StatelessWidget {
  const ListItemsBuilder(
      {Key? key, required this.snapshot, required this.itemBuilder})
      : super(key: key);
  final AsyncSnapshot<List<T?>> snapshot;
  final ItemWidgetBuilder<T> itemBuilder;

  @override
  Widget build(BuildContext context) {
    if (snapshot.hasData) {
      final List<T?> items = snapshot.data!;
      if (items.isNotEmpty) {
        return _buildList(items);
      } else {
        return EmptyContent();
      }
    } else if (snapshot.hasError) {
      log(snapshot.error.toString());
      return EmptyContent(
        title: 'Something Went Wrong',
        message: 'Can\'t load jobs right now',
      );
    }
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildList(List<T?> items) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      separatorBuilder: (context, index) => Divider(height: 0.5),
      itemBuilder: (context, index) {
        if (index == 0 || index == items.length + 1) {
          return Container();
        }
        return itemBuilder(context, items[index - 1]);
      },
      itemCount: items.length + 2,
    );
  }
}
