import 'package:financial_ledger/app/di.dart';
import 'package:financial_ledger/data/mapper/mapper.dart';
import 'package:financial_ledger/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:financial_ledger/presentation/main/transaction/custom_date_picker.dart';
import 'package:financial_ledger/presentation/main/transaction/new_transaction_view_model.dart';
import 'package:financial_ledger/presentation/resources/routes_manager.dart';
import 'package:financial_ledger/presentation/resources/strings_manager.dart';
import 'package:financial_ledger/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

class NewTransactionPage extends StatefulWidget {
  const NewTransactionPage({super.key});

  @override
  State<NewTransactionPage> createState() => _NewTransactionPageState();
}

class _NewTransactionPageState extends State<NewTransactionPage> {
  final NewTransactionViewModel _viewModel = instance<NewTransactionViewModel>();
  final _formKey = GlobalKey<FormState>();
  final NumberFormat _numberFormat = NumberFormat('#,###');

  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  String initCategory = AppStrings.food;
  DateTime initDate = DateTime.now();

  List<String> categories = const <String>[
    AppStrings.food,
    AppStrings.shopping,
    AppStrings.transport,
    AppStrings.housing,
    AppStrings.entertainment,
    AppStrings.health,
    AppStrings.education,
    AppStrings.other,
  ];

  _bind() {
    _viewModel.start();
    _amountController.addListener(() {
      _viewModel.setAmount(_amountController.text.isNotEmpty ? int.parse(_amountController.text.replaceAll(",", "")) : ZERO);
    });
    _noteController.addListener(() => _viewModel.setNote(_noteController.text));
    _viewModel.setCategory(categories.first);
    _viewModel.setDate(DateFormat("yyyy.MM.dd").format(DateTime.now()));

    _viewModel.isAddNewTransactionSuccessfullyStreamController.stream.listen((isAddNewTransaction) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
      });
    });
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FlowState>(
      stream: _viewModel.outputState,
      builder: (context, snapshot) {
        return snapshot.data?.getScreenWidget(
              context: context,
              contentScreenWidget: _getContentWidget(),
              retryActionFunction: _viewModel.start,
              resetStateFunction: _viewModel.resetState,
            ) ??
            _getContentWidget();
      },
    );
  }

  Widget _getContentWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AppPadding.p10,
        horizontal: AppPadding.p8,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: AppPadding.p16,
                  left: AppPadding.p10,
                ),
                child: Text(
                  AppStrings.amount,
                  style: Theme.of(context).textTheme.displaySmall,
                ).tr(),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: AppPadding.p8,
                  left: AppPadding.p10,
                  right: AppPadding.p10,
                ),
                child: StreamBuilder<String?>(
                  stream: _viewModel.outputErrorAmount,
                  builder: (context, snapshot) {
                    return TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      controller: _amountController,
                      decoration: InputDecoration(
                        prefixText: AppStrings.currencySymbol.tr(),
                        hintText: AppStrings.amountHint.tr(),
                        labelText: AppStrings.amount.tr(),
                        errorText: snapshot.data,
                      ),
                      onChanged: (amount) {
                        String formattedValue = _formatNumber(amount);
                        _amountController.value = TextEditingValue(
                          text: formattedValue,
                          selection: TextSelection.collapsed(offset: formattedValue.length), // 커서를 끝으로 이동
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: AppSize.s10),
              Padding(
                padding: const EdgeInsets.only(
                  top: AppPadding.p16,
                  left: AppPadding.p10,
                ),
                child: Text(
                  AppStrings.note,
                  style: Theme.of(context).textTheme.displaySmall,
                ).tr(),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: AppPadding.p8,
                  left: AppPadding.p10,
                  right: AppPadding.p10,
                ),
                child: StreamBuilder<String>(
                  stream: _viewModel.outputNote,
                  builder: (context, snapshot) {
                    return TextFormField(
                      keyboardType: TextInputType.multiline,
                      controller: _noteController,
                      maxLines: 10,
                      minLines: 10,
                      maxLength: 1000,
                      decoration: InputDecoration(
                        hintText: AppStrings.noteHint.tr(),
                        labelText: AppStrings.note.tr(),
                        alignLabelWithHint: true,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: AppSize.s16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: AppPadding.p10,
                    ),
                    child: Text(
                      AppStrings.category,
                      style: Theme.of(context).textTheme.displaySmall,
                    ).tr(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: AppPadding.p10,
                    ),
                    child: _dropdownCategoryItem(categories: categories),
                  ),
                ],
              ),
              const SizedBox(height: AppSize.s16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: AppPadding.p10,
                    ),
                    child: Text(
                      AppStrings.date,
                      style: Theme.of(context).textTheme.displaySmall,
                    ).tr(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: AppPadding.p10,
                    ),
                    child: _datePickerWidget(context),
                  ),
                ],
              ),
              const SizedBox(height: AppSize.s28),
              Padding(
                padding: const EdgeInsets.only(
                  left: AppPadding.p8,
                  right: AppPadding.p8,
                ),
                child: StreamBuilder<bool>(
                  stream: _viewModel.outputIsAllInputsValid,
                  builder: (context, snapshot) {
                    return SizedBox(
                      width: double.infinity,
                      height: AppSize.s40,
                      child: ElevatedButton(
                        onPressed: (snapshot.data ?? false) ? () => _viewModel.newTransaction() : null,
                        child: const Text(AppStrings.addNewTransaction).tr(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatNumber(String amount) {
    if (amount.isEmpty) return "";
    final number = int.parse(amount.replaceAll(",", "")); // 쉼표 제거 후 숫자로 변환
    return _numberFormat.format(number); // 다시 쉼표를 포함한 숫자 포맷
  }

  Widget _datePickerWidget(BuildContext context) {
    return TextButton(
      onPressed: () => _openDatePicker(context),
      child: StreamBuilder<DateTime>(
          stream: _viewModel.outputDate,
          builder: (context, snapshot) {
            return Text(
              DateFormat("yyyy.MM.dd").format(snapshot.data ?? initDate),
              style: Theme.of(context).textTheme.displayLarge, // 원하는 색상으로 변경 가능
            );
          }),
    );
  }

  _openDatePicker(BuildContext context) {
    showDialog<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return CustomDatePicker(
          initialDate: initDate,
          firstDate: DateTime(1950),
          lastDate: DateTime(2100),
          onChanged: (selectedDate) {
            _viewModel.setDate(DateFormat("yyyy.MM.dd").format(selectedDate));
            initDate = selectedDate;
          },
        );
      },
    );
  }

  Widget _dropdownCategoryItem({required List<String> categories}) {
    return StreamBuilder<String>(
      stream: _viewModel.outputCategory,
      builder: (context, snapshot) {
        return DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isDense: true,
            isExpanded: false,
            alignment: Alignment.centerRight,
            value: snapshot.data ?? initCategory,
            onChanged: (selectedCategory) {
              if (selectedCategory != null) {
                initCategory = selectedCategory;
                _viewModel.setCategory(selectedCategory);
              }
            },
            items: categories.map<DropdownMenuItem<String>>((category) {
              return DropdownMenuItem<String>(
                value: category,
                child: Row(
                  children: [
                    Text(
                      category,
                      style: Theme.of(context).textTheme.displayLarge,
                    ).tr(),
                  ],
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    _viewModel.dispose();
    super.dispose();
  }
}
