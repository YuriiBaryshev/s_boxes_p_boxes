part of s_boxes_p_boxes;

///Implements custom P-box
class PBox {
  Uint8List _permutationRule = Uint8List(8);

  ///Initiates P-box with certain permutation rule, which should be passed as
  ///a list (kind of array in Dart) of new bits positions.
  ///
  ///Therefore there should be exact 8 elements, and each element
  ///must be unique and have values from the set {0, 1, 2, 3, 4, 5, 6, 7}
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
}