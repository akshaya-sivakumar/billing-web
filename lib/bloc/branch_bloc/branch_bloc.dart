
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/branchDetail.dart';
import '../../models/branch_request.dart';
import '../../repository/branch_repo.dart';

part 'branch_event.dart';
part 'branch_state.dart';

class BranchBloc extends Bloc<BranchEvent, BranchState> {
  BranchBloc() : super(BranchInitial()) {
    on<FetchBranch>((event, emit) async {
      emit(BranchLoad());
      try {
        var response = await BranchRepository().getBranch();
        emit(BranchDone(response));
      } catch (e) {
        emit(BranchError());
      }
      // TODO: implement event handler
    });

    on<CreateBranch>((event, emit) async {
      emit(CreateBranchLoad());
      try {
        var response =
            await BranchRepository().createBranch(event.branchRequest);
        emit(CreateBranchDone());
      } catch (e) {
        emit(CreateBranchError());
      }
      // TODO: implement event handler
    });

    on<UpdateBranchEvent>((event, emit) async {
      emit(UpdateBranchLoad());

      try {
        var response =
            await BranchRepository().updateBranch(event.id, event.request);

        emit(UpdateBranchDone());
      } catch (e) {
        emit(UpdateBranchError());
      }
    });

    on<DeleteBranchEvent>((event, emit) async {
      emit(DeleteBranchLoad());

      try {
        var response = await BranchRepository().deleteBranch(event.id);

        emit(DeleteBranchDone());
      } catch (e) {
        emit(DeleteBranchError());
      }
    });
  }
}
