import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/constants/colors.dart';
import '../../core/utils/constants/images.dart';
import '../../core/utils/extension/extension.dart';
import '../controllers/archive/archive_cubit.dart';

class ArchiveScreen extends StatelessWidget {
  const ArchiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const border = BorderSide(width: 2, color: ColorManager.brown);
    Widget invoiceText(String text) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(text,
            style: context.textTheme.displayMedium
                ?.copyWith(fontWeight: FontWeight.w600)),
      );
    }

    Widget headerText(String text) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(text,
            style: context.textTheme.bodyMedium),
      );
    }

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(ImageManager.homeBackground),
              ),
            ),
          ),
          Positioned(
            left: 5,
            top: 5,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
            ),
          ),
          Container(
            color: ColorManager.white.withOpacity(0.8),
            width: context.width * 0.9,
            height: context.height * 0.9,
            child: Column(
              children: [
                Container(
                  color: ColorManager.brown,
                  child: Table(
                    border:
                        TableBorder.all(width: 2, color: ColorManager.black),
                    columnWidths: {
                      0: FixedColumnWidth(15.w),
                      4: FixedColumnWidth(30.w),
                      1: FixedColumnWidth(60.w),
                      2: const FlexColumnWidth(),
                      3: FixedColumnWidth(55.w),
                    },
                    children: [
                      TableRow(
                        children: [
                          headerText('.NO'),
                          headerText('Customer Name'),
                          headerText('Items'),
                          headerText('Date & Time'),
                          headerText('Total (EGP)'),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: BlocBuilder<ArchiveCubit, ArchiveState>(
                    builder: (context, state) {
                      if (state is ArchiveLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is ArchiveLoaded) {
                        return ListView.builder(
                          itemCount: state.list.length,
                          itemBuilder: (context, index) {
                            final invoice = state.list[index];
                            return Column(
                              children: [
                                Table(
                                  border: const TableBorder(
                                    bottom: border,
                                    right: border,
                                    left: border,
                                    verticalInside: border,
                                  ),
                                  columnWidths: {
                                    0: FixedColumnWidth(15.w),
                                    4: FixedColumnWidth(30.w),
                                    1: FixedColumnWidth(60.w),
                                    2: const FlexColumnWidth(),
                                    3: FixedColumnWidth(55.w),
                                  },
                                  children: [
                                    TableRow(
                                      children: [
                                        invoiceText(
                                            invoice.invoiceNumber.toString()),
                                        invoiceText(invoice.customerName),
                                        invoiceText(invoice.items),
                                        invoiceText(
                                            '${invoice.date} - ${invoice.time}'),
                                        invoiceText(
                                            '${invoice.totalAmount} EGP'),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        return const Center(child: Text('No invoices found.'));
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
