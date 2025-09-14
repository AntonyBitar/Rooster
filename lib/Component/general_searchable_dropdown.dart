import 'package:flutter/material.dart';
import 'package:searchable_paginated_dropdown/searchable_paginated_dropdown.dart';

/// A reusable paginated searchable dropdown widget.
///
/// [T] is the type of the dropdown value (e.g. int for country IDs).
class PaginatedSearchableDropdown<T> extends StatelessWidget {
  final double? width;
  final bool isDialogExpanded;
  final Future<List<SearchableDropdownMenuItem<T>>> Function(int page, String? searchKey) onPaginatedRequest;
  final ValueChanged<T?> onChanged;
  final int requestItemCount;
  final Widget hintText;
  final EdgeInsetsGeometry? margin;

  const PaginatedSearchableDropdown({
    Key? key,
    this.width,
    this.isDialogExpanded = false,
    required this.onPaginatedRequest,
    required this.onChanged,
    required this.requestItemCount,
    required this.hintText,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SearchableDropdown<T>.paginated(
      width: width,
      isDialogExpanded: isDialogExpanded,
      paginatedRequest: (int page, String? searchKey) async {
        // Delegate the loading logic to the provided callback
        return await onPaginatedRequest(page, searchKey);
      },
      onChanged: onChanged,
      requestItemCount: requestItemCount,
      hintText: hintText,
      margin: margin,
    );
  }
}
