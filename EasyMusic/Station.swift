//
//  Station.swift
//  EasyMusic
//
//  Created by Platon on 08.12.2024.
//


import SwiftUI

struct Station: Hashable {
    let name: String
    let description: String
    let streamURL: String
    let colors: [Color]
}

let stations: [Station] = [
    Station(
        name: "Tabris FM",
        description: "Радио, на котором крутятся отобранные, нормальные, приятные треки многих жанров. Плейлист пополняется ежедневно в районе от 18:00 до 22:00.",
        streamURL: "https://stream.zeno.fm/uzrnuzqmen6tv",
        colors: [.red, .orange]
    ),
    Station(
        name: "Night FM",
        description: "Радио для концентрации, успокоения, наслаждения. На радио играет спокойная музыка различных исполнителей. Идеально подойдёт для ночных прогулок и поездок.",
        streamURL: "https://stream.zeno.fm/lgxpsux5v9avv",
        colors: [.blue, .cyan]
    ),
    Station(
        name: "Penis FM",
        description: "Радио для тех, кого обычные треки не устраивают, и они слушают альтернативные жанры. На радио играют треки таких исполнителей, как Dekma, Кишлак и т.д.",
        streamURL: "https://stream.zeno.fm/hfrwlmkuux4uv",
        colors: [.blue, .purple]
    ),
    Station(
        name: "Platon FM",
        description: "Музыка всех жанров, характеров и исполнителей. Идеально подойдёт для меломанов.",
        streamURL: "http://45.95.234.91:8000/music",
        colors: [.yellow, .orange]
    ),
    Station(
        name: "Memschol FM",
        description: "Полная сборная солянка от красивых и уникальных жанров до рофл гей ремиксов и блатных треков. Часто проводятся подкасты на разные темы в прямом эфире от простого общения до политики.",
        streamURL: "https://stream.zeno.fm/hydtchh8maguv.m3u",
        colors: [Color(red: 106/255, green: 13/255, blue: 173/255), .purple]
    )
]
