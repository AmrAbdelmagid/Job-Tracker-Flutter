import 'package:job_tracker_flutter/app/models/job.dart';
import 'package:job_tracker_flutter/services/api_path.dart';
import 'package:job_tracker_flutter/services/firestore_services.dart';

abstract class Database {
  Future<void> setJob(Job job);
  Future<void> deleteJob(Job job);
  Stream<List<Job?>> jobsStream();
}

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase implements Database {
  FirestoreDatabase({required this.uid});
  final String uid;

  final _service = FirestoreServices.instance;
  @override
  Future<void> setJob(Job job) => _service.setData(
        APIPath.job(uid, job.jobId),
        job.toMap(),
      );

  @override
  Future<void> deleteJob(Job job) async => _service.deleteData(
        path: APIPath.job(uid, job.jobId),
      );

  @override
  Stream<List<Job?>> jobsStream() => _service.collectionStream(
        path: APIPath.jobs(uid),
        builder: (data, docId) => Job.fromMap(data, docId),
      );
}
