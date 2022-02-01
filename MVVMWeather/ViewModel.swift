//
//  ViewModel.swift
//  MVVMWeather
//
//  Created by Анастасия on 01.02.2022.
//

import Foundation

// Data needed by view

class WeatherViewModel: ObservableObject {
	@Published var title: String = "-"
	@Published var descriptionText: String = "-"
	@Published var temp: String = "-"
	@Published var timezone: String = "-"
	
	init() {
		fetchWeather()
	}
	
	func fetchWeather() {
		guard let url = URL(string:
				"""
				https://api.openweathermap.org/data/2.5/onecall?exclude=hourly,daily,minutely&lat=55.751244&lon=37.618423&units=imperial&appid=a25ffc3abde70c25f3d7f331151a9e3f
				"""
		) else {
			return
		}
		
		let task = URLSession.shared.dataTask(with: url) { data, _, error in
			guard let data = data, error == nil else {
				return
			}
			
			// Convert data to Model
			
			do {
				let model = try JSONDecoder().decode(WeatherModel.self,
													 from: data)
				DispatchQueue.main.async {
					self.title = model.current.weather.first?.main ?? "No Title"
					self.descriptionText = model.current.weather.first?.description ?? "No Description"
					self.temp = "\(Int((model.current.temp - 32) * 5.0/9.0))°"
					self.timezone = model.timezone
				}
			}
			catch {
				print("failed")
			}
		}
		task.resume()
	}
}

/*
https://api.openweathermap.org/data/2.5/onecall?exclude=hourly,daily,minutely&lat=40.7128&lon=-74&units=imperial&appid=a25ffc3abde70c25f3d7f331151a9e3f
*/
