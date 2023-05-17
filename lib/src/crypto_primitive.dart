part of s_boxes_p_boxes;

abstract class CryptoPrimitive {
  int encryptByte(int plaintextByte);
  int decryptByte(int ciphertextByte);

  ///Encrypt byte array
  Uint8List encryptByteArray(Uint8List plaintext) {
    Uint8List ciphertext = Uint8List(plaintext.length);
    for(int i = 0; i < plaintext.length; i++) {
      ciphertext[i] = encryptByte(plaintext[i]);
    }

    return ciphertext;
  }


  ///Decrypt byte array
  Uint8List decryptByteArray(Uint8List ciphertext) {
    Uint8List plaintext = Uint8List(ciphertext.length);
    for(int i = 0; i < ciphertext.length; i++) {
      plaintext[i] = decryptByte(ciphertext[i]);
    }

    return plaintext;
  }
}