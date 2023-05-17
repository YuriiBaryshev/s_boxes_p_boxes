# S-Boxes and P-boxes implementation

The dart package, which was developed with Flutter framework to implement S-boxes and P-boxes transformations.

## Features

1. Implements EAS S-box

## Getting started

You should install Dart programming language SDK and Flutter framework. Then clone the repository and call in the cloned directory command line `flutter pub get` in order to install dependencies. To run the autotests call `flutter test`.

## Usage

#### AES S-box

To cipher just 1 byte of data use `encryptByte`/`decryptByte` methods pair
```dart
    var sBox = AESSBox();
    int ciphertextByte = sBox.encryptByte(42);
    print(ciphertextByte); //229
    
    int decryptedByte = sBox.decryptByte(ciphertextByte);
    print(decryptedByte); //42
```

For more applicable implementation one may use `encryptByteArray`/`decryptByteArry` methods

```dart
    var sBox = AESSBox();
    Uint8List plaintext = Uint8List.fromList([1, 2, 3, 4, 5, 6, 7, 8, 255]);
    Uint8List ciphertext = sBox.encryptByteArray(plaintext);
    print(ciphertext); //[124, 119, 123, 242, 107, 111, 197, 48, 22]
        
    Uint8List decryptedText = sBox.decryptByteArray(ciphertext);
    print(decryptedText); //[1, 2, 3, 4, 5, 6, 7, 8, 255]
```
