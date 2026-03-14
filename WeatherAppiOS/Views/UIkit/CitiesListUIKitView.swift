//
//  CitiesListUIKitView.swift
//  WeatherAppiOS
//
//  Created by Fawaz Tarar on 10/03/2026.
//

import Foundation
import SwiftUI

struct CitiesListUIKitView: UIViewControllerRepresentable {

    let vm: CitiesListVM
    let container: AppContainer
    @Environment(\.modelContext) private var context

    func makeUIViewController(context: Context) -> UIViewController {
        
        let cityService = SavedCityService(context: self.context)
        
        let vc = CitiesListViewController(
            vm: vm,
            context: self.context,
            container: container,
            cityService: cityService
        )
        return UINavigationController(rootViewController: vc)
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

