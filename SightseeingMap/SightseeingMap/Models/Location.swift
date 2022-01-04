//
//  Location.swift
//  SightseeingMap
//
//  Created by Майлс on 02.01.2022.
//

import Foundation
import MapKit

///Модель структуры, содержит в себе данные о точке координат.
struct Location: Identifiable, Equatable {
    let name: String
    let cityName: String
    let coordinates: CLLocationCoordinate2D
    let description: String
    let imageNames: [String]
    let link: String
    
    var id: String {
        //name = "Colloseum"
        //cityName = "Rome"
        //id = "ColloseumRome"
        name + cityName
    }
    
    ///Проверка "одинаковости" экземпляров
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}
