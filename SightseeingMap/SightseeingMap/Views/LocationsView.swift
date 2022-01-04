//
//  LocationsView.swift
//  SightseeingMap
//
//  Created by Майлс on 02.01.2022.
//

import SwiftUI
import MapKit

struct LocationsView: View {
    
    @EnvironmentObject private var locationsViewModel: LocationsViewModel
    let maxWidthForIpad: CGFloat = 700
    
    var body: some View {
        ZStack {
            map
            VStack(spacing: 0) {
                header
                Spacer()
                locationPreview
            }
        }
        .sheet(item: $locationsViewModel.showLocationDetails, onDismiss: nil) { location in
            LocationDetailsView(location: location)
        }
    }
}

extension LocationsView {
    //VIEWS
    private var map: some View {
        Map(coordinateRegion: $locationsViewModel.mapRegion,
            annotationItems: locationsViewModel.locations,
            annotationContent: { location in
            MapAnnotation(coordinate: location.coordinates) {
                LocationMapAnnotationView()
                    .scaleEffect(locationsViewModel.mapLocation == location ? 1 : 0.7)
                    .onTapGesture {
                        locationsViewModel.showNextLocation(location: location)
                    }
            }
        })
            .ignoresSafeArea()
    }
    private var header: some View {
        VStack {
            Button(action: locationsViewModel.toggleLocationList) {
                headerButton
            }
            if locationsViewModel.showListOfLocations {
                LocationsListView()
            }
        }
        .frame(maxWidth: maxWidthForIpad)
        .background(.thickMaterial)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 15)
        .padding()
    }
    private var headerButton: some View {
        Text(locationsViewModel.mapLocation.name + ", " + locationsViewModel.mapLocation.cityName)
            .font(.title2)
            .fontWeight(.black)
            .foregroundColor(.primary)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .animation(.none, value: locationsViewModel.mapLocation)
            .overlay(alignment: .leading) {
                Image(systemName: "arrow.down")
                    .font(.headline)
                    .foregroundColor(.primary)
                    .padding()
                    .rotationEffect(Angle(degrees: locationsViewModel.showListOfLocations ? 180 : 0))
            }
    }
    private var locationPreview: some View {
        ZStack {
            ForEach(locationsViewModel.locations) { location in
                if locationsViewModel.mapLocation == location {
                    LocationPreviewView(location: location)
                        .padding()
                        .shadow(color: .black.opacity(0.3), radius: 20)
                        .frame(maxWidth: maxWidthForIpad)
                        .frame(maxWidth: .infinity)
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .leading)))
                }
            }
        }
    }
}

//MARK: - PREVIEW
struct LocationsView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsView()
            .environmentObject(LocationsViewModel())
    }
}
