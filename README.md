# cuervo_document_scanner

A document scanner plugin with automatic cropping function and option to pick image from gallery or camera

<img src="https://user-images.githubusercontent.com/1488063/167291601-c64db2d5-78ab-4781-bc7a-afe7eb93e083.png" height ="400" />
<img src="https://user-images.githubusercontent.com/1488063/167291821-3b66d0bb-b636-4911-a572-d2368dc95012.jpeg" height ="400" />
<img src="https://user-images.githubusercontent.com/1488063/167291827-fa0ae804-1b81-4ef4-8607-3b212c3ab1c0.jpeg" height ="400" />


## Getting Started

Handle camera access permission

### **IOS**

Add String properties to the app's Info.plist file with the keys NSCameraUsageDescription and NSPhotoLibraryUsageDescription and the values as the description for why your app needs camera and gallery access.

	<key>NSCameraUsageDescription</key>
	<string>Camera Permission Description</string>
	<key>NSPhotoLibraryUsageDescription</key>
    <string>Gallery Permission Description</string>

### **Android**

minSdkVersion should be at least 21


## How to use ?

```
    final imagesPath = await CuervoDocumentScanner.getPictures(Source.CAMERA)
```

The path's to the cropped Images will be returned as ```List<String>```. if you want to get the images from gallery, just change the source to ```Source.GALLERY```


## Contributing

### Step 1

- Fork this project's repo : 

### Step 2

-  Create a new pull request.



## License
This project is licensed under the MIT License - see the LICENSE.md file for details
