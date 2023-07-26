import 'package:behaviour/behaviour.dart';
import 'package:image_picker/image_picker.dart';

class TakePicture extends BehaviourWithoutInput<XFile?> {
  TakePicture({
    super.monitor,
    required this.imagePicker,
  });

  final ImagePicker imagePicker;

  @override
  Future<XFile?> action(BehaviourTrack? track) {
    final picker = ImagePicker();
    return picker.pickImage(
      source: ImageSource.camera,
    );
  }
}
