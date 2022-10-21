//
//  Manager.swift
//  WeatherRx
//
//  Created by Артур Фомин on 05.10.2022.
//

import Foundation
import CoreLocation

class Manager {
    
    static let shared = Manager()
    
    private let weatherURL = "https://api.openweathermap.org/data/2.5/weather?units=metric&appid=ba169537ae099c61e91472da1dedf794"
    
    private init(){}
    
    func fetchWeather(cityName: String, completion: @escaping (WeatherModel)->Void) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        
        performRequest(with: urlString) { model in
            completion(model)
        }
        
    }
    
    func performRequest(with urlString: String, completion: @escaping (WeatherModel)->Void) {
        
        guard let url  = URL(string: urlString) else { return }
        var reguest = URLRequest(url: url)
        reguest.httpMethod = "GET"
        let model = WeatherModel(cityName: "", temperature: 0.0, humidity: 0)
        let task = URLSession.shared.dataTask(with: reguest) {data, response, error in
            
            if error == nil , let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                        if let name = json["name"] as? String {
                            model.cityName = name
                        }
                        guard let main = json["main"] as? [String: Any] else { return }
                        if let temperature = main["temp"] as? Double {
                            model.temperature = temperature
                        }
                        if let humidity = main["humidity"] as? Int {
                            model.humidity = humidity
                        }
                    }
                } catch let error {
                    print(error)
                }
            }
            completion(model)
        }
        task.resume()
    }
}
