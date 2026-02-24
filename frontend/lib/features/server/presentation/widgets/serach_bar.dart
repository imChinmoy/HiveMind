import 'package:flutter/material.dart';

class SliverSearchBar extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final String hintText;
  final EdgeInsets padding;

  const SliverSearchBar({
    super.key,
    required this.controller,
    this.onChanged,
    this.onClear,
    this.hintText = "Search...",
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  });

  @override
  State<SliverSearchBar> createState() => _SliverSearchBarState();
}

class _SliverSearchBarState extends State<SliverSearchBar> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_listener);
  }

  void _listener() {
    setState(() {});
  }

  @override
  void dispose() {
    widget.controller.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: widget.padding,
        child: Container(
          height: 56,
          decoration: BoxDecoration(
            color: const Color.fromARGB(34, 245, 245, 245),
            borderRadius: BorderRadius.circular(24),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              const Icon(Icons.search, color: Colors.grey),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  onChanged: widget.onChanged,
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    border: InputBorder.none,
                    isDense: true,
                    fillColor: Colors.transparent
                  ),
                ),
              ),
              if (widget.controller.text.isNotEmpty)
                GestureDetector(
                  onTap: () {
                    widget.controller.clear();
                    widget.onClear?.call();
                  },
                  child: const Icon(Icons.close,
                      size: 18, color: Colors.grey),
                ),
            ],
          ),
        ),
      ),
    );
  }
}