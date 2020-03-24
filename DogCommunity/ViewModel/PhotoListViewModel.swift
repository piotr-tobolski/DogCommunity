import Foundation

protocol PhotoListViewModelDelegate: class {
    func viewModelDidChangeStateTo(_ viewState: PhotoListViewModel.ViewState)
}

class PhotoListViewModel {
    enum ViewState {
        case `init`, loading, empty, ready
    }

    private(set) var photos = [Photo]()
    private var viewState = ViewState.`init` {
        didSet {
            self.delegate?.viewModelDidChangeStateTo(viewState)
        }
    }

    weak var delegate: PhotoListViewModelDelegate? {
        didSet {
            self.delegate?.viewModelDidChangeStateTo(viewState)
        }
    }

    private var feedDownloader: FeedDownloader

    init(feedDownloader: FeedDownloader = FeedDownloader()) {
        self.feedDownloader = feedDownloader
    }

    var numberOfItems: Int {
        return photos.count
    }

    func load() {
        viewState = .loading

        DispatchQueue.global(qos: .userInitiated).async {
            self.photos = self.feedDownloader.downloadFeed()
            self.viewState = self.photos.isEmpty ? .empty : .ready
        }
    }
}
