//
//  Club.swift
//  AceServe
//
//  Created by D K on 24.09.2024.
//

import Foundation

class Club: Codable {
    
    let name: String
    let address: String
    let courts: String
    let time: String
    let image: String
    
    init(name: String, address: String, courts: String, time: String, image: String) {
        self.name = name
        self.address = address
        self.courts = courts
        self.time = time
        self.image = image
    }
}

extension Club {
    static func MOCK() -> Club {
        return Club(name: "Plinetko I", address: "19 Devonshire Rd, Sutton SM2 5HH", courts: "12", time: "07:00-23:00", image: "https://i.ibb.co/5G58Y3B/2.png")
    }
}
