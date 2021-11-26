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
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
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
          },
        ),
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
