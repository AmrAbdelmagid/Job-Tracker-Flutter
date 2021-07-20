import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_tracker_flutter/app/models/job.dart';
import 'package:job_tracker_flutter/services/api_path.dart';
import 'package:job_tracker_flutter/services/firestore_services.dart';

abstract class Database {
  Future<void> createJob(Job job);
  Stream<List<Job?>> jobsStream();
}

class FirestoreDatabase implements Database {
  FirestoreDatabase({required this.uid});
  final String uid;

  final _service = FirestoreServices.instance;

  @override
  Future<void> createJob(Job job) => _service.setData(
        APIPath.job(uid, 'jobId'),
        job.toMap(),
      );

  Stream<List<Job?>> jobsStream() => _service.collectionStream(
        path: APIPath.jobs(uid),
        builder: (data) => Job.fromMap(data),
      );
}
