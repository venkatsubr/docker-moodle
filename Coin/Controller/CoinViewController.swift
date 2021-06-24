
//
//  CoinViewController.swift
//  Coin
//
//  Created by admin on 18.04.2022.
//

import UIKit

class CoinViewController: UIViewController {

    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!

    var coinManager = CoinManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        coinManager.delegate = self
        currencyPicker.delegate = self
        currencyPicker.dataSource = self

    }
}

//MARK: - UIPickerViewDataSource

extension CoinViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
}

//MARK: - UIPickerViewDelegate

extension CoinViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = coinManager.currencyArray[row]
        currencyLabel.text = selectedCurrency
        coinManager.getCoinPrice(for: selectedCurrency)
    }
}

//MARK: - CoinManagerDelegate

extension CoinViewController: CoinManagerDelegate {
    func didUpdatePrice(currensy: String, coinPrice: String) {
        DispatchQueue.main.async {
            self.bitcoinLabel.text = coinPrice
            self.currencyLabel.text = currensy
        }
    }

    func didFailWithError(error: Error) {
        print(error)
    }
}
