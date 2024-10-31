// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse _$BaseResponseFromJson(Map<String, dynamic> json) => BaseResponse()
  ..status = (json['status'] as num?)?.toInt()
  ..message = json['message'] as String?;

Map<String, dynamic> _$BaseResponseToJson(BaseResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };

CustomerResponse _$CustomerResponseFromJson(Map<String, dynamic> json) =>
    CustomerResponse(
      id: json['id'] as String?,
      name: json['name'] as String?,
      numOfNotifications: (json['numOfNotifications'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CustomerResponseToJson(CustomerResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'numOfNotifications': instance.numOfNotifications,
    };

ContactsResponse _$ContactsResponseFromJson(Map<String, dynamic> json) =>
    ContactsResponse(
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      link: json['link'] as String?,
    );

Map<String, dynamic> _$ContactsResponseToJson(ContactsResponse instance) =>
    <String, dynamic>{
      'phone': instance.phone,
      'link': instance.link,
      'email': instance.email,
    };

AuthenticationResponse _$AuthenticationResponseFromJson(
        Map<String, dynamic> json) =>
    AuthenticationResponse(
      customer: json['customer'] == null
          ? null
          : CustomerResponse.fromJson(json['customer'] as Map<String, dynamic>),
      contacts: json['contacts'] == null
          ? null
          : ContactsResponse.fromJson(json['contacts'] as Map<String, dynamic>),
    )
      ..status = (json['status'] as num?)?.toInt()
      ..message = json['message'] as String?;

Map<String, dynamic> _$AuthenticationResponseToJson(
        AuthenticationResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'customer': instance.customer,
      'contacts': instance.contacts,
    };

ForgotPasswordResponse _$ForgotPasswordResponseFromJson(
        Map<String, dynamic> json) =>
    ForgotPasswordResponse(
      support: json['support'] as String?,
    )
      ..status = (json['status'] as num?)?.toInt()
      ..message = json['message'] as String?;

Map<String, dynamic> _$ForgotPasswordResponseToJson(
        ForgotPasswordResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'support': instance.support,
    };

PersonalFinanceResponse _$PersonalFinanceResponseFromJson(
        Map<String, dynamic> json) =>
    PersonalFinanceResponse(
      netWorth: (json['netWorth'] as num?)?.toInt(),
      totalDebt: (json['totalDebt'] as num?)?.toInt(),
      totalAssets: (json['totalAssets'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PersonalFinanceResponseToJson(
        PersonalFinanceResponse instance) =>
    <String, dynamic>{
      'netWorth': instance.netWorth,
      'totalDebt': instance.totalDebt,
      'totalAssets': instance.totalAssets,
    };

AccountsResponse _$AccountsResponseFromJson(Map<String, dynamic> json) =>
    AccountsResponse(
      id: (json['id'] as num?)?.toInt(),
      type: json['type'] as String?,
      accountNumber: json['accountNumber'] as String?,
      balance: (json['balance'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AccountsResponseToJson(AccountsResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'accountNumber': instance.accountNumber,
      'balance': instance.balance,
    };

RecentTransactionsResponse _$RecentTransactionsResponseFromJson(
        Map<String, dynamic> json) =>
    RecentTransactionsResponse(
      id: (json['id'] as num?)?.toInt(),
      description: json['description'] as String?,
      amount: (json['amount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RecentTransactionsResponseToJson(
        RecentTransactionsResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'amount': instance.amount,
    };

HomeDataResponse _$HomeDataResponseFromJson(Map<String, dynamic> json) =>
    HomeDataResponse(
      personalFinance: json['personalFinance'] == null
          ? null
          : PersonalFinanceResponse.fromJson(
              json['personalFinance'] as Map<String, dynamic>),
      accounts: (json['accounts'] as List<dynamic>?)
          ?.map((e) => AccountsResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      recentTransactions: (json['recentTransactions'] as List<dynamic>?)
          ?.map((e) =>
              RecentTransactionsResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HomeDataResponseToJson(HomeDataResponse instance) =>
    <String, dynamic>{
      'personalFinance': instance.personalFinance,
      'accounts': instance.accounts,
      'recentTransactions': instance.recentTransactions,
    };

HomeResponse _$HomeResponseFromJson(Map<String, dynamic> json) => HomeResponse(
      data: json['data'] == null
          ? null
          : HomeDataResponse.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..status = (json['status'] as num?)?.toInt()
      ..message = json['message'] as String?;

Map<String, dynamic> _$HomeResponseToJson(HomeResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

NewTransactionResponse _$NewTransactionResponseFromJson(
        Map<String, dynamic> json) =>
    NewTransactionResponse(
      id: (json['id'] as num?)?.toInt(),
      amount: (json['amount'] as num?)?.toInt(),
      note: json['note'] as String?,
      category: json['category'] as String?,
      date: json['date'] as String?,
    )
      ..status = (json['status'] as num?)?.toInt()
      ..message = json['message'] as String?;

Map<String, dynamic> _$NewTransactionResponseToJson(
        NewTransactionResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'id': instance.id,
      'amount': instance.amount,
      'note': instance.note,
      'category': instance.category,
      'date': instance.date,
    };

TotalSpendingResponse _$TotalSpendingResponseFromJson(
        Map<String, dynamic> json) =>
    TotalSpendingResponse(
      spendingId: (json['spendingId'] as num?)?.toInt(),
      spendingDate: json['spendingDate'] as String?,
      amount: (json['amount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TotalSpendingResponseToJson(
        TotalSpendingResponse instance) =>
    <String, dynamic>{
      'spendingId': instance.spendingId,
      'spendingDate': instance.spendingDate,
      'amount': instance.amount,
    };

SpendingDataResponse _$SpendingDataResponseFromJson(
        Map<String, dynamic> json) =>
    SpendingDataResponse(
      spendingId: (json['spendingId'] as num?)?.toInt(),
      spendingDate: json['spendingDate'] as String?,
      amount: (json['amount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SpendingDataResponseToJson(
        SpendingDataResponse instance) =>
    <String, dynamic>{
      'spendingId': instance.spendingId,
      'spendingDate': instance.spendingDate,
      'amount': instance.amount,
    };

CategoriesResponse _$CategoriesResponseFromJson(Map<String, dynamic> json) =>
    CategoriesResponse(
      categoryId: (json['categoryId'] as num?)?.toInt(),
      categoryName: json['categoryName'] as String?,
      spendingData: (json['spendingData'] as List<dynamic>?)
          ?.map((e) => SpendingDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoriesResponseToJson(CategoriesResponse instance) =>
    <String, dynamic>{
      'categoryId': instance.categoryId,
      'categoryName': instance.categoryName,
      'spendingData': instance.spendingData,
    };

TimeDataResponse _$TimeDataResponseFromJson(Map<String, dynamic> json) =>
    TimeDataResponse(
      netWorthId: (json['netWorthId'] as num?)?.toInt(),
      date: json['date'] as String?,
      amount: (json['amount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TimeDataResponseToJson(TimeDataResponse instance) =>
    <String, dynamic>{
      'netWorthId': instance.netWorthId,
      'date': instance.date,
      'amount': instance.amount,
    };

NetWorthResponse _$NetWorthResponseFromJson(Map<String, dynamic> json) =>
    NetWorthResponse(
      timeData: (json['timeData'] as List<dynamic>?)
          ?.map((e) => TimeDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NetWorthResponseToJson(NetWorthResponse instance) =>
    <String, dynamic>{
      'timeData': instance.timeData,
    };

ReportDataResponse _$ReportDataResponseFromJson(Map<String, dynamic> json) =>
    ReportDataResponse(
      totalSpendings: (json['totalSpending'] as List<dynamic>?)
          ?.map(
              (e) => TotalSpendingResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => CategoriesResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      netWorth: json['netWorth'] == null
          ? null
          : NetWorthResponse.fromJson(json['netWorth'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReportDataResponseToJson(ReportDataResponse instance) =>
    <String, dynamic>{
      'totalSpending': instance.totalSpendings,
      'categories': instance.categories,
      'netWorth': instance.netWorth,
    };

ReportResponse _$ReportResponseFromJson(Map<String, dynamic> json) =>
    ReportResponse(
      data: json['data'] == null
          ? null
          : ReportDataResponse.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..status = (json['status'] as num?)?.toInt()
      ..message = json['message'] as String?;

Map<String, dynamic> _$ReportResponseToJson(ReportResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
