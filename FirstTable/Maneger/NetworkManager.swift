//
//  NetworkManager.swift
//  FirstTable
//
//  Created by Harapriya on 08/06/23.
//

import Foundation

final class NetworkManager {
    
    static let cityUrl = "http://35.154.63.24:8080/app-api/v1/city-list"
    static let localityUrl = "http://35.154.63.24:8080/app-api/v1/locality-list?city_id="
    
    
    class func getCityList(completion: @escaping (CityResponse) -> Void) {
        var request = URLRequest(url: URL(string: NetworkManager.cityUrl)!, timeoutInterval: 20)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            do {
                let decoder = JSONDecoder()
                let cityList = try decoder.decode(CityResponse.self, from: data)
                completion(cityList)
            } catch {
                print("Error parsing city list: \(error)")
            }
        }
        task.resume()
    }
    
    class func getLocalityList(cityId: Int, completion: @escaping (LocalityResponse) -> Void) {
        var request = URLRequest(url: URL(string: NetworkManager.localityUrl + "\(cityId)")!, timeoutInterval: 20)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            do {
                let decoder = JSONDecoder()
                let localityList = try decoder.decode(LocalityResponse.self, from: data)
                completion(localityList)
            } catch {
                print("Error parsing city list: \(error)")
            }
        }
        task.resume()
    }
}
