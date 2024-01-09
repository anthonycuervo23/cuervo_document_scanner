part of 'combo_offer_cubit.dart';

sealed class ComboOfferState extends Equatable {
  const ComboOfferState();

  @override
  List<Object?> get props => [];
}

class ComboOfferInitialState extends ComboOfferState {
  @override
  List<Object> get props => [];
}

class ComboOfferLoadingState extends ComboOfferState {
  @override
  List<Object> get props => [];
}

class ComboOfferLoadedState extends ComboOfferState {
  final double? random;
  final ComboProductEntity comboProductEntity;
  final List<ComboProductModel> comboProductList;

  const ComboOfferLoadedState({
    this.random,
    required this.comboProductEntity,
    required this.comboProductList,
  });

  ComboOfferLoadedState copyWith({
    double? random,
    ComboProductEntity? comboProductEntity,
    List<ComboProductModel>? comboProductList,
  }) {
    return ComboOfferLoadedState(
      random: random ?? this.random,
      comboProductEntity: comboProductEntity ?? this.comboProductEntity,
      comboProductList: comboProductList ?? this.comboProductList,
    );
  }

  @override
  List<Object?> get props => [comboProductEntity, random, comboProductList];
}

class ComboOfferErrorState extends ComboOfferState {
  final String errorMessage;
  final AppErrorType appErrorType;

  const ComboOfferErrorState({required this.errorMessage, required this.appErrorType});

  @override
  List<Object> get props => [errorMessage, appErrorType];
}
