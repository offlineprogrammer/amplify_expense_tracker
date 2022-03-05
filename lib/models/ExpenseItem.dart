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
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the ExpenseItem type in your schema. */
@immutable
class ExpenseItem extends Model {
  static const classType = const _ExpenseItemModelType();
  final String id;
  final String? _expensename;
  final double? _expensevalue;
  final ExpenseCategory? _expensecategory;
  final String? _type;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get expensename {
    try {
      return _expensename!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  double get expensevalue {
    try {
      return _expensevalue!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  ExpenseCategory? get expensecategory {
    return _expensecategory;
  }
  
  String get type {
    try {
      return _type!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  TemporalDateTime get createdAt {
    try {
      return _createdAt!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const ExpenseItem._internal({required this.id, required expensename, required expensevalue, expensecategory, required type, required createdAt, updatedAt}): _expensename = expensename, _expensevalue = expensevalue, _expensecategory = expensecategory, _type = type, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory ExpenseItem({String? id, required String expensename, required double expensevalue, ExpenseCategory? expensecategory, required String type, required TemporalDateTime createdAt}) {
    return ExpenseItem._internal(
      id: id == null ? UUID.getUUID() : id,
      expensename: expensename,
      expensevalue: expensevalue,
      expensecategory: expensecategory,
      type: type,
      createdAt: createdAt);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ExpenseItem &&
      id == other.id &&
      _expensename == other._expensename &&
      _expensevalue == other._expensevalue &&
      _expensecategory == other._expensecategory &&
      _type == other._type &&
      _createdAt == other._createdAt;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("ExpenseItem {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("expensename=" + "$_expensename" + ", ");
    buffer.write("expensevalue=" + (_expensevalue != null ? _expensevalue!.toString() : "null") + ", ");
    buffer.write("expensecategory=" + (_expensecategory != null ? _expensecategory!.toString() : "null") + ", ");
    buffer.write("type=" + "$_type" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  ExpenseItem copyWith({String? id, String? expensename, double? expensevalue, ExpenseCategory? expensecategory, String? type, TemporalDateTime? createdAt}) {
    return ExpenseItem._internal(
      id: id ?? this.id,
      expensename: expensename ?? this.expensename,
      expensevalue: expensevalue ?? this.expensevalue,
      expensecategory: expensecategory ?? this.expensecategory,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt);
  }
  
  ExpenseItem.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _expensename = json['expensename'],
      _expensevalue = (json['expensevalue'] as num?)?.toDouble(),
      _expensecategory = json['expensecategory']?['serializedData'] != null
        ? ExpenseCategory.fromJson(new Map<String, dynamic>.from(json['expensecategory']['serializedData']))
        : null,
      _type = json['type'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'expensename': _expensename, 'expensevalue': _expensevalue, 'expensecategory': _expensecategory?.toJson(), 'type': _type, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "expenseItem.id");
  static final QueryField EXPENSENAME = QueryField(fieldName: "expensename");
  static final QueryField EXPENSEVALUE = QueryField(fieldName: "expensevalue");
  static final QueryField EXPENSECATEGORY = QueryField(
    fieldName: "expensecategory",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (ExpenseCategory).toString()));
  static final QueryField TYPE = QueryField(fieldName: "type");
  static final QueryField CREATEDAT = QueryField(fieldName: "createdAt");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "ExpenseItem";
    modelSchemaDefinition.pluralName = "ExpenseItems";
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: ExpenseItem.EXPENSENAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: ExpenseItem.EXPENSEVALUE,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: ExpenseItem.EXPENSECATEGORY,
      isRequired: false,
      targetName: "expenseCategoryExpensesId",
      ofModelName: (ExpenseCategory).toString()
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: ExpenseItem.TYPE,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: ExpenseItem.CREATEDAT,
      isRequired: true,
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

class _ExpenseItemModelType extends ModelType<ExpenseItem> {
  const _ExpenseItemModelType();
  
  @override
  ExpenseItem fromJson(Map<String, dynamic> jsonData) {
    return ExpenseItem.fromJson(jsonData);
  }
}