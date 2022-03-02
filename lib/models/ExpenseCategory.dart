/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, file_names, unnecessary_new, prefer_if_null_operators, prefer_const_constructors, slash_for_doc_comments, annotate_overrides, non_constant_identifier_names, unnecessary_string_interpolations, prefer_adjacent_string_concatenation, unnecessary_const, dead_code

import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the ExpenseCategory type in your schema. */
@immutable
class ExpenseCategory extends Model {
  static const classType = const _ExpenseCategoryModelType();
  final String id;
  final String? _categoryname;
  final List<ExpenseItem>? _Expenses;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get categoryname {
    try {
      return _categoryname!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  List<ExpenseItem>? get Expenses {
    return _Expenses;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const ExpenseCategory._internal({required this.id, required categoryname, Expenses, createdAt, updatedAt}): _categoryname = categoryname, _Expenses = Expenses, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory ExpenseCategory({String? id, required String categoryname, List<ExpenseItem>? Expenses}) {
    return ExpenseCategory._internal(
      id: id == null ? UUID.getUUID() : id,
      categoryname: categoryname,
      Expenses: Expenses != null ? List<ExpenseItem>.unmodifiable(Expenses) : Expenses);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ExpenseCategory &&
      id == other.id &&
      _categoryname == other._categoryname &&
      DeepCollectionEquality().equals(_Expenses, other._Expenses);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("ExpenseCategory {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("categoryname=" + "$_categoryname" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  ExpenseCategory copyWith({String? id, String? categoryname, List<ExpenseItem>? Expenses}) {
    return ExpenseCategory._internal(
      id: id ?? this.id,
      categoryname: categoryname ?? this.categoryname,
      Expenses: Expenses ?? this.Expenses);
  }
  
  ExpenseCategory.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _categoryname = json['categoryname'],
      _Expenses = json['Expenses'] is List
        ? (json['Expenses'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => ExpenseItem.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'categoryname': _categoryname, 'Expenses': _Expenses?.map((ExpenseItem? e) => e?.toJson()).toList(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "expenseCategory.id");
  static final QueryField CATEGORYNAME = QueryField(fieldName: "categoryname");
  static final QueryField EXPENSES = QueryField(
    fieldName: "Expenses",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (ExpenseItem).toString()));
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "ExpenseCategory";
    modelSchemaDefinition.pluralName = "ExpenseCategories";
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: ExpenseCategory.CATEGORYNAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: ExpenseCategory.EXPENSES,
      isRequired: false,
      ofModelName: (ExpenseItem).toString(),
      associatedKey: ExpenseItem.EXPENSECATEGORY
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _ExpenseCategoryModelType extends ModelType<ExpenseCategory> {
  const _ExpenseCategoryModelType();
  
  @override
  ExpenseCategory fromJson(Map<String, dynamic> jsonData) {
    return ExpenseCategory.fromJson(jsonData);
  }
}