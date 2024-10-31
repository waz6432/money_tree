import 'package:financial_ledger/app/di.dart';
import 'package:financial_ledger/app/extensions.dart';
import 'package:financial_ledger/data/mapper/mapper.dart';
import 'package:financial_ledger/domain/model/model.dart';
import 'package:financial_ledger/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:financial_ledger/presentation/main/report/report_view_model.dart';
import 'package:financial_ledger/presentation/resources/color_manager.dart';
import 'package:financial_ledger/presentation/resources/font_manager.dart';
import 'package:financial_ledger/presentation/resources/strings_manager.dart';
import 'package:financial_ledger/presentation/resources/values_manager.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final ReportViewModel _viewModel = instance<ReportViewModel>();

  _bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder: (context, snapshot) {
            return snapshot.data?.getScreenWidget(
                  context: context,
                  contentScreenWidget: _getContentWidget(),
                  retryActionFunction: _viewModel.start,
                  resetStateFunction: _viewModel.resetState,
                ) ??
                Container();
          },
        ),
      ),
    );
  }

  Widget _getContentWidget() {
    return StreamBuilder(
      stream: _viewModel.outputReportData,
      builder: (context, snapshot) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8, vertical: AppPadding.p10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getCardWidget([
                _getSection(AppStrings.reportYourSpending),
                _getTotalSpending(snapshot.data?.totalSpendings),
              ]),
              _getCardWidget([
                _getSection(AppStrings.reportCategories),
                _getCategories(snapshot.data?.categories),
              ]),
              _getCardWidget([
                _getSection(AppStrings.reportNetWorth),
                _getNetWorth(snapshot.data?.netWorth),
              ]),
            ],
          ),
        );
      },
    );
  }

  Widget _getNetWorth(NetWorth? netWorth) {
    if (netWorth != null) {
      final totalAmount = netWorth.timeData.fold(ZERO, (sum, data) => sum + data.amount);
      double spendingRate = _calculateSpendingRate(timeData: netWorth.timeData);

      return Padding(
        padding: const EdgeInsets.only(left: AppPadding.p10, right: AppPadding.p10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSize.s16),
            Text(
              NumberFormat.simpleCurrency(locale: AppStrings.currency.tr()).format(totalAmount),
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    color: ColorManager.darkGrey,
                    fontSize: FontSize.s24,
                  ),
            ),
            RichText(
              text: TextSpan(
                text: AppStrings.last30Days.tr(),
                style: Theme.of(context).textTheme.titleMedium,
                children: <TextSpan>[
                  TextSpan(
                    text: _spendingRateFormatChange(spendingRate: spendingRate),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: spendingRate >= 0 ? ColorManager.green : ColorManager.red,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSize.s20),
            SizedBox(
              height: AppSize.s250,
              child: Padding(
                padding: const EdgeInsets.only(right: AppPadding.p2),
                child: LineChart(
                  LineChartData(
                    lineBarsData: [
                      LineChartBarData(
                        spots: _getNetWorthSpots(netWorth.timeData),
                        isCurved: true,
                        color: ColorManager.primaryOpacity70,
                        barWidth: 3,
                        isStrokeCapRound: true,
                        dotData: const FlDotData(show: false),
                        belowBarData: BarAreaData(
                          show: true,
                          gradient: LinearGradient(
                            colors: [
                              ColorManager.primaryOpacity70,
                              Colors.white,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ],
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 1,
                          getTitlesWidget: (value, _) => _getNetWorthLineTitlesWidget(value: value, timeData: netWorth.timeData),
                          reservedSize: 32,
                        ),
                      ),
                      leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                    gridData: const FlGridData(show: false),
                    borderData: FlBorderData(show: false),
                    clipData: const FlClipData.all(),
                    minX: 0,
                    maxX: (netWorth.timeData.length - 1).toDouble(),
                    minY: 0,
                    maxY: _maxY(timeData: netWorth.timeData), // 최대 y축 값 조정
                    lineTouchData: LineTouchData(
                      touchSpotThreshold: 10,
                      getTouchedSpotIndicator: (barData, spotIndexes) {
                        return spotIndexes.map((index) {
                          // 점선 스타일로 변경
                          return TouchedSpotIndicatorData(
                            FlLine(
                              color: ColorManager.lightGrey, // 터치 선 색상
                              strokeWidth: 2,
                              dashArray: [5, 5], // 점선 스타일 (길이 5, 간격 5)
                            ),
                            FlDotData(
                                show: true,
                                getDotPainter: (spot, percent, barData, index) {
                                  return FlDotCirclePainter(
                                    radius: 4, // 터치된 점의 크기
                                    color: ColorManager.primary, // 터치된 점의 색상
                                    strokeWidth: 1.0,
                                    strokeColor: ColorManager.lightGrey, // 점 둘레의 색상
                                  );
                                }),
                          );
                        }).toList();
                      },
                      touchTooltipData: LineTouchTooltipData(
                        fitInsideHorizontally: true, // 툴팁이 좌우로 화면을 벗어나지 않도록 함
                        fitInsideVertically: true,
                        maxContentWidth: double.infinity,
                        tooltipPadding: const EdgeInsets.all(AppPadding.p8),
                        tooltipRoundedRadius: AppSize.s8,
                        getTooltipItems: (touchedSpots) {
                          return touchedSpots.map((touchedSpot) {
                            final spotIndex = touchedSpot.x.toInt(); // x축 값을 인덱스로 변환
                            final spending = netWorth.timeData[spotIndex]; // 해당 인덱스의 지출 데이터 가져오기
                            final date = spending.date; // 날짜 가져오기

                            return LineTooltipItem(
                              "${AppStrings.date.tr()} : ${DateFormat('yyyy.MM.dd').format(DateTime.parse(date))}\n",
                              TextStyle(color: ColorManager.white, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                              children: <TextSpan>[
                                TextSpan(
                                  text: "${AppStrings.amount.tr()} : ${NumberFormat.simpleCurrency(
                                    locale: AppStrings.currency.tr(),
                                    decimalDigits: 0,
                                  ).format(touchedSpot.y)}",
                                ),
                              ],
                            );
                          }).toList();
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _getCardWidget(List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.only(top: AppPadding.p5),
      child: Card(
        elevation: AppSize.s1_5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s8),
          side: BorderSide(color: ColorManager.white, width: AppSize.s1_5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }

  Widget _getSection(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppPadding.p16,
        left: AppPadding.p10,
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.displaySmall,
      ).tr(),
    );
  }

  Widget _getCategories(List<Categories>? categories) {
    if (categories != null) {
      double totalAmount = categories.fold(0.0, (sum, category) {
        return sum + category.spendingData.fold(0.0, (innerSum, data) => innerSum + data.amount);
      });

      List<SpendingData> spendingData = categories.expand((data) => data.spendingData).toList();
      double spendingRate = _calculateSpendingRate(spendingData: spendingData);

      return Padding(
        padding: const EdgeInsets.only(left: AppPadding.p10, bottom: AppPadding.p20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSize.s16),
            Text(
              NumberFormat.simpleCurrency(locale: AppStrings.currency.tr()).format(totalAmount),
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    color: ColorManager.darkGrey,
                    fontSize: FontSize.s24,
                  ),
            ),
            RichText(
              text: TextSpan(
                text: AppStrings.last30Days.tr(),
                style: Theme.of(context).textTheme.titleMedium,
                children: <TextSpan>[
                  TextSpan(
                    text: _spendingRateFormatChange(spendingRate: spendingRate),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: spendingRate >= 0 ? ColorManager.green : ColorManager.red,
                        ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: AppSize.s250,
              child: StreamBuilder<int>(
                  stream: _viewModel.outputTouchedIndex,
                  builder: (context, snapshot) {
                    return PieChart(
                      PieChartData(
                        sections: getPieSections(
                          categories: categories,
                          totalAmount: totalAmount,
                          touchedIndex: snapshot.data ?? -1,
                        ),
                        borderData: FlBorderData(show: false),
                        sectionsSpace: 0,
                        centerSpaceRadius: 0,
                        startDegreeOffset: 0.0,
                        pieTouchData: PieTouchData(
                          enabled: true,
                          touchCallback: (event, pieTouchResponse) {
                            if (event.isInterestedForInteractions && pieTouchResponse != null) {
                              _viewModel.setTouchIndex(pieTouchResponse.touchedSection?.touchedSectionIndex);
                            } else {
                              _viewModel.setTouchIndex(null);
                            }
                          },
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  List<PieChartSectionData> getPieSections({
    required List<Categories> categories,
    required double totalAmount,
    required int touchedIndex,
  }) {
    final List<Color> colors = [
      Colors.orange,
      Colors.blue,
      Colors.green,
      Colors.red,
      Colors.yellow,
      Colors.indigo,
      Colors.purple,
    ];

    return categories.asMap().entries.map((entry) {
      int index = entry.key;
      Categories category = entry.value;

      double categoryAmount = category.spendingData.fold(0, (sum, data) => sum + data.amount);
      double percentage = (categoryAmount / totalAmount) * 100;

      // 순서대로 색상 할당
      final isTouched = index == touchedIndex;
      Color color = colors[index % colors.length];
      return PieChartSectionData(
        color: color,
        value: categoryAmount,
        title: '${percentage.toStringAsFixed(1)}%',
        radius: isTouched ? 120 : 110,
        titleStyle: Theme.of(context).textTheme.headlineSmall,
        badgeWidget: isTouched
            ? Container(
                padding: const EdgeInsets.all(AppSize.s10),
                decoration: BoxDecoration(
                  color: ColorManager.darkBlueGrey,
                  borderRadius: BorderRadius.circular(AppSize.s10),
                ),
                child: Text(
                  "${category.categoryName.capitalizeFirst()}\n${NumberFormat.simpleCurrency(locale: AppStrings.currency.tr()).format(categoryAmount)}",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              )
            : null,
        badgePositionPercentageOffset: 1.2,
      );
    }).toList();
  }

  Widget _getTotalSpending(List<TotalSpending>? totalSpending) {
    if (totalSpending != null) {
      final totalAmount = totalSpending.fold(ZERO, (sum, data) => sum + data.amount);
      double spendingRate = _calculateSpendingRate(totalSpending: totalSpending);

      return Padding(
        padding: const EdgeInsets.only(left: AppPadding.p10, right: AppPadding.p10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSize.s16),
            Text(
              NumberFormat.simpleCurrency(locale: AppStrings.currency.tr()).format(totalAmount),
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    color: ColorManager.darkGrey,
                    fontSize: FontSize.s24,
                  ),
            ),
            RichText(
              text: TextSpan(
                text: AppStrings.last30Days.tr(),
                style: Theme.of(context).textTheme.titleMedium,
                children: <TextSpan>[
                  TextSpan(
                    text: _spendingRateFormatChange(spendingRate: spendingRate),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: spendingRate >= 0 ? ColorManager.green : ColorManager.red,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSize.s20),
            SizedBox(
              height: AppSize.s250,
              child: Padding(
                padding: const EdgeInsets.only(right: AppPadding.p2),
                child: LineChart(
                  LineChartData(
                    lineBarsData: [
                      LineChartBarData(
                        spots: _getTotalSpendingSpots(totalSpending),
                        isCurved: true,
                        color: ColorManager.primaryOpacity70,
                        barWidth: 3,
                        isStrokeCapRound: true,
                        dotData: const FlDotData(show: false),
                        belowBarData: BarAreaData(
                          show: true,
                          gradient: LinearGradient(
                            colors: [
                              ColorManager.primaryOpacity70,
                              Colors.white,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ],
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 1,
                          getTitlesWidget: (value, _) => _getTotalSpendingLineTitlesWidget(value: value, totalSpending: totalSpending),
                          reservedSize: 32,
                        ),
                      ),
                      leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                    gridData: const FlGridData(show: false),
                    borderData: FlBorderData(show: false),
                    clipData: const FlClipData.all(),
                    minX: 0,
                    maxX: (totalSpending.length - 1).toDouble(),
                    minY: 0,
                    maxY: _maxY(totalSpending: totalSpending), // 최대 y축 값 조정
                    lineTouchData: LineTouchData(
                      touchSpotThreshold: 10,
                      getTouchedSpotIndicator: (barData, spotIndexes) {
                        return spotIndexes.map((index) {
                          // 점선 스타일로 변경
                          return TouchedSpotIndicatorData(
                            FlLine(
                              color: ColorManager.lightGrey, // 터치 선 색상
                              strokeWidth: 2,
                              dashArray: [5, 5], // 점선 스타일 (길이 5, 간격 5)
                            ),
                            FlDotData(
                                show: true,
                                getDotPainter: (spot, percent, barData, index) {
                                  return FlDotCirclePainter(
                                    radius: 4, // 터치된 점의 크기
                                    color: ColorManager.primary, // 터치된 점의 색상
                                    strokeWidth: 1.0,
                                    strokeColor: ColorManager.lightGrey, // 점 둘레의 색상
                                  );
                                }),
                          );
                        }).toList();
                      },
                      touchTooltipData: LineTouchTooltipData(
                        fitInsideHorizontally: true, // 툴팁이 좌우로 화면을 벗어나지 않도록 함
                        fitInsideVertically: true,
                        maxContentWidth: double.infinity,
                        tooltipPadding: const EdgeInsets.all(AppPadding.p8),
                        tooltipRoundedRadius: AppSize.s8,
                        getTooltipItems: (touchedSpots) {
                          return touchedSpots.map((touchedSpot) {
                            final spotIndex = touchedSpot.x.toInt(); // x축 값을 인덱스로 변환
                            final spending = totalSpending[spotIndex]; // 해당 인덱스의 지출 데이터 가져오기
                            final date = spending.spendingDate; // 날짜 가져오기

                            return LineTooltipItem(
                              "${AppStrings.date.tr()} : ${DateFormat('yyyy.MM.dd').format(DateTime.parse(date))}\n",
                              TextStyle(color: ColorManager.white, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                              children: <TextSpan>[
                                TextSpan(
                                  text: "${AppStrings.amount.tr()} : ${NumberFormat.simpleCurrency(
                                    locale: AppStrings.currency.tr(),
                                    decimalDigits: 0,
                                  ).format(touchedSpot.y)}",
                                ),
                              ],
                            );
                          }).toList();
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _getTotalSpendingLineTitlesWidget({required double value, required List<TotalSpending> totalSpending}) {
    // `value`가 50의 배수이고, 인덱스가 데이터 범위 내에 있는지 확인
    int index = value.toInt();
    if (index == 0 || index == totalSpending.length - 1) {
      return Padding(
        padding: index == 0 ? const EdgeInsets.only(left: AppPadding.p40) : const EdgeInsets.only(right: AppPadding.p28),
        child: Text(
          DateFormat("MM.dd").format(DateTime.parse(totalSpending[index].spendingDate)), // 날짜를 그대로 표시
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
    }

    // 나머지 인덱스는 빈 텍스트 반환
    return const Text("");
  }

  Widget _getNetWorthLineTitlesWidget({required double value, required List<TimeData> timeData}) {
    // `value`가 50의 배수이고, 인덱스가 데이터 범위 내에 있는지 확인
    int index = value.toInt();
    if (index == 0 || index == timeData.length - 1) {
      return Padding(
        padding: index == 0 ? const EdgeInsets.only(left: AppPadding.p40) : const EdgeInsets.only(right: AppPadding.p28),
        child: Text(
          DateFormat("MM.dd").format(DateTime.parse(timeData[index].date)), // 날짜를 그대로 표시
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
    }

    // 나머지 인덱스는 빈 텍스트 반환
    return const Text("");
  }

  double _maxY({List<TotalSpending>? totalSpending, List<TimeData>? timeData}) {
    if (totalSpending != null) {
      return totalSpending.map((item) => item.amount.toDouble()).reduce((a, b) => a > b ? a : b);
    } else {
      return timeData!.map((item) => item.amount.toDouble()).reduce((a, b) => a > b ? a : b);
    }
  }

  double _calculateSpendingRate({List<TotalSpending>? totalSpending, List<SpendingData>? spendingData, List<TimeData>? timeData}) {
    final today = DateTime.now();
    final currentMonthStart = DateTime(today.year, today.month, 1);
    final previousMonthStart = DateTime(today.year, today.month - 1, 1);
    final previousMonthEnd = DateTime(today.year, today.month, 0); // 지난달 마지막 날
    double spendingRate = 0.0;

    if (totalSpending != null) {
      // 이번 달 지출 합계 계산
      double currentMonthSpending = totalSpending
          .where((spending) =>
              DateTime.parse(spending.spendingDate).isAfter(currentMonthStart.subtract(const Duration(days: 1))) &&
              DateTime.parse(spending.spendingDate).isBefore(today.add(const Duration(days: 1))))
          .fold(0, (sum, item) => sum + item.amount);

      // 지난 달 지출 합계 계산
      double previousMonthSpending = totalSpending
          .where((spending) =>
              DateTime.parse(spending.spendingDate).isAfter(previousMonthStart.subtract(const Duration(days: 1))) &&
              DateTime.parse(spending.spendingDate).isBefore(previousMonthEnd.add(const Duration(days: 1))))
          .fold(0, (sum, item) => sum + item.amount);

      // 증감비율 계산
      double spendingDifference = currentMonthSpending - previousMonthSpending;
      spendingRate = (previousMonthSpending == 0) ? 0 : (spendingDifference / previousMonthSpending) * 100;
    } else if (spendingData != null) {
      // 이번 달 지출 합계 계산
      double currentMonthSpending = spendingData
          .where((spending) =>
              DateTime.parse(spending.spendingDate).isAfter(currentMonthStart.subtract(const Duration(days: 1))) &&
              DateTime.parse(spending.spendingDate).isBefore(today.add(const Duration(days: 1))))
          .fold(0, (sum, item) => sum + item.amount);

      // 지난 달 지출 합계 계산
      double previousMonthSpending = spendingData
          .where((spending) =>
              DateTime.parse(spending.spendingDate).isAfter(previousMonthStart.subtract(const Duration(days: 1))) &&
              DateTime.parse(spending.spendingDate).isBefore(previousMonthEnd.add(const Duration(days: 1))))
          .fold(0, (sum, item) => sum + item.amount);

      // 증감비율 계산
      double spendingDifference = currentMonthSpending - previousMonthSpending;
      spendingRate = (previousMonthSpending == 0) ? 0 : (spendingDifference / previousMonthSpending) * 100;
    } else {
      // 이번 달 지출 합계 계산
      double currentMonthSpending = timeData!
          .where((spending) =>
              DateTime.parse(spending.date).isAfter(currentMonthStart.subtract(const Duration(days: 1))) &&
              DateTime.parse(spending.date).isBefore(today.add(const Duration(days: 1))))
          .fold(0, (sum, item) => sum + item.amount);

      // 지난 달 지출 합계 계산
      double previousMonthSpending = timeData!
          .where((spending) =>
              DateTime.parse(spending.date).isAfter(previousMonthStart.subtract(const Duration(days: 1))) &&
              DateTime.parse(spending.date).isBefore(previousMonthEnd.add(const Duration(days: 1))))
          .fold(0, (sum, item) => sum + item.amount);

      // 증감비율 계산
      double spendingDifference = currentMonthSpending - previousMonthSpending;
      spendingRate = (previousMonthSpending == 0) ? 0 : (spendingDifference / previousMonthSpending) * 100;
    }

    return spendingRate;
  }

  String _spendingRateFormatChange({required double spendingRate}) {
    return spendingRate > 0 ? " +${spendingRate.toStringAsFixed(0)}%" : " ${spendingRate.toStringAsFixed(0)}%";
  }

  List<FlSpot> _getTotalSpendingSpots(List<TotalSpending> totalSpending) {
    return totalSpending.asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), entry.value.amount.toDouble());
    }).toList();
  }

  List<FlSpot> _getNetWorthSpots(List<TimeData> timeData) {
    return timeData.asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), entry.value.amount.toDouble());
    }).toList();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
