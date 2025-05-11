import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/repositories/data_export_repository.dart';

// Events
abstract class DataExportEvent extends Equatable {
  const DataExportEvent();

  @override
  List<Object> get props => [];
}

class ExportData extends DataExportEvent {
  final Map<String, dynamic> data;

  const ExportData(this.data);

  @override
  List<Object> get props => [data];
}

class LoadExportedData extends DataExportEvent {}

// States
abstract class DataExportState extends Equatable {
  const DataExportState();

  @override
  List<Object> get props => [];
}

class DataExportInitial extends DataExportState {}

class DataExportLoading extends DataExportState {}

class DataExportSuccess extends DataExportState {
  final List<Map<String, dynamic>> data;

  const DataExportSuccess(this.data);

  @override
  List<Object> get props => [data];
}

class DataExportError extends DataExportState {
  final String message;

  const DataExportError(this.message);

  @override
  List<Object> get props => [message];
}

// Bloc
class DataExportBloc extends Bloc<DataExportEvent, DataExportState> {
  final DataExportRepository repository;

  DataExportBloc(this.repository) : super(DataExportInitial()) {
    on<ExportData>(_onExportData);
    on<LoadExportedData>(_onLoadExportedData);
  }

  Future<void> _onExportData(ExportData event, Emitter<DataExportState> emit) async {
    try {
      emit(DataExportLoading());
      await repository.exportData(event.data);
      final data = await repository.getExportedData();
      emit(DataExportSuccess(data));
    } catch (e) {
      emit(DataExportError(e.toString()));
    }
  }

  Future<void> _onLoadExportedData(LoadExportedData event, Emitter<DataExportState> emit) async {
    try {
      emit(DataExportLoading());
      final data = await repository.getExportedData();
      emit(DataExportSuccess(data));
    } catch (e) {
      emit(DataExportError(e.toString()));
    }
  }
} 