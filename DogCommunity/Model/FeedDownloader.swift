import Foundation

fileprivate func url(of photoName: String) -> URL {
    return Bundle.main.url(forResource: photoName, withExtension: "jpg", subdirectory: "photos")!
}

class FeedDownloader {
    var photos: [Photo] = [
        Photo(URL: url(of: "dog.0"),
              title: "Bella",
              author: "Oliver",
              aspectRatio: 1.33),
        Photo(URL: url(of: "dog.1"),
              title: "Bailey",
              author: "George",
              aspectRatio: 0.65),
        Photo(URL: url(of: "dog.2"),
              title: "Lucy",
              author: "Chloe",
              aspectRatio: 0.93),
        Photo(URL: url(of: "dog.3"),
              title: "Max",
              author: "Jack",
              aspectRatio: 1.33),
        Photo(URL: url(of: "dog.4"),
              title: "Molly",
              author: "Jacob",
              aspectRatio: 1.04),
        Photo(URL: url(of: "dog.5"),
              title: "Buddy",
              author: "Emily",
              aspectRatio: 1.32),
        Photo(URL: url(of: "dog.6"),
              title: "Daisy",
              author: "Charlie",
              aspectRatio: 1.02),
        Photo(URL: url(of: "dog.7"),
              title: "Rocky",
              author: "Megan",
              aspectRatio: 1.13),
        Photo(URL: url(of: "dog.8"),
              title: "Maggie",
              author: "Jessica",
              aspectRatio: 0.93),
        Photo(URL: url(of: "dog.9"),
              title: "Jake",
              author: "Harry",
              aspectRatio: 0.73),
    ]

    init() {
    }

    func downloadFeed() -> [Photo] {
        return photos
    }
}
