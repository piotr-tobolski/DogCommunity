import Foundation

class FeedDownloader {
    private let photos: [Photo] = [
        Photo(URL: URL(string: "https://piotrtobolski.com/dogs/dog.0.jpg")!,
              title: "Bella",
              author: "Oliver",
              aspectRatio: 1.33),
        Photo(URL: URL(string: "https://piotrtobolski.com/dogs/dog.1.jpg")!,
              title: "Bailey",
              author: "George",
              aspectRatio: 0.65),
        Photo(URL: URL(string: "https://piotrtobolski.com/dogs/dog.2.jpg")!,
              title: "Lucy",
              author: "Chloe",
              aspectRatio: 0.93),
        Photo(URL: URL(string: "https://piotrtobolski.com/dogs/dog.3.jpg")!,
              title: "Max",
              author: "Jack",
              aspectRatio: 1.33),
        Photo(URL: URL(string: "https://piotrtobolski.com/dogs/dog.4.jpg")!,
              title: "Molly",
              author: "Jacob",
              aspectRatio: 1.04),
        Photo(URL: URL(string: "https://piotrtobolski.com/dogs/dog.5.jpg")!,
              title: "Buddy",
              author: "Emily",
              aspectRatio: 1.32),
        Photo(URL: URL(string: "https://piotrtobolski.com/dogs/dog.6.jpg")!,
              title: "Daisy",
              author: "Charlie",
              aspectRatio: 1.02),
        Photo(URL: URL(string: "https://piotrtobolski.com/dogs/dog.7.jpg")!,
              title: "Rocky",
              author: "Megan",
              aspectRatio: 1.13),
        Photo(URL: URL(string: "https://piotrtobolski.com/dogs/dog.8.jpg")!,
              title: "Maggie",
              author: "Jessica",
              aspectRatio: 0.93),
        Photo(URL: URL(string: "https://piotrtobolski.com/dogs/dog.9.jpg")!,
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
