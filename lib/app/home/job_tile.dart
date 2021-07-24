import 'package:flutter/material.dart';
import 'package:job_tracker_flutter/app/models/job.dart';

class JobTile extends StatelessWidget {
  final Job? job;
  final void Function() onTap;

  const JobTile({required this.job, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(job!.name!),
      onTap: onTap,
      trailing: Icon(Icons.chevron_right),
    );
  }
}
