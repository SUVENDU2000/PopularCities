//
//  CityModel.swift
//  FirstTable
//
//  Created by Harapriya on 08/06/23.
//

import Foundation

struct CityResponse: Codable {
    let code: Int
    let success: Bool
    let response: CityResult
}

// MARK: - Response
struct CityResult: Codable {
    let data: [CityList]?
}

// MARK: - Datum
struct CityList: Codable {
    let cityID: Int
    let cityName: String
    let cityImg: String

    enum CodingKeys: String, CodingKey {
        case cityID = "city_id"
        case cityName = "city_name"
        case cityImg = "city_img"
    }
}
