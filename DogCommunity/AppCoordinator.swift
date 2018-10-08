import Foundation
import UIKit

final class AppCoordinator: NSObject,
    PhotoListViewControllerDelegate,
    AddPhotoViewControllerDelegate,
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate
{
    private weak var navigationController: UINavigationController?
    private weak var photoListViewController: PhotoListViewController?
    private var feedDownloader = FeedDownloader()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.photoListViewController = navigationController.topViewController as? PhotoListViewController
    }

    func start() {
        let photoListViewModel = PhotoListViewModel(feedDownloader: feedDownloader)
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

    func photoListViewControllerDidSelectAddPhoto() {
        let sourceType = UIImagePickerController.SourceType.savedPhotosAlbum
        guard UIImagePickerController.isSourceTypeAvailable(sourceType) else { return }

        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = sourceType
        imagePickerController.delegate = self

        self.navigationController?.present(imagePickerController, animated: true)
    }

    // MARK: AddPhotoViewControllerDelegate

    func addPhotoViewControllerDidFinish(addPhotoViewController: AddPhotoViewController) {
        self.navigationController?.dismiss(animated: true)
        self.photoListViewController?.reloadData()
    }

    // MARK: UIImagePickerControllerDelegate

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }

        self.navigationController?.dismiss(animated: true) {
            let storyboard = self.photoListViewController?.storyboard
            if let addPhotoNavigationViewController = storyboard?.instantiateViewController(withIdentifier: "AddPhotoNavigationViewController") as? UINavigationController,
                let addPhotoViewController = addPhotoNavigationViewController.viewControllers.first as? AddPhotoViewController {
                addPhotoViewController.viewModel = AddPhotoViewModel(image: image, feedDownloader: self.feedDownloader)
                addPhotoViewController.delegate = self
                self.navigationController?.present(addPhotoNavigationViewController, animated: true)
            }
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.navigationController?.dismiss(animated: true)
    }
}
