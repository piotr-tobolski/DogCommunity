import UIKit

protocol AddPhotoViewControllerDelegate: class {
    func addPhotoViewController(_ addPhotoViewController: AddPhotoViewController, didFinishWithError: Bool)
}

class AddPhotoViewController: UIViewController {
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var nameTextField: UITextField!
    @IBOutlet private var ownerTextField: UITextField!

    var viewModel: AddPhotoViewModel!

    weak var delegate: AddPhotoViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = viewModel.image

        let nameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 25, height: 20))
        nameLabel.text = "🐶"
        nameTextField.leftView = nameLabel
        nameTextField.leftViewMode = .always

        let ownerLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 25, height: 20))
        ownerLabel.text = "🧑"
        ownerTextField.leftView = ownerLabel
        ownerTextField.leftViewMode = .always
    }

    // MARK: IBActions

    @IBAction func cancelBarButtonItemAction() {
        self.delegate?.addPhotoViewController(self, didFinishWithError: false)
    }

    @IBAction func doneBarButtonItemAction() {
        viewModel.addImage(title: nameTextField.text, owner: ownerTextField.text) { success in
            self.delegate?.addPhotoViewController(self, didFinishWithError: !success)
        }
    }
}
