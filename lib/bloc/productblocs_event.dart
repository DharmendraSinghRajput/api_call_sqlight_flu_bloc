part of 'productblocs_bloc.dart';

@immutable
sealed class ProductBlocsEvent {}

final class FetchProducts extends ProductBlocsEvent {}

final class RegisterUser extends ProductBlocsEvent {}


class InternetLostEvent extends ProductBlocsEvent {
}
class InternetGainedEvent extends ProductBlocsEvent{

}
