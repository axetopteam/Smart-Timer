import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';

class ObservableListConverter implements JsonConverter<ObservableList, List> {
  const ObservableListConverter();

  @override
  ObservableList fromJson(List json) => ObservableList.of(json);

  @override
  List toJson(ObservableList object) => object.toList();
}
