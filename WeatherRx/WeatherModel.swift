//
//  WeatherModel.swift
//  WeatherRx
//
//  Created by Артур Фомин on 05.10.2022.
//

import Foundation

class WeatherModel {
    
    var cityName: String
    var temperature: Double
    var humidity: Int
    
    init(cityName: String, temperature: Double, humidity: Int) {
        self.cityName = cityName
        self.temperature = temperature
        self.humidity = humidity
    }
}
