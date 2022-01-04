//
//  LocationsViewModel.swift
//  SightseeingMap
//
//  Created by Майлс on 02.01.2022.
//

import MapKit
import SwiftUI

///View Model содержит в себе published массив с локациями для отображения на экране карты
class LocationsViewModel: ObservableObject {
    
    //Все локации
    @Published var locations: [Location]
    
    //Текущее местоположение на карте
    @Published var mapLocation: Location {
        didSet {
            updateMapRegion(location: mapLocation)
        }
    }
    
    //Текущий регион карты
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    //Показывает все локации
    @Published var showListOfLocations: Bool = false
    
    //Показывает подробности об выбранной локации
    @Published var showLocationDetails: Location? = nil
    
    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
        self.updateMapRegion(location: locations.first!)
    }
    
    ///Метод обновления региона карты
    private func updateMapRegion(location: Location) {
        withAnimation(.easeInOut) {
            self.mapRegion = MKCoordinateRegion(center: location.coordinates, span: mapSpan)
        }
    }
    
    ///Метод переключения булевой переменной для открытия листа с локациями
    func toggleLocationList() {
        withAnimation(.easeInOut) {
            showListOfLocations = !showListOfLocations
        }
    }
    
    ///Метод перехода на другую локацию
    func showNextLocation(location: Location) {
        withAnimation(.easeInOut) {
            mapLocation = location
            showListOfLocations = false
        }
    }
    
    ///Метод переключения на следующую локацию
    func nextButtonTapped() {
        
        //Текущий индекс локации
        guard let currentIndex = locations.firstIndex(where: { $0 == mapLocation }) else {
            print("Could not find index in locations array")
            return
        }
        
        //Проверка есть ли следующий индекс
        let nextIndex = currentIndex + 1
        guard locations.indices.contains(nextIndex) else {
            //Если следующего индекса нет, сработает этот блок кода
            guard let firstLocation = locations.first else { return }
            showNextLocation(location: firstLocation)
            return
        }
        
        //Если следующий индекс ксть, сработает этот блок кода
        let nextLocation = locations[nextIndex]
        showNextLocation(location: nextLocation)
    }
}
