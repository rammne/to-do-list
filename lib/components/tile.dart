import 'package:flutter/material.dart';

class ToDoListTile extends StatelessWidget {
  final String data;
  final Function() onDelete;
  final Function() onUpdate;
  final Function(bool?) onCheck;
  final bool value;
  const ToDoListTile({
    super.key,
    required this.data,
    required this.onDelete,
    required this.onUpdate,
    required this.onCheck,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 25,
        left: 25,
        right: 25,
      ),
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: Colors.cyan[300],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Checkbox(
                  value: value,
                  onChanged: onCheck,
                ),
                const SizedBox(
                  width: 12,
                ),
                Text(
                  data,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                IconButton(
                  color: Colors.black,
                  onPressed: onUpdate,
                  icon: const Icon(
                    Icons.settings,
                  ),
                ),
                IconButton(
                  color: Colors.black,
                  onPressed: onDelete,
                  icon: const Icon(
                    Icons.delete,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
