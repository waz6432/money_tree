import 'package:json_annotation/json_annotation.dart';

part 'responses.g.dart';

@JsonSerializable()
class BaseResponse {
  @JsonKey(name: "status") // json key값
  int? status;

  @JsonKey(name: "message")
  String? message;
}

@JsonSerializable()
class CustomerResponse {
  @JsonKey(name: "id") // json key값
  String? id;

  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "numOfNotifications")
  int? numOfNotifications;

  CustomerResponse({this.id, this.name, this.numOfNotifications});

  // from json
  factory CustomerResponse.fromJson(Map<String, dynamic> json) => _$CustomerResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$CustomerResponseToJson(this);
}

@JsonSerializable()
class ContactsResponse {
  @JsonKey(name: "phone") // json key값
  String? phone;

  @JsonKey(name: "link")
  String? link;

  @JsonKey(name: "email")
  String? email;

  ContactsResponse({this.phone, this.email, this.link});

  // from json
  factory ContactsResponse.fromJson(Map<String, dynamic> json) => _$ContactsResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$ContactsResponseToJson(this);
}

@JsonSerializable()
class AuthenticationResponse extends BaseResponse {
  @JsonKey(name: "customer")
  CustomerResponse? customer;

  @JsonKey(name: "contacts")
  ContactsResponse? contacts;

  AuthenticationResponse({this.customer, this.contacts});

  // from json
  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) => _$AuthenticationResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);
}

@JsonSerializable()
class ForgotPasswordResponse extends BaseResponse {
  @JsonKey(name: "support")
  String? support;

  ForgotPasswordResponse({this.support});

  // from json
  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) => _$ForgotPasswordResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$ForgotPasswordResponseToJson(this);
}

@JsonSerializable()
class PersonalFinanceResponse {
  @JsonKey(name: "netWorth")
  int? netWorth;

  @JsonKey(name: "totalDebt")
  int? totalDebt;

  @JsonKey(name: "totalAssets")
  int? totalAssets;

  PersonalFinanceResponse({this.netWorth, this.totalDebt, this.totalAssets});

  // from json
  factory PersonalFinanceResponse.fromJson(Map<String, dynamic> json) => _$PersonalFinanceResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$PersonalFinanceResponseToJson(this);
}

@JsonSerializable()
class AccountsResponse {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "type")
  String? type;

  @JsonKey(name: "accountNumber")
  String? accountNumber;

  @JsonKey(name: "balance")
  int? balance;

  AccountsResponse({this.id, this.type, this.accountNumber, this.balance});

  // from json
  factory AccountsResponse.fromJson(Map<String, dynamic> json) => _$AccountsResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$AccountsResponseToJson(this);
}

@JsonSerializable()
class RecentTransactionsResponse {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "description")
  String? description;

  @JsonKey(name: "amount")
  int? amount;

  RecentTransactionsResponse({this.id, this.description, this.amount});

  // from json
  factory RecentTransactionsResponse.fromJson(Map<String, dynamic> json) => _$RecentTransactionsResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$RecentTransactionsResponseToJson(this);
}

@JsonSerializable()
class HomeDataResponse {
  @JsonKey(name: "personalFinance")
  PersonalFinanceResponse? personalFinance;

  @JsonKey(name: "accounts")
  List<AccountsResponse>? accounts;

  @JsonKey(name: "recentTransactions")
  List<RecentTransactionsResponse>? recentTransactions;

  HomeDataResponse({this.personalFinance, this.accounts, this.recentTransactions});

  // from json
  factory HomeDataResponse.fromJson(Map<String, dynamic> json) => _$HomeDataResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$HomeDataResponseToJson(this);
}

@JsonSerializable()
class HomeResponse extends BaseResponse {
  @JsonKey(name: "data")
  HomeDataResponse? data;

  HomeResponse({this.data});

  // from json
  factory HomeResponse.fromJson(Map<String, dynamic> json) => _$HomeResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$HomeResponseToJson(this);
}

@JsonSerializable()
class NewTransactionResponse extends BaseResponse {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "amount")
  int? amount;

  @JsonKey(name: "note")
  String? note;

  @JsonKey(name: "category")
  String? category;

  @JsonKey(name: "date")
  String? date;

  NewTransactionResponse({this.id, this.amount, this.note, this.category, this.date});

  // from json
  factory NewTransactionResponse.fromJson(Map<String, dynamic> json) => _$NewTransactionResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$NewTransactionResponseToJson(this);
}

@JsonSerializable()
class TotalSpendingResponse {
  @JsonKey(name: "spendingId")
  int? spendingId;

  @JsonKey(name: "spendingDate")
  String? spendingDate;

  @JsonKey(name: "amount")
  int? amount;

  TotalSpendingResponse({this.spendingId, this.spendingDate, this.amount});

  // from json
  factory TotalSpendingResponse.fromJson(Map<String, dynamic> json) => _$TotalSpendingResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$TotalSpendingResponseToJson(this);
}

@JsonSerializable()
class SpendingDataResponse {
  @JsonKey(name: "spendingId")
  int? spendingId;

  @JsonKey(name: "spendingDate")
  String? spendingDate;

  @JsonKey(name: "amount")
  int? amount;

  SpendingDataResponse({this.spendingId, this.spendingDate, this.amount});

  // from json
  factory SpendingDataResponse.fromJson(Map<String, dynamic> json) => _$SpendingDataResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$SpendingDataResponseToJson(this);
}

@JsonSerializable()
class CategoriesResponse {
  @JsonKey(name: "categoryId")
  int? categoryId;

  @JsonKey(name: "categoryName")
  String? categoryName;

  @JsonKey(name: "spendingData")
  List<SpendingDataResponse>? spendingData;

  CategoriesResponse({this.categoryId, this.categoryName, this.spendingData});

  // from json
  factory CategoriesResponse.fromJson(Map<String, dynamic> json) => _$CategoriesResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$CategoriesResponseToJson(this);
}

@JsonSerializable()
class TimeDataResponse {
  @JsonKey(name: "netWorthId")
  int? netWorthId;

  @JsonKey(name: "date")
  String? date;

  @JsonKey(name: "amount")
  int? amount;

  TimeDataResponse({this.netWorthId, this.date, this.amount});

  // from json
  factory TimeDataResponse.fromJson(Map<String, dynamic> json) => _$TimeDataResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$TimeDataResponseToJson(this);
}

@JsonSerializable()
class NetWorthResponse {
  @JsonKey(name: "timeData")
  List<TimeDataResponse>? timeData;

  NetWorthResponse({this.timeData});

  // from json
  factory NetWorthResponse.fromJson(Map<String, dynamic> json) => _$NetWorthResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$NetWorthResponseToJson(this);
}

@JsonSerializable()
class ReportDataResponse {
  @JsonKey(name: "totalSpending")
  List<TotalSpendingResponse>? totalSpendings;

  @JsonKey(name: "categories")
  List<CategoriesResponse>? categories;

  @JsonKey(name: "netWorth")
  NetWorthResponse? netWorth;

  ReportDataResponse({this.totalSpendings, this.categories, this.netWorth});

  // from json
  factory ReportDataResponse.fromJson(Map<String, dynamic> json) => _$ReportDataResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$ReportDataResponseToJson(this);
}

@JsonSerializable()
class ReportResponse extends BaseResponse {
  @JsonKey(name: "data")
  ReportDataResponse? data;

  ReportResponse({this.data});

  // from json
  factory ReportResponse.fromJson(Map<String, dynamic> json) => _$ReportResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$ReportResponseToJson(this);
}
