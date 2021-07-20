import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:job_tracker_flutter/app/models/job.dart';
import 'package:job_tracker_flutter/common_widgets/show_alert_dialog.dart';
import 'package:job_tracker_flutter/common_widgets/show_exception_alert_dialog.dart';
import 'package:job_tracker_flutter/services/auth.dart';
import 'package:job_tracker_flutter/services/database.dart';
import 'package:provider/provider.dart';

class JobsPage extends StatelessWidget {
  Future<void> _signOut(context) async {
    final auth = Provider.of<AuthBase>(context, listen: false);
    try {
      await auth.signOut();
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
    }
  }

  Future<void> _confirmSignOut(context) async {
    final bool isConfirmed = await showAlertDialog(
        context: context,
        error: 'Are you sure that you want to sign out?',
        title: 'Sign Out',
        cancelActionText: 'Cancel');
    if (isConfirmed) {
      _signOut(context);
    }
  }

  Future<void> _createJob(BuildContext context) async {
    try {
      final database = Provider.of<Database>(context, listen: false);
      await database.createJob(Job(name: 'Blogging', ratePerHour: '10'));
    } on FirebaseException catch (e) {
      showExceptionAlertDialog(
        context: context,
        title: 'Operation Failed',
        exception: e,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Jobs'),
        actions: [
          TextButton(
            onPressed: () => _confirmSignOut(context),
            child: Text(
              'Sign Out',
              style: TextStyle(
                  color: Theme.of(context).primaryColor, fontSize: 18.0),
            ),
          )
        ],
      ),
      body: StreamBuilder<List<Job?>>(
        stream: database.jobsStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final jobs = snapshot.data;
            final children = jobs!.map((job) => Text(job!.name)).toList();
            return ListView(
              children: children,
            );
          }
          if (snapshot.hasError) {
            log(snapshot.error.toString());
            return Center(child: Text('Some Error Ocurred'));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createJob(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
