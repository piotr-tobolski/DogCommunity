import UIKit
import Vision

class AddPhotoViewModel {
    private let feedDownloader: FeedDownloader
    let image: UIImage

    init(image: UIImage, feedDownloader: FeedDownloader = FeedDownloader()) {
        self.image = image
        self.feedDownloader = feedDownloader
    }

    func addImage(title: String?, owner: String?, completion: @escaping (Bool) -> Void) {
        verifyPhoto { valid in
            if valid, let photo = self.createPhoto(title: title, author: owner) {
                self.feedDownloader.photos.insert(photo, at: 0)
                completion(true)
            } else {
                completion(false)
            }
        }
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

    private func verifyPhoto(_ completion: @escaping (Bool) -> Void) {
        DispatchQueue.global().async {
            do {
                let model = try VNCoreMLModel(for: CatOrDog().model)
                let request = VNCoreMLRequest(model: model)

                let handler = VNImageRequestHandler(cgImage: self.image.cgImage!)
                try handler.perform([request])

                if let classification = request.results?.first as? VNClassificationObservation,
                    classification.identifier == "Dog" {
                    DispatchQueue.main.async { completion(true) }
                } else {
                    throw NSError(domain: "dogcommunity.photo.cat", code: 0)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(false)
                }
            }
        }
    }
}
