//
//  SightseeingMapApp.swift
//  SightseeingMap
//
//  Created by Майлс on 02.01.2022.
//

import SwiftUI

@main
struct SightseeingMapApp: App {
    
    @StateObject private var locationsViewModel = LocationsViewModel()
    
    var body: some Scene {
        WindowGroup {
            LocationsView().environmentObject(locationsViewModel)
        }
    }
}
