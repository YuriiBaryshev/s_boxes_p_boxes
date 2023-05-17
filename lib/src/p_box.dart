part of s_boxes_p_boxes;

///Implements custom P-box
class PBox {
  Uint8List _permutationRule = Uint8List(8);

  ///Initiates P-box with certain permutation rule, which should be passed as
  ///a list (kind of array in Dart) of new bits positions.
  ///
  ///Therefore there should be exact 8 elements, and each element
  ///must be unique and have values from the set {0, 1, 2, 3, 4, 5, 6, 7}
  ///
  ///Where input [0, 1, 2, 3, 4, 5, 6, 7] means there will be no permutation
  ///[7, 6, 5, 4, 3, 2, 1, 0] means there will be reverse bit order (mirror)
  PBox(List<int> permutationRule) {
    if(permutationRule.length != 8) {
      throw ArgumentError("PBox: the set of new bits positions within byte must"
          " have exact 8 elements");
    }

    if(permutationRule.toSet().toList().length != 8) {
      throw ArgumentError("PBox: elements of the input must be unique");
    }

    for(int i = 0; i < 8; i++) {
      if((permutationRule[i] > 7) || (permutationRule[i] < 0)) {
        throw ArgumentError("PBox: elements of the input must have only values "
            "from the set {0, 1, 2, 3, 4, 5, 6, 7}");
      }
    }

    _permutationRule = Uint8List.fromList(permutationRule);
  }


  ///Make bits permutation within byte of data
  ///Watch out passing values outside range [0; 255]
  int encrypt(int plaintextByte) {
    if((plaintextByte < 0) || (plaintextByte > 255)) {
      throw ArgumentError("PBox: the input must be in range [0; 255]");
    }
    int mask = 0x80, ciphertext = 0;

    for(int i = 0; mask != 0; i++, mask = mask >> 1) {
      int shift = (_permutationRule[i] - i) % 8;
      if(shift < 0) {
        shift += 8;
      }

      ciphertext |= (((plaintextByte & mask) >> shift) |
        ((plaintextByte & mask) << (8 - shift))) &
        0xff;
    }

    return ciphertext;
  }
}