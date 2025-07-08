part of 'productblocs_bloc.dart';

@immutable
sealed class ProductBlocsState {}

final class ProductBlocsInitial extends ProductBlocsState {}

final class ProductLoading extends ProductBlocsState {}

final class ProductLoaded extends ProductBlocsState {
  final List<ProductResponse> products;
  ProductLoaded(this.products);
}

final class ProductError extends ProductBlocsState {
  final String message;
  ProductError(this.message);
}
