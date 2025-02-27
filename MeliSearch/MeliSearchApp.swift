//
//  MeliSearchApp.swift
//  MeliSearch
//
//  Created by Sebastian Beltran Gonzalez on 27/02/25.
//

import SwiftUI

@main
struct MeliSearchApp: App {
    @StateObject private var appState = AppState()
    var body: some Scene {
        WindowGroup {
            MainView().environmentObject(appState)
        }
    }
}
