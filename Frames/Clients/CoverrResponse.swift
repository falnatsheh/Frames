import Foundation

struct CoverrResponse: Codable {
    let hits: [Hit]
}

struct Hit: Codable {
    let id: String
    let title: String
    let urls: Urls
}

struct Urls: Codable {
    let mp4: String
}
