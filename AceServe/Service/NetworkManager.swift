//
//  NetworkManager.swift
//  AceServe
//
//  Created by D K on 23.09.2024.
//

import Foundation

enum URLS: String {
    case news = "https://api.jsonserve.com/5AK5i8"
    case clubs = "https://api.jsonserve.com/YtJurd"
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init(){}
    
    func loadNews() async throws -> [News] {
        guard let url = URL(string: URLS.news.rawValue) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let news = try JSONDecoder().decode([News].self, from: data)
        return news
    }
 
    func loadClubs() async throws -> [Club] {
        guard let url = URL(string: URLS.clubs.rawValue) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let news = try JSONDecoder().decode([Club].self, from: data)
        return news
    }
}
