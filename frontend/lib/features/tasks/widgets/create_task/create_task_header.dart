import 'package:flutter/material.dart';

class CreateTaskHeader extends StatelessWidget {
  final bool isEdit;

  const CreateTaskHeader({
    super.key,
    this.isEdit = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            isEdit ? "CURATING: EDIT_ENTRY" : "CURATING: NEW_ENTRY",
            style: TextStyle(
              color: Colors.white.withOpacity(.5),
              fontSize: 10,
              letterSpacing: 3,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(.04),
                border: Border.all(
                  color: Colors.white10,
                ),
              ),
              child: const Icon(
                Icons.close,
                color: Colors.white70,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
