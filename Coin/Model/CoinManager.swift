//
//  CoinManager.swift
//  Coin
//
//  Created by admin on 18.04.2022.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdatePrice(currensy: String, coinPrice: String)
    func didFailWithError(error:Error)
}

struct CoinManager {

    let baseURL: String
    let apiKey: String
    var delegate: CoinManagerDelegate?

    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    init() {
        self.apiKey = (Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String)!
        self.baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    }
    
    func getCoinPrice(for currency: String) {
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                if let saveData = data {
                    if let coinRate = parseJSON(saveData) {
                        let priceString = String(format: "%.2f", coinRate)
                        delegate?.didUpdatePrice(currensy: currency, coinPrice: priceString)
                    }
                }
            }
            task.resume()
        }
    }

    func parseJSON(_ coinData: Data) -> Double? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: coinData)
            let price = decodedData.rate
            return price
        } catch {
            print(error)
            return nil
        }
    }

}
