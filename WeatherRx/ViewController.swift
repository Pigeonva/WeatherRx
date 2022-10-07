//
//  ViewController.swift
//  WeatherRx
//
//  Created by Артур Фомин on 05.10.2022.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    
    
    //MARK: - let/var
    
    var viewModel = ViewModel()
    var disposeBag = DisposeBag()
    
    //MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.setup(city: "kazan")
        
        viewModel.weather
            .subscribe { model in
                DispatchQueue.main.async {
                    if let temp = model.element?.temperature, let hum = model.element?.humidity {
                        self.cityNameLabel.text = model.element?.cityName
                        self.temperatureLabel.text = String(describing: temp)
                        self.humidityLabel.text = String(describing: hum)
                    }
                }
            }.disposed(by: disposeBag)
        
        searchButton.rx
            .tap
            .subscribe { _ in
                self.viewModel.setup(city: self.textField.text)
            }.disposed(by: disposeBag)
        
        refreshButton.rx
            .tap
            .subscribe { _ in
                self.viewModel.setup(city: self.textField.text)
            }.disposed(by: disposeBag)
            
    }
}

