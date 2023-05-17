import 'dart:typed_data';

import 'package:s_boxes_p_boxes/s_boxes_p_boxes.dart';

void main() {
  var sBox = AESSBox();
  var mirrorPermutation = PBox([7, 6, 5, 4, 3, 2, 1, 0]);
  //simple cipher
  Uint8List plaintext = Uint8List.fromList([1, 2, 3, 4, 5, 6, 7, 8, 255]);
  Uint8List ciphertext = sBox.encryptByteArray(mirrorPermutation.encryptByteArray(plaintext));
  print(ciphertext); //[205, 9, 186, 183, 224, 208, 225, 202, 22]

  Uint8List decryptedText = mirrorPermutation.decryptByteArray(sBox.decryptByteArray(ciphertext));
  print(decryptedText); //[1, 2, 3, 4, 5, 6, 7, 8, 255]
}
