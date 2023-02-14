import 'package:admin/components/table/tables.dart';
import 'package:flutter/material.dart';

class DateTimeInfo extends StatelessWidget {
  final DateTime created;
  final DateTime edited;
  final DateTime published;
  const DateTimeInfo({Key? key,
    required this.created,
    required this.edited,
    required this.published,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade800)
      ),
      child: Table(
        columnWidths: const {
          0: FixedColumnWidth(100),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          Tables.rowItemDark(title: 'Created', value: created.toIso8601String()),
          Tables.rowItemDark(title: 'Published', value: published.toIso8601String()),
          Tables.rowItemDark(title: 'Last Edited', value: edited.toIso8601String()),
        ],
      ),
    );
  }
}