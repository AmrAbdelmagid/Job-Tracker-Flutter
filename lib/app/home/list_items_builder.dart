import 'package:flutter/material.dart';
import 'package:job_tracker_flutter/app/home/empty_content.dart';

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T? item);

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
    return ListView.builder(
      itemBuilder: (context, index) => itemBuilder(context, items[index]),
      itemCount: items.length,
    );
  }
}
