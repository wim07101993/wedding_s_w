import 'package:behaviour/behaviour.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';

class TakePicture extends Behaviour<CameraController?, XFile?> {
  TakePicture({
    super.monitor,
    required this.imagePicker,
  });

  final ImagePicker imagePicker;

  @override
  String get tag => 'take picture';

  @override
  Future<XFile?> action(CameraController? camera, BehaviourTrack? track) {
    if (camera != null) {
      return camera.takePicture();
    } else {
      return imagePicker.pickImage(source: ImageSource.camera);
    }
  }
}
