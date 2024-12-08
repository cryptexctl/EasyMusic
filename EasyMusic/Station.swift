//
//  Station.swift
//  EasyMusic
//
//  Created by Platon on 08.12.2024.
//


import SwiftUI

struct Station: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let streamURL: String
    let color: LinearGradient
}
