import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../presentation.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem(
      {Key? key, required this.categoryViewModel, required this.isSelected})
      : super(key: key);

  final CategoryViewModel categoryViewModel;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    if (isSelected) {
      return SelectedCategoryItem(name: categoryViewModel.name);
    }

    return GestureDetector(
      onTap: () => context.read<HomeCubit>().selectCategory(categoryViewModel),
      child: Text(
        categoryViewModel.name,
        style: const TextStyle(
          fontSize: subTitleFontSize,
          fontWeight: FontWeight.w600,
          color: subTitleFontColor,
        ),
      ),
    );
  }
}

class SelectedCategoryItem extends StatelessWidget {
  const SelectedCategoryItem({
    Key? key,
    required this.name,
  }) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        padding: const EdgeInsets.only(bottom: spacing8),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: primary,
              width: spacing1, // Underline thickness
            ),
          ),
        ),
        child: Text(
          name,
          style: const TextStyle(
            fontSize: subTitleFontSize,
            fontWeight: FontWeight.bold,
            color: primary,
          ),
        ),
      ),
    );
  }
}
