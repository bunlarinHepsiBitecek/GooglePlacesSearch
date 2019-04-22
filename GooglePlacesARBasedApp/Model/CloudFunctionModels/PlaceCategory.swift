//
//  PlaceCategory.swift
//  GooglePlacesARBasedApp
//
//  Created by Erkut Baş on 4/21/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import Foundation

class PlaceCategory: Codable {
    let response: Response
    let resultData: ResultData
    
    init(response: Response, resultData: ResultData) {
        self.response = response
        self.resultData = resultData
    }
}

class Response: Codable {
    let errorCode: Int
    let errorMessage: String
    
    init(errorCode: Int, errorMessage: String) {
        self.errorCode = errorCode
        self.errorMessage = errorMessage
    }
}

class ResultData: Codable {
    let foodAndDrink: FoodAndDrink
    let services: Services
    let shopping: Shopping
    let thingsToDo: ThingsToDo
    
    init(foodAndDrink: FoodAndDrink, services: Services, shopping: Shopping, thingsToDo: ThingsToDo) {
        self.foodAndDrink = foodAndDrink
        self.services = services
        self.shopping = shopping
        self.thingsToDo = thingsToDo
    }
}

class Mapper: Codable {
    let type: [String]
    let imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case type
        case imageURL = "imageUrl"
    }
    
    init(type: [String], imageURL: String) {
        self.type = type
        self.imageURL = imageURL
    }
}

class FoodAndDrink: Codable {
    let coffee, restaurants, bars, delivery: Mapper
    
    init(coffee: Mapper, restaurants: Mapper, bars: Mapper, delivery: Mapper) {
        self.coffee = coffee
        self.restaurants = restaurants
        self.bars = bars
        self.delivery = delivery
    }
}

class Services: Codable {
    let pharmacies, dryCleaning, gas, hospitalsClinics, carRental, electricVehicleCharging, atms, hotels, beautySalons, mailShipping, libraries, carWash, parking: Mapper
    
    init(pharmacies: Mapper, dryCleaning: Mapper, gas: Mapper, hospitalsClinics: Mapper, carRental: Mapper, electricVehicleCharging: Mapper, atms: Mapper, hotels: Mapper, beautySalons: Mapper, mailShipping: Mapper, libraries: Mapper, carWash: Mapper, parking: Mapper) {
        
        self.pharmacies = pharmacies
        self.dryCleaning = dryCleaning
        self.gas = gas
        self.hospitalsClinics = hospitalsClinics
        self.carRental = carRental
        self.electricVehicleCharging = electricVehicleCharging
        self.atms = atms
        self.hotels = hotels
        self.beautySalons = beautySalons
        self.mailShipping = mailShipping
        self.libraries = libraries
        self.carWash = carWash
        self.parking = parking
    }
}

class Shopping: Codable {
    let electronics, groceries, carDealers, shoppingCenters, apparel, sportingGoods, homeGarden, convenienceStore, beautySupplies: Mapper
    
    init(electronics: Mapper, groceries: Mapper, carDealers: Mapper, shoppingCenters: Mapper, apparel: Mapper, sportingGoods: Mapper, homeGarden: Mapper, convenienceStore: Mapper, beautySupplies: Mapper) {
        self.electronics = electronics
        self.groceries = groceries
        self.carDealers = carDealers
        self.shoppingCenters = shoppingCenters
        self.apparel = apparel
        self.sportingGoods = sportingGoods
        self.homeGarden = homeGarden
        self.convenienceStore = convenienceStore
        self.beautySupplies = beautySupplies
    }
}

class ThingsToDo: Codable {
    let attractions, movies, libraries, art, museums, liveMusic, nightLife, parks, gyms: Mapper
    
    init(attractions: Mapper, movies: Mapper, libraries: Mapper, art: Mapper, museums: Mapper, liveMusic: Mapper, nightLife: Mapper, parks: Mapper, gyms: Mapper) {
        self.attractions = attractions
        self.movies = movies
        self.libraries = libraries
        self.art = art
        self.museums = museums
        self.liveMusic = liveMusic
        self.nightLife = nightLife
        self.parks = parks
        self.gyms = gyms
    }
}
