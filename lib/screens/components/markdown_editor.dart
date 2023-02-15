import 'package:admin/components/forms/custom_text_field.dart';
import 'package:admin/services/clipboard_manager.dart';
import 'package:admin/services/constant_lib.dart';
import 'package:admin/services/link_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';

class MarkdownEditor extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  const MarkdownEditor({Key? key,
    required this.controller,
    required this.label,
  }) : super(key: key);

  @override
  State<MarkdownEditor> createState() => _MarkdownEditorState();
}

class _MarkdownEditorState extends State<MarkdownEditor> {
  bool editing = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade600)
      ),
      constraints: const BoxConstraints(
          minHeight: 280
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.label, style: Get.textTheme.bodySmall),
              Row(
                children: [
                  TextButton(
                    child: const Text('Copy'),
                    onPressed: () => ClipboardManager.clip(widget.controller.text),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        editing = !editing;
                      });
                    },
                    child: const Text('Edit'),
                  ),
                  TextButton(
                    child: const Text('Edit Online'),
                    onPressed: () {
                      ClipboardManager.clip(widget.controller.text);
                      LinkLauncher.url(ConstLib.markdownStackEdit);
                    },
                  ),
                ],
              ),
            ],
          ),
          const Divider(height: 0),
          const SizedBox(height: 10),
          editing ? CustomField.text(
              controller: widget.controller,
              hint: 'Add more detail about product',
              minLines: 10,
              maxLines: 20,
              margin: EdgeInsets.zero
          ) : MarkdownBody(
            data: widget.controller.text,
          )
        ],
      ),
    );
  }
}
