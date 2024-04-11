import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_example/di.dart';
import 'package:todo_example/presentation/todo/pages/add_todo_page.dart';
import 'package:todo_example/domain/entity/todo.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoList = ref.watch(todoListProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: _TodoListView(
        todoList: todoList,
        onDismissed: (index) {
          ref.read(todoListProvider.notifier).remove(index);
        },
        onCheckboxChanged: (index) {
          ref.read(todoListProvider.notifier).toggleDone(index);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final Todo? todo = await Navigator.push<Todo>(
            context,
            MaterialPageRoute(
              builder: (context) => const AddTodoPage(),
            ),
          );

          ref.read(todoListProvider.notifier).add(todo);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _TodoListView extends StatelessWidget {
  final ValueChanged<int> onDismissed;
  final ValueChanged<int> onCheckboxChanged;
  const _TodoListView({
    required this.todoList,
    required this.onDismissed,
    required this.onCheckboxChanged,
  });

  final List<Todo> todoList;

  @override
  Widget build(BuildContext context) {
    if (todoList.isEmpty) {
      return const Center(
        child: Text('No Todo'),
      );
    }
    return ListView.builder(
      itemCount: todoList.length,
      itemBuilder: (context, index) {
        final todo = todoList[index];
        return Dismissible(
          direction: DismissDirection.endToStart,
          background: Container(
            color: Colors.red,
            child: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
          key: ValueKey(todo),
          onDismissed: (direction) => onDismissed(index),
          child: Row(
            children: [
              Checkbox(
                value: todo.isDone,
                onChanged: (value) => onCheckboxChanged(index),
              ),
              Expanded(
                child: Text(
                  todo.content,
                  style: TextStyle(
                    decoration: todo.isDone ? TextDecoration.lineThrough : null,
                  ),
                ),
              ),
              Text(
                todo.priorityText,
                style: const TextStyle(color: Colors.red),
              ),
              const SizedBox(
                width: 15,
              )
            ],
          ),
        );
      },
    );
  }
}
