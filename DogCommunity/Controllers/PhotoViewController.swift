import UIKit
import AlamofireImage

class PhotoViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!

    var photo: Photo!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = photo.title
        imageView.af.setImage(withURL: photo.URL)
    }
}
