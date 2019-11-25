import Foundation

class CoverrClient {
    private let coverrBaseUrl = "https://coverr.co/api/videos"
    typealias CoverrResult = ([Video], Error?) -> Void
    
    func fetchVideos(completion: @escaping CoverrResult){
        let task = URLSession.shared.dataTask(with: buildRequest()) { (data, response, error) in
            if error != nil { completion([], error) }
            guard let data = data, let coverrVideos = try? JSONDecoder().decode(CoverrResponse.self, from: data) else {
                completion([], error)
                return
            }
            
            var videoList: [Video] = []
            for video in coverrVideos.hits {
                guard let videoUrl = URL(string:video.urls.mp4) else { continue }
                videoList.append(Video(id: video.id, title: video.title, videoUrl: videoUrl))
             }
            completion(videoList, nil)
        }
        task.resume()
    }
    
    private func buildRequest() -> URLRequest {
        var urlComponents = URLComponents(string: coverrBaseUrl)!
        urlComponents.queryItems = [
            URLQueryItem(name: "filters", value: "tags:vertical"),
            URLQueryItem(name: "page_size", value: "30"),
            URLQueryItem(name: "urls", value: "true"),
            URLQueryItem(name: "sort_by", value: "popularity")
        ]
        
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "GET"
        return request
    }
}
