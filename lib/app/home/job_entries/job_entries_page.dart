import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:job_tracker_flutter/app/home/edit_job_page.dart';
import 'package:job_tracker_flutter/app/home/list_items_builder.dart';
import 'package:job_tracker_flutter/app/models/entry.dart';
import 'package:job_tracker_flutter/app/models/job.dart';
import 'package:job_tracker_flutter/app/home/job_entries/entry_list_item.dart';
import 'package:job_tracker_flutter/app/home/job_entries/entry_page.dart';
import 'package:job_tracker_flutter/common_widgets/show_exception_alert_dialog.dart';
import 'package:job_tracker_flutter/services/database.dart';

class JobEntriesPage extends StatelessWidget {
  const JobEntriesPage({required this.database, required this.job});
  final Database database;
  final Job job;

  static Future<void> show(BuildContext context,
      {required Database database, required Job job}) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: false,
        builder: (context) => JobEntriesPage(database: database, job: job),
      ),
    );
  }

  Future<void> _deleteEntry(BuildContext context, Entry entry) async {
    try {
      await database.deleteEntry(entry);
    } on FirebaseException catch (e) {
      showExceptionAlertDialog(
        context: context,
        title: 'Operation failed',
        exception: e,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Job>(
      stream: database.jobStream(job),
      builder: (context, snapshot) {
        final job = snapshot.data ?? Job(name: '', ratePerHour: '', jobId: '');
        final jobName = job.name ?? '';
        return Scaffold(
          appBar: AppBar(
            elevation: 2.0,
            title: Text(jobName),
            actions: <Widget>[
              IconButton(
                onPressed: () => EntryPage.show(
                    context: context, database: database, job: job),
                icon: Icon(Icons.add),
              ),
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () =>
                    EditJobPage.show(context, job: job, database: database),
              ),
            ],
          ),
          body: _buildContent(context, job),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context, Job job) {
    return StreamBuilder<List<Entry>>(
      stream: database.entriesStream(job: job),
      builder: (context, snapshot) {
        return ListItemsBuilder<Entry>(
          snapshot: snapshot,
          itemBuilder: (context, entry) {
            return DismissibleEntryListItem(
              key: Key('entry-${entry!.id}'),
              entry: entry,
              job: job,
              onDismissed: () => _deleteEntry(context, entry),
              onTap: () => EntryPage.show(
                context: context,
                database: database,
                job: job,
                entry: entry,
              ),
            );
          },
        );
      },
    );
  }
}
