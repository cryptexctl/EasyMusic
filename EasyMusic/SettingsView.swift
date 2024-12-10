//
//  SettingsView.swift
//  EasyMusic
//
//  Created by Platon on 10.12.2024.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var appSettings: AppSettings
    @State private var developerClickCount = 0
    @State private var isDeveloperModeEnabled = false

    var body: some View {
        VStack {
            Toggle(isOn: $appSettings.useNewDesign) {
                Text("Использовать новый дизайн")
            }
            .padding()

            Text("Версия: 2.0.0")
                .onTapGesture {
                    developerClickCount += 1
                    if developerClickCount == 7 {
                        isDeveloperModeEnabled = true
                    }
                }
                .padding()

            if isDeveloperModeEnabled {
                Button(action: {
                    fatalError("Краш тест")
                }) {
                    Text("Крашнуть") // The app is fucking die and you have to re-open it several times
                        .foregroundColor(.red)
                }
            }
        }
        .navigationTitle("Настройки")
    }
}
