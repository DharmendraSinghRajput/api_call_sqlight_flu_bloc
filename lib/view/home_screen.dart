import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:api_call_sqlight_flu_bloc/repositories/post_repository.dart';
import '../bloc/productblocs_bloc.dart';
import '../row/player_items.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductBlocsBloc(PostRepository())..add(FetchProducts()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Products'),
        ),
        body: BlocBuilder<ProductBlocsBloc, ProductBlocsState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductLoaded) {
              return ListView.builder(
                itemCount: state.products.length,
                itemBuilder: (_, index) {
                  return PlayerItems(product: state.products[index]);
                },
              );
            } else {
              return const Center(child: Text("Something went wrong"));
            }
          },
        ),
      ),
    );
  }
}