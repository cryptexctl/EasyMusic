//
//  ContentView.swift
//  EasyMusic
//
//  Created by Platon on 08.12.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var appSettings = AppSettings()

    var body: some View {
        NavigationView {
            VStack {
                if appSettings.useNewDesign {
                    NewDesignView()
                } else {
                    ClassicDesignView()
                }
            }
            .navigationTitle("EasyMusic")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: SettingsView(appSettings: appSettings)) {
                        Image(systemName: "gearshape")
                            .imageScale(.large)
                            .foregroundColor(.blue)
                    }
                }
            }
        }
    }
}
