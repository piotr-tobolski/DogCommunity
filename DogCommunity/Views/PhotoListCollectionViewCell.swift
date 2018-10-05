import UIKit
import AlamofireImage
import FontAwesome_swift

class PhotoListCollectionViewCell: UICollectionViewCell {
    private static var placeholderImage = UIImage.fontAwesomeIcon(name: .image, style: .solid, textColor: .lightGray, size: CGSize(width: 100, height: 100))
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var placeholderImageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var authorLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        placeholderImageView.image = PhotoListCollectionViewCell.placeholderImage
    }

    override func prepareForReuse() {
        placeholderImageView.alpha = 1
        imageView.image = nil
        titleLabel.text = nil
        authorLabel.text = nil
    }

    func configure(with photo: Photo) {
        titleLabel.text = photo.title
        authorLabel.text = photo.author.map { "Owner: " + $0 }

        let imageTransition = UIImageView.ImageTransition.custom(duration: 0.5, animationOptions: .transitionCrossDissolve, animations: { imageView, image in
            imageView.image = image
            self.placeholderImageView.alpha = 0
        }, completion: nil)
        self.imageView.af_setImage(withURL: photo.URL, imageTransition: imageTransition) { _ in
            self.placeholderImageView.alpha = 0
        }
    }
}
