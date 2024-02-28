import 'preorder_enum.dart';

/*
T: Teslim edildi
E: İkram yok
M: Misafir yok
H: Hasarlı
*/

String findDbPreorderStatusCode(PreorderStatus preorderStatus) {
  if (preorderStatus == PreorderStatus.delivered) {
    return "T";
  } else if (preorderStatus == PreorderStatus.noCatering) {
    return "E";
  } else if (preorderStatus == PreorderStatus.damaged) {
    return "H";
  } else if (preorderStatus == PreorderStatus.noGuess) {
    return "M";
  } else {
    return "S";
  }
}

PreorderStatus findPreorderStatusByCode(String preorderStatusCode) {
  if (preorderStatusCode.contains("T")) {
    return PreorderStatus.delivered;
  } else if (preorderStatusCode.contains("E")) {
    return PreorderStatus.noCatering;
  } else if (preorderStatusCode.contains("H")) {
    return PreorderStatus.damaged;
  } else if (preorderStatusCode.contains("M")) {
    return PreorderStatus.noGuess;
  } else {
    return PreorderStatus.nonSelected;
  }
}

String findPreorderStatus(PreorderStatus? status) {
  if (status == null) {
    return 'Belirtilmedi';
  } else if (status == PreorderStatus.delivered) {
    return 'Teslim Edildi';
  } else if (status == PreorderStatus.noCatering) {
    return 'İkram Yok';
  } else if (status == PreorderStatus.noGuess) {
    return 'Misafir Yok';
  } else if (status == PreorderStatus.damaged) {
    return 'Hasarlı';
  } else {
    return "";
  }
}
