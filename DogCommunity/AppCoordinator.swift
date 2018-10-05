import Foundation
import UIKit

final class AppCoordinator: PhotoListViewControllerDelegate {

    private weak var navigationController: UINavigationController?
    private weak var photoListViewController: PhotoListViewController?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.photoListViewController = navigationController.topViewController as? PhotoListViewController
    }

    func start() {
        let photoListViewModel = PhotoListViewModel()
        self.photoListViewController?.viewModel = photoListViewModel
        self.photoListViewController?.delegate = self
    }

    // MARK: PhotoListViewControllerDelegate

    func photoListViewControllerDidSelect(_ photo: Photo) {
        let storyboard = self.photoListViewController?.storyboard
        if let photoViewController = storyboard?.instantiateViewController(withIdentifier: "PhotoViewController") as? PhotoViewController {
            photoViewController.photo = photo
            self.navigationController?.pushViewController(photoViewController, animated: true)
        }
    }
}
