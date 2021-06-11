# Para las claves

Es necesario generar las claves desde la consola de firebase. 

* Para Android:
    
    Desde los ajustes del proyecto de Firebase descargar el archivo ```google-services.json```
    ![image](https://user-images.githubusercontent.com/23182382/121728167-82a87680-cab2-11eb-991e-7ff1ccd543aa.png)
    Y ponerlo en la carpeta [android/app/](android/app/)

* Para iOS

    Desde los ajustes del proyecto de Firebase descargar el archivo ```GoogleService-Info.plist```
    ![image](https://user-images.githubusercontent.com/23182382/121729234-d5cef900-cab3-11eb-991e-c33209a777e9.png)
    Y ponerlo en la carpeta [ios/](ios/)

* Para Web
    
    Desde los ajustes del proyecto de Firebase copiar y pegar
    ![image](https://user-images.githubusercontent.com/23182382/121729627-4e35ba00-cab4-11eb-9cf1-8f62681392e0.png)
    en el archivo [web/index.html](web/index.html). Mas especificamente adentro del tag ```<body>```

* Para Cloudinary

    Generar las claves de API en la página de Cloudinary y reemplazar en el archivo [lib/constants.dart](lib/constants.dart) en las constantes de:
    
    * API_KEY
    * API_SECRET 

