import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:hablemos/constants.dart';

///Configuración general de Cloudinary
final cloudinary = Cloudinary(
  API_KEY,
  API_SECRET,
  CLOUD_NAME,
);

///Subir una imagen con ruta dentro del dispositivo [imagePath] en la carpeta[folder]
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

///Eliminar imagen en la ruta [imagePath]
Future<bool> deleteImage(String imagePath) async {
  final response = await cloudinary.deleteFile(
    url: imagePath,
    resourceType: CloudinaryResourceType.image,
    invalidate: false,
  );

  return response.isSuccessful;
}
