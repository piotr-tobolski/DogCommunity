import Quick
import Nimble
@testable import DogCommunity

class AppCoordinatorSpec: QuickSpec {

    class MockUINavigationController: UINavigationController {
        var passedViewController: UIViewController?
        var passedAnimatedParam: Bool?

        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            passedViewController = viewController
            passedAnimatedParam = animated
        }
    }

    class MockUIStoryboard: UIStoryboard {
        var viewController: UIViewController!
        private(set) var passedIdentifier: String?

        override func instantiateViewController(withIdentifier identifier: String) -> UIViewController {
            passedIdentifier = identifier
            return viewController
        }
    }

    class MockPhotoListViewController: PhotoListViewController {
        var storyboardOverride: UIStoryboard?
        override var storyboard: UIStoryboard? {
            return storyboardOverride
        }
    }

    override func spec() {
        var mockNavigationController: MockUINavigationController!
        var mockPhotoListViewController: MockPhotoListViewController!
        var sut: AppCoordinator!

        beforeEach {
            mockNavigationController = MockUINavigationController()
            mockPhotoListViewController = MockPhotoListViewController()
            mockNavigationController.viewControllers = [mockPhotoListViewController]
            sut = AppCoordinator(navigationController: mockNavigationController)
        }

        describe("starting the app") {
            beforeEach {
                sut.start()
            }

            it("sets the photo list view controller view model") {
                expect(mockPhotoListViewController.viewModel).to(beAKindOf(PhotoListViewModel.self))
            }

            it("sets itself as an delegate of the photo list view controller") {
                expect(mockPhotoListViewController.delegate).to(beIdenticalTo(sut))
            }
        }

        describe("PhotoListViewControllerDelegate") {
            it("implements this protocol") {
                expect(sut).to(beAKindOf(PhotoListViewControllerDelegate.self))
            }

            describe("photoListViewControllerDidSelect(_:)") {
                var photo: Photo!
                var mockStoryboard: MockUIStoryboard!
                var photoViewController: PhotoViewController!

                beforeEach {
                    photo = Photo(URL: URL(string: "https://google.com")!, title: nil, author: nil, aspectRatio: nil)
                    mockStoryboard = MockUIStoryboard()
                    photoViewController = PhotoViewController()

                    mockPhotoListViewController.storyboardOverride = mockStoryboard
                    mockStoryboard.viewController = photoViewController

                    sut.photoListViewControllerDidSelect(photo)

                }

                it("pushes correct view controller") {
                    expect(mockNavigationController.passedViewController).to(beIdenticalTo(photoViewController))
                }

                it("makes the push with animation") {
                    expect(mockNavigationController.passedAnimatedParam).to(beTruthy())
                }

                it("instantiates view controller with correct identifier") {
                    expect(mockStoryboard.passedIdentifier).to(equal("PhotoViewController"))
                }

                it("sets the photo on the view controller") {
                    expect(photoViewController.photo).to(equal(photo))
                }
            }
        }
        
    }
}

