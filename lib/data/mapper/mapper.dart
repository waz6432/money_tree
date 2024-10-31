// ignore_for_file: constant_identifier_names

// to convert the response into a non nullable object (model)

import 'package:financial_ledger/app/extensions.dart';
import 'package:financial_ledger/data/responses/responses.dart';
import 'package:financial_ledger/domain/model/model.dart';

const EMPTY = "";
const ZERO = 0;
const EMPTY_MAP = {};
const EMPTY_LIST = [];

extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(
      id: this?.id?.orEmpty() ?? EMPTY,
      name: this?.name?.orEmpty() ?? EMPTY,
      numOfNotifications: this?.numOfNotifications?.orZero() ?? ZERO,
    );
  }
}

extension ContactsResponseMapper on ContactsResponse? {
  Contacts toDomain() {
    return Contacts(
      email: this?.email?.orEmpty() ?? EMPTY,
      link: this?.link?.orEmpty() ?? EMPTY,
      phone: this?.phone?.orEmpty() ?? EMPTY,
    );
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authetication toDomain() {
    return Authetication(
      contacts: this?.contacts?.toDomain(),
      customer: this?.customer?.toDomain(),
    );
  }
}

extension ForgotPasswordResponseMapper on ForgotPasswordResponse? {
  String toDomain() {
    return this?.support?.orEmpty() ?? EMPTY;
  }
}

extension PersonalFinanceResponseMapper on PersonalFinanceResponse? {
  PersonalFinance toDomain() {
    return PersonalFinance(
      netWorth: this?.netWorth?.orZero() ?? ZERO,
      totalDebt: this?.totalDebt?.orZero() ?? ZERO,
      totalAssets: this?.totalAssets?.orZero() ?? ZERO,
    );
  }
}

extension AccountsResponseMapper on AccountsResponse? {
  Account toDomain() {
    return Account(
      id: this?.id.orZero() ?? ZERO,
      type: this?.type?.orEmpty() ?? EMPTY,
      accountNumber: this?.accountNumber?.orEmpty() ?? EMPTY,
      balance: this?.balance?.orZero() ?? ZERO,
    );
  }
}

extension RecentTransactionsResponseMapper on RecentTransactionsResponse? {
  RecentTransaction toDomain() {
    return RecentTransaction(
      id: this?.id?.orZero() ?? ZERO,
      description: this?.description?.orEmpty() ?? EMPTY,
      amount: this?.amount?.orZero() ?? ZERO,
    );
  }
}

extension HomeResponseMapper on HomeResponse? {
  HomeObject toDomain() {
    PersonalFinance mappedPersonalFinance = (this?.data?.personalFinance?.toDomain() ??
        PersonalFinance(
            netWorth: this?.data?.personalFinance?.netWorth.orZero() ?? ZERO,
            totalDebt: this?.data?.personalFinance?.totalDebt.orZero() ?? ZERO,
            totalAssets: this?.data?.personalFinance?.totalAssets.orZero() ?? ZERO));

    List<Account> mappedAccounts = (this?.data?.accounts?.map((account) => account.toDomain()) ?? const Iterable.empty()).cast<Account>().toList();

    List<RecentTransaction> mappedRecentTransaction =
        (this?.data?.recentTransactions?.map((recentTransaction) => recentTransaction.toDomain()) ?? const Iterable.empty())
            .cast<RecentTransaction>()
            .toList();

    var data = HomeData(
      personalFinance: mappedPersonalFinance,
      accounts: mappedAccounts,
      recentTransaction: mappedRecentTransaction,
    );

    return HomeObject(data: data);
  }
}

extension NesTransactionResponseMapper on NewTransactionResponse? {
  NewTransaction toDomain() {
    return NewTransaction(
      id: this?.id?.orZero() ?? ZERO,
      amount: this?.amount?.orZero() ?? ZERO,
      note: this?.note.orEmpty() ?? EMPTY,
      category: this?.category?.orEmpty() ?? EMPTY,
      date: this?.date.orEmpty() ?? EMPTY,
    );
  }
}

extension TotalSpendingResponseMapper on TotalSpendingResponse? {
  TotalSpending toDomain() {
    return TotalSpending(
      amount: this?.amount?.orZero() ?? ZERO,
      spendingId: this?.spendingId?.orZero() ?? ZERO,
      spendingDate: this?.spendingDate?.orEmpty() ?? EMPTY,
    );
  }
}

extension SpendingDataResponseMapper on SpendingDataResponse? {
  SpendingData toDomain() {
    return SpendingData(
      spendingId: this?.spendingId?.orZero() ?? ZERO,
      amount: this?.amount?.orZero() ?? ZERO,
      spendingDate: this?.spendingDate?.orEmpty() ?? EMPTY,
    );
  }
}

extension CategoriesResponseMapper on CategoriesResponse? {
  Categories toDomain() {
    return Categories(
      categoryId: this?.categoryId?.orZero() ?? ZERO,
      categoryName: this?.categoryName?.orEmpty() ?? EMPTY,
      spendingData: this?.spendingData?.map((spending) => spending.toDomain()).toList() ?? EMPTY_LIST.cast<SpendingData>(),
    );
  }
}

extension TimeDataResponseMapper on TimeDataResponse? {
  TimeData toDomain() {
    return TimeData(
      netWorthId: this?.netWorthId?.orZero() ?? ZERO,
      amount: this?.amount?.orZero() ?? ZERO,
      date: this?.date?.orEmpty() ?? EMPTY,
    );
  }
}

extension NetWorthResponseMapper on NetWorthResponse? {
  NetWorth toDomain() {
    return NetWorth(
      timeData: this?.timeData?.map((time) => time.toDomain()).toList() ?? EMPTY_LIST.cast<TimeData>(),
    );
  }
}

extension ReportResponseMapper on ReportResponse? {
  ReportObject toDomain() {
    List<TotalSpending> mappedTotalSpending = (this?.data?.totalSpendings?.map(
                  (totalSpending) => totalSpending.toDomain(),
                ) ??
            const Iterable.empty())
        .cast<TotalSpending>()
        .toList();

    List<Categories> mappedCategories = (this?.data?.categories?.map(
                  (category) => category.toDomain(),
                ) ??
            const Iterable.empty())
        .toList();

    NetWorth mappedNetWorth = (this?.data?.netWorth?.toDomain() ??
        NetWorth(
          timeData: (this?.data?.netWorth?.timeData.orEmptyList() ?? EMPTY_LIST).cast<TimeData>(),
        ));

    var data = ReportData(
      totalSpendings: mappedTotalSpending,
      categories: mappedCategories,
      netWorth: mappedNetWorth,
    );

    return ReportObject(data: data);
  }
}
