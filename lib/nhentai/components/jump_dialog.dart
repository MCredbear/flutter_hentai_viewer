import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hentai_viewer/generated/l10n.dart';

class JumpDialog extends StatefulWidget {
  const JumpDialog({
    super.key,
    required this.lastPageIndex,
    required this.currentPageIndex,
    required this.jumpTo,
  });

  final int lastPageIndex;
  final int currentPageIndex;
  final void Function(int) jumpTo;

  @override
  State<JumpDialog> createState() => _JumpDialogState();
}

class _JumpDialogState extends State<JumpDialog> {
  late int selectedPageIndex = widget.currentPageIndex;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(L10n.of(context).jumpTo),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IntrinsicWidth(
                child: TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  controller:
                      TextEditingController(text: selectedPageIndex.toString()),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    TextInputFormatter.withFunction((oldValue, newValue) {
                      if (newValue.text.isEmpty) {
                        return newValue;
                      }
                      final intValue = int.tryParse(newValue.text);
                      if (intValue == null ||
                          intValue < 1 ||
                          intValue > widget.lastPageIndex) {
                        return oldValue;
                      }
                      return newValue;
                    }),
                  ],
                  onChanged: (value) => setState(() {
                    selectedPageIndex = int.tryParse(value) ?? 1;
                  }),
                ),
              ),
              Text(' / ${widget.lastPageIndex}'),
            ],
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () => setState(() {
                        if (selectedPageIndex > 1) {
                          selectedPageIndex = selectedPageIndex - 1;
                        }
                      }),
                  icon: const Icon(Icons.keyboard_arrow_left)),
              Slider(
                  min: 1,
                  max: widget.lastPageIndex.toDouble(),
                  value: selectedPageIndex.toDouble(),
                  onChanged: (value) => setState(() {
                        selectedPageIndex = value.toInt();
                      })),
              IconButton(
                  onPressed: () => setState(() {
                        if (selectedPageIndex < widget.lastPageIndex) {
                          selectedPageIndex = selectedPageIndex + 1;
                        }
                      }),
                  icon: const Icon(Icons.keyboard_arrow_right)),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(L10n.of(context).cancel)),
        TextButton(
            onPressed: () {
              widget.jumpTo(selectedPageIndex);
              Navigator.pop(context);
            },
            child: Text(L10n.of(context).jump)),
      ],
    );
  }
}
