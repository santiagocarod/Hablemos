import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:hablemos/constants.dart';

final cloudinary = Cloudinary(
  API_KEY,
  API_SECRET,
  CLOUD_NAME,
);

Future<String> uploadImage(String imagePath, String folder) async {
  final response = await cloudinary.uploadFile(
    filePath: imagePath,
    resourceType: CloudinaryResourceType.image,
    folder: folder,
  );
  if (response.isSuccessful)
    return response.secureUrl;
  else
    return null;
}

Future<bool> deleteImage(String imagePath) async {
  final response = await cloudinary.deleteFile(
    url: imagePath,
    resourceType: CloudinaryResourceType.image,
    invalidate: false,
  );

  return response.isSuccessful;
}

Future<bool> deleteFolder(String folder) async {
  final response = await cloudinary.deleteFiles(
    prefix: folder,
  );

  return response.isSuccessful;
}
