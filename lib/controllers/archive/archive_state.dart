part of 'archive_cubit.dart';

@immutable
abstract class ArchiveState {}

class ArchiveInitial extends ArchiveState {}

class ArchiveLoading extends ArchiveState {}

class ArchiveLoaded extends ArchiveState {
  final List<ArchiveModel> list;
  ArchiveLoaded({required this.list});
}
