import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../presentation.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<HomeCubit>().state;
    final categories = state.categories;
    final width = MediaQuery.of(context).size.width;
    return Flexible(
      flex: flex15,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        padding: EdgeInsets.only(
          left: width / spacing8,
          right: width / spacing8,
          top: width / spacing16,
        ),
        itemCount: categories.length,
        separatorBuilder: (context, index) {
          return SizedBox(
            width: width / spacing8,
          );
        },
        itemBuilder: (context, index) {
          final category = categories[index];
          return CategoryItem(
              categoryViewModel: category,
              isSelected: category == state.selectedCategory);
        },
      ),
    );
  }
}
