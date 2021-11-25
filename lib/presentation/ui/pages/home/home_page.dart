import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../presentation.dart';

class HomePage extends StatelessWidget {
  const HomePage(this._homeCubit, {Key? key}) : super(key: key);

  final HomeCubit _homeCubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (_) => _homeCubit..loadProducts(),
      child: Scaffold(
        appBar: const HomePageAppBar(),
        body: BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
          if (state.presentationError.errorOcurred) {
            return RetryErrorMessage(
                errorMessage: state.presentationError.message);
          }

          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Banner(),
              CategoryList(),
              ProductList(),
            ],
          );
        }),
      ),
    );
  }
}

class Banner extends StatelessWidget {
  const Banner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 30,
      child: AspectRatio(
        aspectRatio: 2.3,
        child: Image.network(
          'https://imageswscdn.plataformawebstore.com.br//files/25487/banner-banner-iphone-12-mobile-2-13720212223_283.png',
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}

class CategoryList extends StatelessWidget {
  const CategoryList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Flexible(
      flex: 15,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        padding: EdgeInsets.only(
          left: width / 8,
          right: width / 8,
          top: width / 16,
        ),
        itemCount: 10,
        separatorBuilder: (context, index) {
          return SizedBox(
            width: width / 8,
          );
        },
        itemBuilder: (context, index) {
          return index == 0
              ? Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 8),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: primary,
                          width: 1.0, // Underline thickness
                        ),
                      ),
                    ),
                    child: const Text(
                      'Categoria',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primary,
                      ),
                    ),
                  ),
                )
              : const Text(
                  'Categoria',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF868686),
                  ),
                );
        },
      ),
    );
  }
}
