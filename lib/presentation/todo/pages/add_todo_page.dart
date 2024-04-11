import 'package:flutter/material.dart';
import 'package:todo_example/domain/entity/todo.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  late final TextEditingController _contentController;
  TodoPriority _priority = TodoPriority.none;

  @override
  void initState() {
    super.initState();
    _contentController = TextEditingController();
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Add Todo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              final content = _contentController.text;
              if (content.isEmpty) {
                return;
              }
              final todo = Todo(
                content: content,
                isDone: false,
                priority: _priority,
              );
              Navigator.of(context).pop(todo);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Content'),
            TextField(
              key: const Key('contentTextField'),
              autofocus: true,
              controller: _contentController,
              decoration: const InputDecoration(
                hintText: 'Enter your content',
              ),
            ),
            const SizedBox(height: 15),
            _TodoPrioritySelector(
              currentPriority: _priority,
              onPriorityChanged: _onPriorityChanged,
            ),
          ],
        ),
      ),
    );
  }

  void _onPriorityChanged(TodoPriority? priority) {
    setState(() {
      _priority = priority ?? TodoPriority.none;
    });
  }
}

class _TodoPrioritySelector extends StatelessWidget {
  final TodoPriority currentPriority;
  final ValueChanged<TodoPriority> onPriorityChanged;

  const _TodoPrioritySelector({
    required this.currentPriority,
    required this.onPriorityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Priority'),
        Row(
          children: [
            for (final priority in TodoPriority.values)
              Row(
                children: [
                  Radio<TodoPriority>(
                    value: priority,
                    groupValue: currentPriority,
                    onChanged: (priority) {
                      if (priority != null) {
                        onPriorityChanged(priority);
                      }
                    },
                  ),
                  Text(priority.name),
                ],
              ),
          ],
        ),
      ],
    );
  }
}
