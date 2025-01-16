import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/service/cache/cache.dart';
import '../../../data/models/archive.dart';
import '../../../data/repository/fruits.dart';

part 'archive_state.dart';

class ArchiveCubit extends Cubit<ArchiveState> {
  ArchiveCubit() : super(ArchiveInitial());

  Future<void> fetchInvoices() async {
    emit(ArchiveLoading());
    final List<ArchiveModel>? invoices = await FruitsRepository.instance
        .getInvoices(CacheData.getData(key: 'currentUser'));
    emit(ArchiveLoaded(list: invoices ?? []));
  }
}
