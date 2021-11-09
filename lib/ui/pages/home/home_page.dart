import 'package:flutter/material.dart';

import '../../ui.dart';

class HomePage extends StatefulWidget {
  const HomePage(this._homePresenter, {Key? key}) : super(key: key);

  final HomePresenter _homePresenter;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with LoadingManager {
  @override
  void initState() {
    handleLoading(context, widget._homePresenter.isLoading);
    widget._homePresenter.loadProducts();
    super.initState();
  }

  @override
  void dispose() {
    widget._homePresenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Supplier(
      presenter: widget._homePresenter,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            R.strings.appBarHomePageTitle,
            style: screenTitle,
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
              ),
            ),
          ],
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu,
            ),
          ),
        ),
        body: const HomePageBody(),
      ),
    );
  }
}

class HomePageBody extends StatelessWidget {
  const HomePageBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomePresenter _homePresenter =
        Supplier.of<HomePresenter>(context).presenter;
    return StreamBuilder<Object>(
        stream: _homePresenter.productsStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return RetryErrorMessage(errorMessage: snapshot.error.toString());
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Banner(),
              CategoryList(),
              ProductList(),
            ],
          );
        });
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
