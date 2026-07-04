import '../../../../core/error/result.dart';
import '../entities/batch_item.dart';
import '../entities/contact_record.dart';
import '../entities/duplicate_group.dart';

abstract class ContactsRepository {
  Future<Result<List<BatchItem>>> fetchBatches();
  Future<Result<List<ContactRecord>>> fetchContactsForBatch(String batchId);
  Future<Result<List<DuplicateGroup>>> fetchDuplicateGroups();
  Future<Result<bool>> requestPermission();
  Future<Result<bool>> hasPermission();
  Future<Result<void>> mergeDuplicateGroup(String groupId);
  Future<Result<void>> keepBothDuplicateGroup(String groupId);
  Future<Result<void>> deleteOneFromDuplicateGroup(String groupId);
}
