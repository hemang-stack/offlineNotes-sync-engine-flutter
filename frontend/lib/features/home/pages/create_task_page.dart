import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/features/auth/cubit/auth_cubit.dart';
import 'package:frontend/features/tasks/cubit/add_new_task_cubit.dart';
import 'package:frontend/features/tasks/widgets/infocard.dart';
import 'package:frontend/features/tasks/models/task_UI_model.dart';

class CreateTaskPage extends StatefulWidget {
  static MaterialPageRoute route() =>
      MaterialPageRoute(builder: (context) => const CreateTaskPage());
  const CreateTaskPage({super.key});

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  Future<void> _pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2024),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  Future<void> _pickTime() async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  String get formattedDate {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];

    return '${months[selectedDate.month - 1]} '
        '${selectedDate.day}, '
        '${selectedDate.year}';
  }

  String get formattedTime {
    return selectedTime.format(context);
  }

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  String selectedPriority = "High";
  String selectedCategory = "Strategy";

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  void createNewTask() async {
    if (formKey.currentState!.validate()) {
      AuthLoggedIn user = context.read<AuthCubit>().state as AuthLoggedIn;
      final scheduledAt = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime.hour,
        selectedTime.minute,
      );

      final priority = switch (selectedPriority) {
        'High' => TaskPriority.high,
        'Medium' => TaskPriority.medium,
        _ => TaskPriority.low,
      };

      await context.read<AddNewTaskCubit>().createNewTask(
            title: titleController.text.trim(),
            description: descriptionController.text.trim(),
            priority: priority,
            scheduledAt: scheduledAt,
            category: selectedCategory,
            isCompleted: false,
            token: user.user.token,
          );
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddNewTaskCubit, AddNewTaskState>(
      listener: (context, state) {
        if (state is AddNewTaskError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
        }

        if (state is AddNewTaskSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Task Created Successfully'),
            ),
          );

          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        if (state is AddNewTaskLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scaffold(
          backgroundColor: const Color(0xFFF7F6FB),
          appBar: AppBar(
            backgroundColor: const Color(0xFFF7F6FB),
            elevation: 0,
            centerTitle: false,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Color(0xFFFF7A45),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text(
              "Add New Task",
              style: TextStyle(
                color: Color(0xFF0F172A),
                fontSize: 23,
                fontWeight: FontWeight.w700,
              ),
            ),
            // actions: [
            //   TextButton(
            //     onPressed: () {},
            //     child: const Text(
            //       "Save",
            //       style: TextStyle(
            //           color: Color(0xFFFF7A45),
            //           fontWeight: FontWeight.w700,
            //           fontSize: 14),
            //     ),
            //   ),
            // ],
          ),
          body: Form(
            key: formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Task Title
                  TextFormField(
                    controller: titleController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Task title is required';
                      }

                      if (value.trim().length < 3) {
                        return 'Title must be at least 3 characters';
                      }

                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: "Task Title",
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    ),
                  ),

                  const Divider(),

                  const SizedBox(height: 35),

                  // Date & Time
                  Row(
                    children: [
                      Expanded(
                        child: InfoCard(
                          icon: Icons.calendar_today,
                          label: "DATE",
                          value: formattedDate,
                          onTap: _pickDate,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: InfoCard(
                          icon: Icons.access_time,
                          label: "TIME",
                          value: formattedTime,
                          onTap: _pickTime,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 35),

                  const Text(
                    "DESCRIPTION",
                    style: TextStyle(
                      letterSpacing: 1.4,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Container(
                    height: 170,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.05),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: TextFormField(
                      controller: descriptionController,
                      maxLines: 5,
                      validator: (value) {
                        if (value != null && value.trim().length > 200) {
                          return 'Description cannot exceed 200 characters';
                        }

                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: "Add a description...",
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                          left: 8,
                          top: 3,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  const Text(
                    "PRIORITY",
                    style: TextStyle(
                      letterSpacing: 1.4,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEDEAF8),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        _PriorityButton("Low"),
                        _PriorityButton("Medium"),
                        _PriorityButton("High"),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "CATEGORY",
                        style: TextStyle(
                          letterSpacing: 1.4,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: createNewTask,
                        icon: const Icon(
                          Icons.add,
                          size: 18,
                          color: Color(0xFFFF7A45),
                        ),
                        label: const Text(
                          "Add New",
                          style: TextStyle(
                            color: Color(0xFFFF7A45),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _CategoryChip("Design"),
                      _CategoryChip("Sync"),
                      _CategoryChip("Strategy"),
                      _CategoryChip("Personal"),
                    ],
                  ),

                  const SizedBox(height: 50),

                  SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF7A45),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        "Create Task",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _PriorityButton(String value) {
    final selected = selectedPriority == value;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedPriority = value;
          });
        },
        child: Container(
          height: 42,
          decoration: BoxDecoration(
            color: selected ? const Color(0xFFFF7A45) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              value,
              style: TextStyle(
                color: selected ? Colors.white : Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _CategoryChip(String label) {
    final selected = selectedCategory == label;

    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) {
        setState(() {
          selectedCategory = label;
        });
      },
      selectedColor: const Color(0xFFFFE5DC),
      backgroundColor: Colors.white,
      labelStyle: TextStyle(
        color: selected ? const Color(0xFFFF7A45) : Colors.black87,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 95,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 18,
            color: const Color(0xFFFF7A45),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
