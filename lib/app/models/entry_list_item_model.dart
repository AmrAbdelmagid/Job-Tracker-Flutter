import 'package:flutter/material.dart';
import 'package:job_tracker_flutter/app/home/job_entries/format.dart';
import 'package:job_tracker_flutter/app/models/entry.dart';
import 'package:job_tracker_flutter/app/models/job.dart';

class EntryListItemModel {
  EntryListItemModel(
      {required this.entry, required this.job, required this.context});
  final Entry entry;
  final Job job;
  final BuildContext context;

  String get dayOfWeek => Format.dayOfWeek(entry.start);

  String get startDate => Format.date(entry.start);

  String get startTime => TimeOfDay.fromDateTime(entry.start).format(context);

  String get endTime => TimeOfDay.fromDateTime(entry.end).format(context);

  String get durationFormatted => Format.hours(entry.durationInHours);

  String get payFormatted {
    final pay = double.tryParse(job.ratePerHour!)! * entry.durationInHours;
    return Format.currency(pay);
  }
}
