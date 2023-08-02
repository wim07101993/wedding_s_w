import 'package:behaviour/behaviour.dart';
import 'package:image_picker/image_picker.dart';

class TakePicture extends BehaviourWithoutInput<XFile?> {
  TakePicture({
    super.monitor,
    required this.imagePicker,
  });

  final ImagePicker imagePicker;

  @override
  String get tag => 'take picture';

  @override
  Future<XFile?> action(BehaviourTrack? track) {
    return imagePicker.pickImage(source: ImageSource.camera);
  }
}
