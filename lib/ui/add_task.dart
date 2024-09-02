import 'package:assessment/bloc/task/task_bloc.dart';
import 'package:assessment/data/model/task.dart';
import 'package:assessment/resources/utils/date_picker.dart';
import 'package:assessment/resources/utils/extensions.dart';
import 'package:assessment/resources/utils/functions.dart';
import 'package:assessment/resources/utils/validator.dart';
import 'package:assessment/ui/views/app_input.dart';
import 'package:assessment/ui/views/app_loader.dart';
import 'package:assessment/ui/views/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  static const route = 'add_task_screen';

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  bool _showOtherOptions = false;
  bool _setReminder = false;
  bool _isEdit = false;
  bool _existingTaskInitialized = false;

  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _durationController = TextEditingController();

  TimeOfDay _selectedTime = TimeOfDay.now();
  DateTime? _selectedDate;

  Task? _task;

  late TaskBloc _taskBloc;

  @override
  void initState() {
    _taskBloc = context.read<TaskBloc>();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_existingTaskInitialized) return;
    setState(() => _existingTaskInitialized = true);
    final routeSettings = ModalRoute.of(context)?.settings;
    final argument = routeSettings?.arguments as Map<String, dynamic>?;
    debugPrint(argument.toString());
    setState(() {
      _isEdit = argument?['isEdit'];
      _task = argument?['task'];

      if (_task != null) {
        _titleController.text = _task?.title ?? '';
        _descriptionController.text = _task?.description ?? '';
      }

      if (_task?.duration != null) {
        _setReminder = true;
        _durationController.text = '${_task?.duration ?? ''}';
      }

      final taskDate = _task?.dateTime;

      if (taskDate != null) {
        DateTime? date = DateTime.tryParse(taskDate);
        if (date != null) {
          _selectedDate = date;
          _dateController.text = date.partDayMonthYear;

          _selectedTime = TimeOfDay(hour: date.hour, minute: date.minute);
          _timeController.text =
              '${_selectedTime.hour}:${_selectedTime.minute.padded}';
        }
      }
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: AbsorbPointer(
            child: Row(
              children: [
                Icon(
                  CupertinoIcons.chevron_back,
                  color: cs.onBackground,
                  size: 20,
                ),
                AppText('Home', size: 14, weight: FontWeight.bold)
              ],
            ).padding(left: 20),
          ),
        ),
        leadingWidth: 100,
        actions: [
          TextButton(
            onPressed: _saveTask.withHaptic,
            style: TextButton.styleFrom(foregroundColor: cs.primary),
            child: AppText(
              _isEdit ? 'Update' : 'Save',
              size: 14,
              color: cs.onBackground,
              weight: FontWeight.bold,
            ).padding(right: 20),
          )
        ],
      ),
      body: BlocListener<TaskBloc, TaskState>(
        listener: (context, state) {
          if (state is AddingOrUpdatingTask) {
            Loader.show(context);
          } else {
            Loader.dismiss(context);
          }

          if (state is AddedOrUpdatedTaskSuccessfully) {
            updateTasks();
            Navigator.pop(context);
          }

          if (state is TaskError) {
            showMessage(context, state.errMsg, error: true);
          }
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                AppTextField(
                  hint: 'Title',
                  validator: (value) => Validator.validInput(value, "Title"),
                  controller: _titleController,
                ),
                Divider(color: cs.surface).paddingSymmetric(horizontal: 8),
                AppTextField(
                  hint: 'Description',
                  minLines: 7,
                  maxLines: 7,
                  controller: _descriptionController,
                ),
                GestureDetector(
                  onTap: _toggleDropdown,
                  child: AbsorbPointer(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText("Other Options"),
                        Icon(
                          _showOtherOptions
                              ? CupertinoIcons.chevron_down
                              : CupertinoIcons.chevron_back,
                          size: 20,
                        )
                      ],
                    ).padding(top: 32, bottom: 20),
                  ),
                ),
                AnimatedOpacity(
                  opacity: _showOtherOptions ? 1 : 0,
                  duration: Duration(milliseconds: 600),
                  child: AnimatedSlide(
                    offset: _showOtherOptions ? Offset(0, 0) : Offset(0, -0.5),
                    duration: Duration(milliseconds: 800),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: _pickTaskDate,
                          child: AbsorbPointer(
                            child: AppTextField(
                              hint: 'Date',
                              enabled: false,
                              controller: _dateController,
                              inputType: TextInputType.datetime,
                            ),
                          ),
                        ),
                        Divider(color: cs.surface)
                            .paddingSymmetric(horizontal: 8),
                        GestureDetector(
                          onTap: _pickTaskTime,
                          child: AbsorbPointer(
                            child: AppTextField(
                              hint: 'Time',
                              enabled: false,
                              controller: _timeController,
                              inputType: TextInputType.datetime,
                            ),
                          ),
                        ).padding(bottom: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppText('Set Reminder'),
                            Switch(
                              value: _setReminder,
                              onChanged: _onToggleReminder,
                            ).fitted.size(32, 28)
                          ],
                        ).padding(bottom: 16),
                        AnimatedOpacity(
                          opacity: _setReminder ? 1 : 0,
                          duration: Duration(milliseconds: 600),
                          child: AnimatedSlide(
                            offset:
                                _setReminder ? Offset(0, 0) : Offset(0, -0.5),
                            duration: Duration(milliseconds: 800),
                            child: AppTextField(
                              hint: 'Duration (in minutes before task)',
                              inputType: TextInputType.number,
                              controller: _durationController,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _saveTask() {
    if (_formKey.currentState!.validate()) {
      final title = _titleController.text.trim();
      final description = _descriptionController.text.trim();
      final duration = _durationController.text.trim();

      final localTask = _task ?? Task();
      localTask
        ..title = title
        ..description = description
        ..completed = _isEdit ? _task?.completed : 0;

      localTask.duration = int.tryParse(duration);

      if (_selectedDate != null) {
        final taskDate = _selectedDate!.withTimeOfDay(_selectedTime);
        localTask.dateTime = taskDate.toString();
      }
      _taskBloc.add(AddNewTasksEvent(localTask, isEdit: _isEdit));
    }
  }

  void _toggleDropdown() {
    setState(() => _showOtherOptions = !_showOtherOptions);
  }

  void _pickTaskDate() async {
    final date = await showPlatformDatePicker(context);
    if (date != null) {
      setState(() {
        _selectedDate = date;
        _dateController.text = date.partDayMonthYear;
      });
    }
  }

  void _pickTaskTime() async {
    TimeOfDay? time =
        await showTimePicker(context: context, initialTime: _selectedTime);
    if (time != null) {
      setState(() {
        _selectedTime = time;
        _timeController.text = '${time.hour}:${time.minute.padded}';
      });
    }
  }

  void _onToggleReminder(bool value) {
    setState(() => _setReminder = !_setReminder);
  }

  void updateTasks() {
    _taskBloc.add(FetchTasksEvent());
  }
}
