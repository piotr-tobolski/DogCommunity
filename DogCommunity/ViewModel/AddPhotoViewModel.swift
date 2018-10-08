import UIKit

class AddPhotoViewModel {
    private let feedDownloader: FeedDownloader
    let image: UIImage

    init(image: UIImage, feedDownloader: FeedDownloader = FeedDownloader()) {
        self.image = image
        self.feedDownloader = feedDownloader
    }

    func addImage(title: String?, owner: String?) {
        guard let photo = createPhoto(title: title, author: owner) else { return }
        feedDownloader.photos.insert(photo, at: 0)
    }

    private func createPhoto(title: String?, author: String?) -> Photo? {
        do {
            guard let data = image.pngData() else { return nil }
            let documentDirURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileName = UUID().uuidString
            let fileURL = documentDirURL.appendingPathComponent(fileName).appendingPathExtension("png")
            try data.write(to: fileURL)
            let photo = Photo(URL: fileURL, title: title, author: author, aspectRatio: Float(image.size.width / image.size.height))
            return photo
        } catch {
            print(error)
        }

        return nil
    }
}
