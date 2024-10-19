class SliderObject {
  String title;
  String subTitle;
  String image;

  SliderObject({required this.title, required this.subTitle, required this.image});
}

class Customer {
  String id;
  String name;
  int numOfNotifications;

  Customer({required this.id, required this.name, required this.numOfNotifications});
}

class Contacts {
  String phone;
  String link;
  String email;

  Contacts({required this.phone, required this.link, required this.email});
}

class Authetication {
  Customer? customer;
  Contacts? contacts;

  Authetication({this.customer, this.contacts});
}

class DeviceInfo {
  String name;
  String identifier;
  String version;

  DeviceInfo({required this.name, required this.identifier, required this.version});
}

class PersonalFinance {
  int netWorth;
  int totalDebt;
  int totalAssets;

  PersonalFinance({required this.netWorth, required this.totalDebt, required this.totalAssets});
}

class Account {
  int id;
  String type;
  String accountNumber;
  int balance;

  Account({required this.id, required this.type, required this.accountNumber, required this.balance});
}

class RecentTransaction {
  int id;
  String description;
  int amount;

  RecentTransaction({required this.id, required this.description, required this.amount});
}

class HomeData {
  PersonalFinance personalFinance;
  List<Account> accounts;
  List<RecentTransaction> recentTransaction;

  HomeData({required this.personalFinance, required this.accounts, required this.recentTransaction});
}

class HomeObject {
  HomeData data;

  HomeObject({required this.data});
}
