import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:job_tracker_flutter/app/models/job.dart';
import 'package:job_tracker_flutter/common_widgets/show_alert_dialog.dart';
import 'package:job_tracker_flutter/common_widgets/show_exception_alert_dialog.dart';
import 'package:job_tracker_flutter/services/database.dart';

class EditJobPage extends StatefulWidget {
  final Database database;
  final Job? job;

  const EditJobPage({required this.database, this.job});
  static Future<void> show(BuildContext context,
      {Job? job, required Database database}) async {
    await Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
        builder: (context) => EditJobPage(
          database: database,
          job: job,
        ),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  _EditJobPageState createState() => _EditJobPageState();
}

class _EditJobPageState extends State<EditJobPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    if (widget.job != null) {
      _jobName = widget.job!.name;
      _ratePerHour = int.tryParse(widget.job!.ratePerHour!);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _jobFocusNode.dispose();
    _rateFocusNode.dispose();
  }

  var _jobFocusNode = FocusNode();
  var _rateFocusNode = FocusNode();
  String? _jobName;
  int? _ratePerHour;
  bool isLoading = false;

  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> _submit() async {
    setState(() {
      isLoading = true;
    });
    try {
      if (_validateAndSave()) {
        final jobs = await widget.database.jobsStream().first;
        final allNames = jobs.map((job) => job.name).toList();
        if (widget.job != null) {
          allNames.remove(widget.job!.name);
        }
        if (allNames.contains(_jobName)) {
          setState(() {
            isLoading = false;
          });
          showAlertDialog(
              context: context,
              error: 'Please enter a different job name.',
              title: 'Duplicated Job Name');
        } else {
          final id = widget.job?.jobId ?? documentIdFromCurrentDate();
          final Job job = Job(
              name: _jobName, ratePerHour: _ratePerHour.toString(), jobId: id);
          await widget.database.setJob(job);
          Navigator.of(context).pop();
          setState(() {
            isLoading = false;
          });
        }
      }
    } on FirebaseException catch (e) {
      setState(() {
        isLoading = false;
      });
      showExceptionAlertDialog(
        context: context,
        title: 'Operation Failed',
        exception: e,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text(widget.job != null ? 'Edit Job' : 'Add Job'),
        actions: [
          TextButton(
              onPressed: _submit,
              child: Text(
                'Save',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ))
        ],
      ),
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Job'),
                          initialValue:
                              widget.job != null ? widget.job!.name : null,
                          onSaved: (value) => _jobName = value,
                          validator: (value) => value!.isEmpty
                              ? 'Job name must not be empty'
                              : null,
                          textInputAction: TextInputAction.next,
                          focusNode: _jobFocusNode,
                          onChanged: (value) => _jobName = value,
                          onEditingComplete: () {
                            final newFocus = (_jobName == null)
                                ? _jobFocusNode
                                : _rateFocusNode;
                            FocusScope.of(context).requestFocus(newFocus);
                          },
                        ),
                        TextFormField(
                          initialValue: widget.job != null
                              ? widget.job!.ratePerHour
                              : null,
                          decoration:
                              InputDecoration(labelText: 'Rate Per Hour'),
                          keyboardType: TextInputType.numberWithOptions(
                            signed: false,
                            decimal: false,
                          ),
                          focusNode: _rateFocusNode,
                          validator: (value) => value!.isEmpty
                              ? 'Rate per hour must not be empty'
                              : null,
                          onSaved: (value) =>
                              _ratePerHour = int.tryParse(value ?? ''),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            if (isLoading)
              Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
