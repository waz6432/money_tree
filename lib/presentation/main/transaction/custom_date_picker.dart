import 'package:financial_ledger/presentation/resources/color_manager.dart';
import 'package:financial_ledger/presentation/resources/font_manager.dart';
import 'package:financial_ledger/presentation/resources/strings_manager.dart';
import 'package:financial_ledger/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class CustomDatePicker extends StatefulWidget {
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final ValueChanged<DateTime> onChanged;

  const CustomDatePicker({
    super.key,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    required this.onChanged,
  });

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  late DateTime selectedDate;
  late DateTime displayedMonth;
  late int tempSelectedYear;
  DateTime currentDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate;
    displayedMonth = DateTime(widget.initialDate.year, widget.initialDate.month, 1);
    tempSelectedYear = selectedDate.year;
  }

  Future<void> _showYearPickerDialog() async {
    await showDialog(
      context: context,
      builder: (context) {
        int currentlySelectedYear = tempSelectedYear;

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(AppSize.s16),
                child: Text(
                  AppStrings.selectYear,
                  style: Theme.of(context).textTheme.titleLarge,
                ).tr(),
              ),
              const Divider(),
              SizedBox(
                height: AppSize.s150,
                child: ListWheelScrollView.useDelegate(
                  controller: FixedExtentScrollController(
                    initialItem: tempSelectedYear - widget.firstDate.year,
                  ),
                  itemExtent: AppSize.s50,
                  physics: const FixedExtentScrollPhysics(),
                  onSelectedItemChanged: (index) {
                    setState(() {
                      currentlySelectedYear = widget.firstDate.year + index;
                    });
                  },
                  childDelegate: ListWheelChildBuilderDelegate(
                    childCount: widget.lastDate.year - widget.firstDate.year + 1,
                    builder: (context, index) {
                      final year = widget.firstDate.year + index;
                      final isSelected = year == currentlySelectedYear;

                      return Container(
                        height: AppSize.s50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isSelected ? ColorManager.primaryOpacity20 : Colors.transparent,
                        ),
                        child: Text(
                          '$year',
                          style: TextStyle(
                            fontSize: isSelected ? FontSize.s24 : FontSize.s18,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            color: isSelected ? ColorManager.primary : Colors.black,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      AppStrings.cancel,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ).tr(),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        tempSelectedYear = currentlySelectedYear;
                        selectedDate = DateTime(tempSelectedYear, selectedDate.month, selectedDate.day);
                        displayedMonth = DateTime(tempSelectedYear, displayedMonth.month, 1);
                      });
                      Navigator.pop(context);
                    },
                    child: Text(
                      AppStrings.ok,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ).tr(),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _nextMonth() {
    setState(() {
      displayedMonth = DateTime(displayedMonth.year, displayedMonth.month + 1, 1);
    });
  }

  void _previousMonth() {
    setState(() {
      displayedMonth = DateTime(displayedMonth.year, displayedMonth.month - 1, 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: AppSize.s0,
              top: AppSize.s4,
              left: AppSize.s16,
              right: AppSize.s16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: _previousMonth,
                ),
                GestureDetector(
                  onTap: _showYearPickerDialog,
                  child: Text(
                    DateFormat("MMMM yyyy", AppStrings.locale.tr()).format(displayedMonth),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed: _nextMonth,
                ),
              ],
            ),
          ),
          const Divider(),
          _buildCalendar(),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  AppStrings.cancel,
                  style: Theme.of(context).textTheme.headlineMedium,
                ).tr(),
              ),
              TextButton(
                // 확인 버튼을 눌렀을 때 onChanged 호출
                onPressed: () {
                  widget.onChanged(selectedDate); // 선택된 날짜를 외부로 전달
                  Navigator.pop(context, selectedDate);
                },
                child: Text(
                  AppStrings.ok,
                  style: Theme.of(context).textTheme.headlineMedium,
                ).tr(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    final DateTime firstDayOfMonth = DateTime(displayedMonth.year, displayedMonth.month, 1);
    final DateTime lastDayOfMonth = DateTime(displayedMonth.year, displayedMonth.month + 1, 0);
    final int daysInMonth = lastDayOfMonth.day;
    final int firstWeekday = firstDayOfMonth.weekday % 7;

    final DateTime prevMonth = DateTime(displayedMonth.year, displayedMonth.month - 1);
    final int prevMonthDays = DateTime(prevMonth.year, prevMonth.month + 1, 0).day;

    List<Widget> dayTiles = [];

    for (int i = firstWeekday - 1; i >= 0; i--) {
      final int day = prevMonthDays - i;
      dayTiles.add(_buildDayTile(DateTime(prevMonth.year, prevMonth.month, day), isInThisMonth: false));
    }

    for (int day = 1; day <= daysInMonth; day++) {
      final DateTime currentDay = DateTime(displayedMonth.year, displayedMonth.month, day);
      dayTiles.add(_buildDayTile(currentDay));
    }

    final int remainingDays = 7 - (dayTiles.length % 7);
    if (remainingDays < 7) {
      for (int i = 1; i <= remainingDays; i++) {
        dayTiles.add(_buildDayTile(DateTime(displayedMonth.year, displayedMonth.month + 1, i), isInThisMonth: false));
      }
    }

    return Column(
      children: [
        GridView.count(
          crossAxisCount: 7,
          shrinkWrap: true,
          children: _buildWeekdayLabels(),
        ),
        GridView.count(
          crossAxisCount: 7,
          shrinkWrap: true,
          children: dayTiles,
        ),
      ],
    );
  }

  Widget _buildDayTile(DateTime day, {bool isInThisMonth = true}) {
    bool isSelected = day.year == selectedDate.year && day.month == selectedDate.month && day.day == selectedDate.day;
    bool isToday = day.year == currentDate.year && day.month == currentDate.month && day.day == currentDate.day;

    Color textColor = isInThisMonth ? ColorManager.black : ColorManager.grey;
    if (day.weekday == DateTime.saturday) textColor = Colors.blue;
    if (day.weekday == DateTime.sunday) textColor = Colors.red;

    return InkWell(
      onTap: () {
        setState(() {
          selectedDate = day;
          if (!isInThisMonth) {
            displayedMonth = DateTime(day.year, day.month, 1);
          }
        });
      },
      borderRadius: BorderRadius.circular(AppSize.s100),
      child: Container(
        decoration: isSelected
            ? BoxDecoration(
                color: ColorManager.primary,
                shape: BoxShape.circle,
              )
            : isToday
                ? BoxDecoration(
                    border: Border.all(
                      color: ColorManager.primary,
                      width: AppSize.s2,
                    ),
                    shape: BoxShape.circle,
                  )
                : null,
        alignment: Alignment.center,
        child: Text(
          '${day.day}',
          style: TextStyle(
            color: isSelected ? ColorManager.white : textColor,
            fontWeight: isSelected || isToday ? FontWeightManager.bold : FontWeightManager.medium,
          ),
        ),
      ),
    );
  }

  List<Widget> _buildWeekdayLabels() {
    List<String> weekdays = ['일', '월', '화', '수', '목', '금', '토'];
    return weekdays.map((day) {
      Color textColor = Colors.black;
      if (day == '토') textColor = Colors.blue;
      if (day == '일') textColor = Colors.red;
      return Center(
        child: Text(
          day,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }).toList();
  }
}
