//
//  LocationsListView.swift
//  SightseeingMap
//
//  Created by Майлс on 02.01.2022.
//

import SwiftUI

struct LocationsListView: View {
    
    @EnvironmentObject private var locationViewModel: LocationsViewModel
    
    var body: some View {
        List {
            ForEach(locationViewModel.locations) { location in
                Button(action: {
                    locationViewModel.showNextLocation(location: location)
                }) {
                    listRowView(location: location)
                }
                    .padding(.vertical, 4)
                    .listRowBackground(Color.clear)
            }
        }
        .listStyle(PlainListStyle())
    }
}

//MARK: - EXTENSION
//Methods
extension LocationsListView {
    private func listRowView(location: Location) -> some View {
        HStack {
            if let imageName = location.imageNames.first {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 45, height: 45)
                    .cornerRadius(10)
            }
            VStack(alignment: .leading) {
                Text(location.name)
                    .font(.headline)
                Text(location.cityName)
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

//MARK: - PREVIEW
struct LocationsListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsListView()
            .environmentObject(LocationsViewModel())
    }
}
