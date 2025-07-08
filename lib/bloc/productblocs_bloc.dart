import 'package:bloc/bloc.dart';
import "package:meta/meta.dart";
import '../model/prodect_model_response.dart';
import '../repositories/post_repository.dart';
part 'productblocs_event.dart';
part 'productblocs_state.dart';

class ProductBlocsBloc extends Bloc<ProductBlocsEvent, ProductBlocsState> {
  final PostRepository repository;
  ProductBlocsBloc(this.repository) : super(ProductBlocsInitial()) {
    on<ProductBlocsEvent>((event, emit)  async {
      emit(ProductLoading());
      try {
       final products = await repository.fetchUsers();
        emit(ProductLoaded(products));
      } catch (e) {
        emit(ProductError("Failed to load products"));
      }
    });
  }
}
