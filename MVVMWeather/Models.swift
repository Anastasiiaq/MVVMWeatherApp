//
//  Models.swift
//  MVVMWeather
//
//  Created by Анастасия on 01.02.2022.
//

import Foundation

// Data

struct WeatherModel: Codable {
	let timezone: String
	let current: CurrentWeather
}

struct CurrentWeather: Codable {
	let temp: Float
	let weather: [WeatherInfo]
}

struct WeatherInfo: Codable {
	let main: String
	let description: String
}
