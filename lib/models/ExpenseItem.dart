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
  final String? _expenseimagekey;
  final ExpenseCategory? _expensecategory;
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
  
  String? get expenseimagekey {
    return _expenseimagekey;
  }
  
  ExpenseCategory? get expensecategory {
    return _expensecategory;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const ExpenseItem._internal({required this.id, required expensename, required expensevalue, expenseimagekey, expensecategory, createdAt, updatedAt}): _expensename = expensename, _expensevalue = expensevalue, _expenseimagekey = expenseimagekey, _expensecategory = expensecategory, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory ExpenseItem({String? id, required String expensename, required double expensevalue, String? expenseimagekey, ExpenseCategory? expensecategory}) {
    return ExpenseItem._internal(
      id: id == null ? UUID.getUUID() : id,
      expensename: expensename,
      expensevalue: expensevalue,
      expenseimagekey: expenseimagekey,
      expensecategory: expensecategory);
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
      _expenseimagekey == other._expenseimagekey &&
      _expensecategory == other._expensecategory;
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
    buffer.write("expenseimagekey=" + "$_expenseimagekey" + ", ");
    buffer.write("expensecategory=" + (_expensecategory != null ? _expensecategory!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  ExpenseItem copyWith({String? id, String? expensename, double? expensevalue, String? expenseimagekey, ExpenseCategory? expensecategory}) {
    return ExpenseItem._internal(
      id: id ?? this.id,
      expensename: expensename ?? this.expensename,
      expensevalue: expensevalue ?? this.expensevalue,
      expenseimagekey: expenseimagekey ?? this.expenseimagekey,
      expensecategory: expensecategory ?? this.expensecategory);
  }
  
  ExpenseItem.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _expensename = json['expensename'],
      _expensevalue = (json['expensevalue'] as num?)?.toDouble(),
      _expenseimagekey = json['expenseimagekey'],
      _expensecategory = json['expensecategory']?['serializedData'] != null
        ? ExpenseCategory.fromJson(new Map<String, dynamic>.from(json['expensecategory']['serializedData']))
        : null,
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'expensename': _expensename, 'expensevalue': _expensevalue, 'expenseimagekey': _expenseimagekey, 'expensecategory': _expensecategory?.toJson(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "expenseItem.id");
  static final QueryField EXPENSENAME = QueryField(fieldName: "expensename");
  static final QueryField EXPENSEVALUE = QueryField(fieldName: "expensevalue");
  static final QueryField EXPENSEIMAGEKEY = QueryField(fieldName: "expenseimagekey");
  static final QueryField EXPENSECATEGORY = QueryField(
    fieldName: "expensecategory",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (ExpenseCategory).toString()));
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
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: ExpenseItem.EXPENSEIMAGEKEY,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: ExpenseItem.EXPENSECATEGORY,
      isRequired: false,
      targetName: "expenseCategoryExpensesId",
      ofModelName: (ExpenseCategory).toString()
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

class _ExpenseItemModelType extends ModelType<ExpenseItem> {
  const _ExpenseItemModelType();
  
  @override
  ExpenseItem fromJson(Map<String, dynamic> jsonData) {
    return ExpenseItem.fromJson(jsonData);
  }
}