import Foundation

struct Photo: Equatable {
    let URL: URL

    let title: String?
    let author: String?
    let aspectRatio: Float?
}
