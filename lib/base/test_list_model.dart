import '../page_index.dart';
import 'base_list_model.dart';

class TextListModel extends BaseListModel<JuZiMi> {
  @override
  Future<List<JuZiMi>> loadData() async {
    return await OtherRepository.getJuZiMiListByType("aiqing", pageNumber);
  }
}
