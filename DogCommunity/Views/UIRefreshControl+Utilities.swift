import UIKit

extension UIRefreshControl {
    func makeSureIsRefreshing() {
        if !isRefreshing {
            beginRefreshing()
        }
    }

    func makeSureIsNotRefreshing() {
        if isRefreshing {
            endRefreshing()
        }
    }
}
