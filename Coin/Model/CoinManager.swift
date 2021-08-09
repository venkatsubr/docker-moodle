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
        self.apiKey = (Bundle.main.object(forInfoDictionaryKey: 