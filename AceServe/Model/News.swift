//
//  News.swift
//  AceServe
//
//  Created by D K on 23.09.2024.
//

import Foundation


class News: Codable {
    
    let title: String
    let body: String
    let image: String
    
    init(title: String, body: String, image: String) {
        self.title = title
        self.body = body
        self.image = image
    }
}

extension News {
    static func MOCK() -> News {
        return News(title: "Summer Tennis Tournament Announced", body: "Our annual summer tennis tournament is back, and it's bigger than ever! Scheduled to take place from October 15-20, this event promises intense competition, great prizes, and an opportunity to showcase your skills. Whether you're a seasoned player or new to the game, we encourage you to participate and enjoy the electrifying atmosphere. Spectators are welcome, and there will be food and drinks available throughout the event. Don’t miss your chance to be a part of one of the biggest tennis events of the year! Register now to secure your spot.", image: "https://i.ibb.co/sjTxLhT/1.webp")
    }
}
