import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

part 'invoice_state.dart';

class InvoiceCubit extends Cubit<InvoiceState> {
  InvoiceCubit() : super(InvoiceInitial());

  Future<pw.Document> generateInvoice() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('City Road - empty',
                  style: const pw.TextStyle(fontSize: 14)),
              pw.Text('Phone: empty', style: const pw.TextStyle(fontSize: 14)),
              pw.Text('Tax Number: empty',
                  style: const pw.TextStyle(fontSize: 14)),
              pw.SizedBox(height: 10),
              pw.BarcodeWidget(
                barcode: pw.Barcode.code128(),
                data: '000002',
                width: 200,
                height: 80,
              ),
              pw.SizedBox(height: 10),
              pw.Text('Invoice Number: empty',
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.bold)),
              pw.Text('Simple Sales Invoice',
                  style: const pw.TextStyle(fontSize: 18)),
              pw.SizedBox(height: 10),
              pw.Text('Date: 2024-07-08',
                  style: const pw.TextStyle(fontSize: 14)),
              pw.Text('Time: 19:04 PM',
                  style: const pw.TextStyle(fontSize: 14)),
              pw.SizedBox(height: 10),
              pw.Text('Customer Name: empty',
                  style: const pw.TextStyle(fontSize: 14)),
              pw.SizedBox(height: 10),
              pw.Table.fromTextArray(
                context: context,
                border: pw.TableBorder.all(),
                headers: <String>[
                  'Item',
                  'Price',
                  'Tax',
                  'Discount',
                  'Total',
                  'Quantity'
                ],
                data: <List<String>>[
                  <String>['orange', '1.00', '0.15', '0.00', '1.15', '1'],
                  <String>['lemon', '5.00', '0.75', '0.00', '5.75', '1'],
                ],
              ),
              pw.SizedBox(height: 10),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('Total Amount: \$6.00',
                          style: const pw.TextStyle(fontSize: 14)),
                      pw.Text('Tax: \$0.90',
                          style: const pw.TextStyle(fontSize: 14)),
                      pw.Text('Grand Total: \$6.90',
                          style: pw.TextStyle(
                              fontSize: 14, fontWeight: pw.FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
    // await Printing.layoutPdf(
    //   onLayout: (PdfPageFormat format) async => pdf.save(),
    // );
    await Printing.sharePdf(bytes: await pdf.save(), filename: 'invoice.pdf');
    return pdf;
  }
}