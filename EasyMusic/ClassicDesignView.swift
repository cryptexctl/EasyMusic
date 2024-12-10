//
//  ClassicDesignView.swift
//  EasyMusic
//
//  Created by Platon on 10.12.2024.
//

import SwiftUI

struct ClassicDesignView: View {
    var body: some View {
        List(stations, id: \.name) { station in
            NavigationLink(destination: RadioPlayer(station: station)) {
                HStack {
                    Circle()
                        .fill(LinearGradient(
                            gradient: Gradient(colors: station.colors),
                            startPoint: .top,
                            endPoint: .bottom
                        ))
                        .frame(width: 50, height: 50)

                    VStack(alignment: .leading) {
                        Text(station.name)
                            .font(.headline)
                        Text(station.description)
                            .font(.subheadline)
                            .lineLimit(2)
                    }
                }
            }
        }
        .navigationTitle("Каналы")
    }
}
