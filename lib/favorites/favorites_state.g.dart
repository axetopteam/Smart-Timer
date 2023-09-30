// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FavoritesState on FavoritesStateBase, Store {
  late final _$favoritesAtom =
      Atom(name: 'FavoritesStateBase.favorites', context: context);

  @override
  List<FavoriteWorkout>? get favorites {
    _$favoritesAtom.reportRead();
    return super.favorites;
  }

  @override
  set favorites(List<FavoriteWorkout>? value) {
    _$favoritesAtom.reportWrite(value, super.favorites, () {
      super.favorites = value;
    });
  }

  late final _$errorAtom =
      Atom(name: 'FavoritesStateBase.error', context: context);

  @override
  Object? get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(Object? value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  late final _$fetchFavoritesAsyncAction =
      AsyncAction('FavoritesStateBase.fetchFavorites', context: context);

  @override
  Future<void> fetchFavorites() {
    return _$fetchFavoritesAsyncAction.run(() => super.fetchFavorites());
  }

  @override
  String toString() {
    return '''
favorites: ${favorites},
error: ${error}
    ''';
  }
}
