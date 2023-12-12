import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_siparis_projem/data/repo/yemekler_dao_repo.dart';

class DetaysayfaCubit extends Cubit<void>{
  DetaysayfaCubit():super(0);

  var mrepo = YemeklerDaoRepository();

  Future<void> kaydet (String yemek_adi, String yemek_resim_adi,
      int yemek_fiyat, int yemek_siparis_adet,
      String kullanici_adi) async {
    await mrepo.Kaydet(yemek_adi, yemek_resim_adi, yemek_fiyat, yemek_siparis_adet, kullanici_adi);
  }
}