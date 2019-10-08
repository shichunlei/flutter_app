import 'package:flutter_app/mvp/data/crypto.dart';
import 'package:flutter_app/mvp/data/crypto_repository_impl.dart';

abstract class CryptoListViewContract {
  void onLoadCryptoComplete(List<Crypto> items);

  void onLoadCryptoError();
}

abstract class CryptoPresenterContract {
  void loadCurrencies();
}

class CryptoListPresenter implements CryptoPresenterContract {
  CryptoListViewContract _view;
  CryptoRepository _repository;

  CryptoListPresenter(this._view) {
    _repository = ProdCryptoRepository();
  }

  @override
  void loadCurrencies() {
    assert(_view != null);
    _repository
        .fetchCurrencies()
        .then((c) => _view.onLoadCryptoComplete(c))
        .catchError((onError) => _view.onLoadCryptoError());
  }
}
