import 'dart:typed_data';

import 'package:s_boxes_p_boxes/s_boxes_p_boxes.dart';

void main() {
  var sBox = AESSBox();
  Uint8List plaintext = Uint8List.fromList([1, 2, 3, 4, 5, 6, 7, 8, 255]);
  Uint8List ciphertext = sBox.encryptByteArray(plaintext);
  print(ciphertext); //[124, 119, 123, 242, 107, 111, 197, 48, 22]

  Uint8List decryptedText = sBox.decryptByteArray(ciphertext);
  print(decryptedText); //[1, 2, 3, 4, 5, 6, 7, 8, 255]
}
