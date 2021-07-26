import 'package:flutter/material.dart';
import 'package:job_tracker_flutter/app/models/entry.dart';
import 'package:job_tracker_flutter/app/models/entry_list_item_model.dart';
import 'package:job_tracker_flutter/app/models/job.dart';

class EntryListItem extends StatelessWidget {
  const EntryListItem({
    required this.model,
    required this.entry,
    required this.job,
    required this.onTap,
  });
  final EntryListItemModel model;
  final Entry entry;
  final Job job;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: _buildContents(context),
            ),
            Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildContents(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(children: <Widget>[
          Text(model.dayOfWeek,
              style: TextStyle(fontSize: 18.0, color: Colors.grey)),
          SizedBox(width: 15.0),
          Text(model.startDate, style: TextStyle(fontSize: 18.0)),
          if (double.tryParse(job.ratePerHour!)! > 0.0) ...<Widget>[
            Expanded(child: Container()),
            Text(
              model.payFormatted,
              style: TextStyle(fontSize: 16.0, color: Colors.green[700]),
            ),
          ],
        ]),
        Row(children: <Widget>[
          Text('${model.startDate} - ${model.endTime}',
              style: TextStyle(fontSize: 16.0)),
          Expanded(child: Container()),
          Text(model.durationFormatted, style: TextStyle(fontSize: 16.0)),
        ]),
        if (entry.comment!.isNotEmpty)
          Text(
            entry.comment!,
            style: TextStyle(fontSize: 12.0),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
      ],
    );
  }
}

class DismissibleEntryListItem extends StatelessWidget {
  const DismissibleEntryListItem({
    required this.key,
    required this.entry,
    required this.job,
    required this.onDismissed,
    required this.onTap,
  });

  final Key key;
  final Entry entry;
  final Job job;
  final VoidCallback onDismissed;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(color: Colors.red),
      key: key,
      direction: DismissDirection.endToStart,
      onDismissed: (direction) => onDismissed(),
      child: EntryListItem(
        model: EntryListItemModel(entry: entry, job: job, context: context),
        job: job,
        entry: entry,
        onTap: onTap,
      ),
    );
  }
}
