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
    var del