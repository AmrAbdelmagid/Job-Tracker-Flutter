class Job {
  Job({required this.name, required this.ratePerHour, required this.jobId});
  final String? name;
  final String? ratePerHour;
  final String jobId;
  factory Job.fromMap(Map<String, dynamic> data, String jobId) {
    final String name = data['name'];
    final String ratePerHour = data['ratePerHour'];
    return Job(
      name: name,
      ratePerHour: ratePerHour,
      jobId: jobId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'ratePerHour': ratePerHour,
    };
  }
}
