import 'package:file_picker/file_picker.dart';
import 'package:medswift/models/file_model.dart';

class PickFiles {
  Future<List<FileModel>> pickFiles() async {
    final files = await FilePicker.platform
        .pickFiles(withData: true, withReadStream: true, allowMultiple: true);
    return files!.files
        .map(
          (e) => FileModel(
            data: e.bytes!,
            title: e.name,
          ),
        )
        .toList();
  }
}
