import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:job_tracker_flutter/app/home/edit_job_page.dart';
import 'package:job_tracker_flutter/app/home/job_entries/job_entries_page.dart';
import 'package:job_tracker_flutter/app/home/job_tile.dart';
import 'package:job_tracker_flutter/app/home/list_items_builder.dart';
import 'package:job_tracker_flutter/app/models/job.dart';
import 'package:job_tracker_flutter/common_widgets/show_exception_alert_dialog.dart';
import 'package:job_tracker_flutter/services/database.dart';
import 'package:provider/provider.dart';

class JobsPage extends StatelessWidget {
  Future<void> _delete(BuildContext context, Job job) async {
    final database = Provider.of<Database>(context, listen: false);
    try {
      await database.deleteJob(job);
    } on FirebaseException catch (e) {
      showExceptionAlertDialog(
        context: context,
        title: 'Error',
        exception: e,
      );
    }
  }
  // Future<void> _createJob(BuildContext context) async {
  //   try {
  //     final database = Provider.of<Database>(context, listen: false);
  //     await database.createJob(Job(name: 'Blogging', ratePerHour: '10'));
  //   } on FirebaseException catch (e) {
  //     showExceptionAlertDialog(
  //       context: context,
  //       title: 'Operation Failed',
  //       exception: e,
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Jobs'),
        actions: [
          IconButton(
            onPressed: () => EditJobPage.show(context, database: database),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: StreamBuilder<List<Job?>>(
        stream: database.jobsStream(),
        builder: (context, snapshot) {
          return ListItemsBuilder<Job>(
            snapshot: snapshot,
            itemBuilder: (context, job) => Dismissible(
              key: Key('${job!.jobId}'),
              background: Container(
                child: Container(
                  color: Colors.red,
                ),
              ),
              direction: DismissDirection.endToStart,
              onDismissed: (dismiss) => _delete(context, job),
              child: JobTile(
                  job: job,
                  onTap: () {
                    JobEntriesPage.show(context, job: job, database: database);
                  }),
            ),
          );
        },
      ),
    );
  }
}
