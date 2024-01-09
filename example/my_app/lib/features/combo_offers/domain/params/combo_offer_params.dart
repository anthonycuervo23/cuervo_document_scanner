import 'package:equatable/equatable.dart';

class ComboOfferParams extends Equatable {
  final int page;

  const ComboOfferParams({
    required this.page,
  });

  @override
  List<Object> get props => [page];
}
