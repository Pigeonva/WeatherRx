//
//  ViewModel.swift
//  WeatherRx
//
//  Created by Артур Фомин on 05.10.2022.
//

import UIKit
import RxSwift
import RxCocoa

class ViewModel {
    
    var weather = BehaviorRelay<WeatherModel>(value: WeatherModel(cityName: "", temperature: 0.0, humidity: 0))
    
    func setup(city: String?) {
        guard let city = city else { return }
        Manager.shared.fetchWeather(cityName: city) { model in
            self.weather.accept(model)
        }
        
    }
    
}
