import 'package:equatable/equatable.dart';
import 'package:game_hub/crud/crud.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'form.g.dart';

class CrudValue extends Equatable {
  const CrudValue({
    required this.valid,
    required this.value,
  });

  final bool valid;
  final dynamic value;

  CrudValue copyWith({
    bool? valid,
    dynamic value,
  }) {
    return CrudValue(
      valid: valid ?? this.valid,
      value: value ?? this.value,
    );
  }

  @override
  List<Object?> get props => [valid, value];
}

class CrudFormState extends Equatable {
  const CrudFormState({
    required this.id,
    required this.fields,
    required this.values,
  });

  final String? id;
  final List<CrudField> fields;
  final Map<String, CrudValue> values;

  CrudFormState copyWith({
    String? id,
    Map<String, CrudValue>? values,
  }) {
    return CrudFormState(
      id: id ?? this.id,
      fields: fields,
      values: values ?? this.values,
    );
  }

  @override
  List<Object?> get props => [fields, values];
}

@riverpod
class CrudForm extends _$CrudForm {
  @override
  Future<CrudFormState> build({
    required CrudRepositoryAdapter adapter,
    required CrudContext crudContext,
    required String? id,
  }) async {
    final fields = adapter.fields;
    if (id != null) {
      final data = await adapter.fetch(id);
      return CrudFormState(
        id: id,
        fields: fields,
        values: data,
      );
    } else {
      return CrudFormState(
        id: id,
        fields: fields,
        values: const {},
      );
    }
  }

  void updateValue({
    required String field,
    required dynamic value,
  }) {
    final stateValue = state.value;

    if (stateValue == null) {
      return;
    }

    final values = stateValue.values;

    final currentValue = values[field];

    final newValue =
        (currentValue ?? CrudValue(valid: false, value: value)).copyWith(
      value: value,
    );

    final newValues = {
      ...values,
      field: newValue,
    };

    state = AsyncValue.data(
      stateValue.copyWith(
        values: newValues,
      ),
    );
  }

  Future<void> save() async {
    final value = state.value;
    if (value == null) {
      return;
    }

    // TODO(erickzanardo): check for errors

    final mappedValues =
        value.values.map((key, value) => MapEntry(key, value.value));

    await adapter.create(
      adapter.fromValues(value.id, mappedValues),
      context: crudContext,
    );
  }
}
