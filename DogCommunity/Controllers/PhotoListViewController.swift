import UIKit
import CHTCollectionViewWaterfallLayout

private let cellNibName = "PhotoListCollectionViewCell"

protocol PhotoListViewControllerDelegate: class {
    func photoListViewControllerDidSelect(_ photo: Photo)
}

class PhotoListViewController: UIViewController, UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout, PhotoListViewModelDelegate {
    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet private var emptyView: UIView!
    @IBOutlet private var refreshControl: UIRefreshControl!

    var viewModel: PhotoListViewModel!
    weak var delegate: PhotoListViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        let layout = CHTCollectionViewWaterfallLayout()
        layout.columnCount = columnCount
        layout.minimumColumnSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collectionView.collectionViewLayout = layout
        collectionView.register(UINib(nibName: cellNibName, bundle: nil), forCellWithReuseIdentifier: cellNibName)
        collectionView.refreshControl = refreshControl

        viewModel.delegate = self
        viewModel.load()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if let layout = self.collectionView.collectionViewLayout as? CHTCollectionViewWaterfallLayout {
            layout.columnCount = columnCount
        }
    }

    private var columnCount: Int {
        if self.traitCollection.horizontalSizeClass == .regular {
            return 3
        } else if self.traitCollection.verticalSizeClass == .compact {
            return 4
        }
        
        return 2
    }

    @IBAction private func refreshControlValueChanged() {
        viewModel.load()
    }

    // MARK: UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellNibName, for: indexPath) as! PhotoListCollectionViewCell
        let photo = viewModel.photos[indexPath.row]

        cell.configure(with: photo)

        return cell
    }

    // MARK: UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = viewModel.photos[indexPath.row]
        self.delegate?.photoListViewControllerDidSelect(photo)
    }

    // MARK: CHTCollectionViewDelegateWaterfallLayout

    func collectionView(_ collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, sizeForItemAt indexPath: IndexPath!) -> CGSize {
        let photo = viewModel.photos[indexPath.row]
        guard let aspectRatio = photo.aspectRatio else {
            return .zero
        }

        return CGSize(width: CGFloat(aspectRatio), height: 1)
    }

    // MARK: PhotoListViewModelDelegate

    func viewModelDidChangeStateTo(_ viewState: PhotoListViewModel.ViewState) {
        DispatchQueue.main.async {
            switch viewState {
            case .`init`:
                self.emptyView.isHidden = true
                self.refreshControl.makeSureIsNotRefreshing()
            case .loading:
                self.emptyView.isHidden = true
                self.refreshControl.makeSureIsRefreshing()
            case .empty:
                self.emptyView.isHidden = false
                self.refreshControl.makeSureIsNotRefreshing()
            case .ready:
                self.emptyView.isHidden = true
                self.collectionView.reloadData()
                self.refreshControl.makeSureIsNotRefreshing()
            }
        }
    }
}

