import Quick
import Nimble
@testable import DogCommunity

class PhotoListViewModelSpec: QuickSpec {

    class MockPhotoListViewModelDelegate: PhotoListViewModelDelegate {
        private(set) var viewStates: [PhotoListViewModel.ViewState] = []
        func viewModelDidChangeStateTo(_ viewState: PhotoListViewModel.ViewState) {
            self.viewStates.append(viewState)
        }
    }

    class MockFeedDownloader: FeedDownloader {
        override func downloadFeed() -> [Photo] {
            return photos
        }
    }

    override func spec() {
        var mockFeedDownloader: MockFeedDownloader!
        var mockPhotoListViewModelDelegate: MockPhotoListViewModelDelegate!
        var sut: PhotoListViewModel!

        beforeEach {
            mockFeedDownloader = MockFeedDownloader()
            sut = PhotoListViewModel(feedDownloader: mockFeedDownloader)

            mockPhotoListViewModelDelegate = MockPhotoListViewModelDelegate()
            sut.delegate = mockPhotoListViewModelDelegate
        }

        describe("photo loading") {
            context("not started yet") {
                it("has state init") {
                    expect(mockPhotoListViewModelDelegate.viewStates).to(equal([.`init`]))
                }

                it("has no items") {
                    expect(sut.numberOfItems).to(equal(0))
                }

                it("has empty photo list") {
                    expect(sut.photos).to(beEmpty())
                }
            }
            context("no photos loaded") {
                beforeEach {
                    sut.load()
                }

                it("has moved through all states and returned empty results") {
                    expect(mockPhotoListViewModelDelegate.viewStates).toEventually(equal([.`init`, .loading, .empty]))
                    expect(sut.numberOfItems).to(equal(0))
                    expect(sut.photos).to(beEmpty())
                }
            }

            context("some photos loaded") {
                beforeEach {
                    mockFeedDownloader.photos = [Photo(URL: URL(string: "https://google.com")!, title: nil, author: nil, aspectRatio: nil)]
                    sut.load()
                }

                it("has state init") {
                    expect(mockPhotoListViewModelDelegate.viewStates).toEventually(equal([.`init`, .loading, .ready]))
                }

                it("has no items") {
                    expect(sut.numberOfItems).toEventually(equal(1))
                }

                it("has empty photo list") {
                    expect(sut.photos).toEventually(equal(mockFeedDownloader.photos))
                }

            }
        }
    }
}
