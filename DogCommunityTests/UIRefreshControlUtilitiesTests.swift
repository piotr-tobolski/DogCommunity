import Quick
import Nimble
@testable import DogCommunity

class UIRefreshControlUtilitiesSpec: QuickSpec {

    class MockUIRefreshControl: UIRefreshControl {
        private(set) var beginRefreshingCalled = false
        private(set) var endRefreshingCalled = false
        var isRefreshingOverride: Bool = false

        override var isRefreshing: Bool {
            get {
                return isRefreshingOverride
            }
        }

        override func beginRefreshing() {
            beginRefreshingCalled = true
        }

        override func endRefreshing() {
            endRefreshingCalled = true
        }
    }

    override func spec() {
        var sut: MockUIRefreshControl!
        beforeEach {
            sut = MockUIRefreshControl()
        }

        describe("makeSureIsRefreshing") {
            context("refreshing is in progress") {
                beforeEach {
                    sut.isRefreshingOverride = true
                    sut.makeSureIsRefreshing()
                }

                it("doesn't call beginRefreshing") {
                    expect(sut.beginRefreshingCalled).to(beFalsy())
                }

                it("doesn't call endRefreshing") {
                    expect(sut.endRefreshingCalled).to(beFalsy())
                }
            }

            context("refreshing is not in progress") {
                beforeEach {
                    sut.makeSureIsRefreshing()
                }

                it("calls beginRefreshing") {
                    expect(sut.beginRefreshingCalled).to(beTruthy())
                }

                it("doesn't call endRefreshing") {
                    expect(sut.endRefreshingCalled).to(beFalsy())
                }
            }
        }

        describe("makeSureIsNotRefreshing") {
            context("refreshing is in progress") {
                beforeEach {
                    sut.isRefreshingOverride = true
                    sut.makeSureIsNotRefreshing()
                }

                it("doesn't call beginRefreshing") {
                    expect(sut.beginRefreshingCalled).to(beFalsy())
                }

                it("calls endRefreshing") {
                    expect(sut.endRefreshingCalled).to(beTruthy())
                }
            }

            context("refreshing is not in progress") {
                beforeEach {
                    sut.makeSureIsNotRefreshing()
                }

                it("doesn't call beginRefreshing") {
                    expect(sut.beginRefreshingCalled).to(beFalsy())
                }

                it("doesn't call endRefreshing") {
                    expect(sut.endRefreshingCalled).to(beFalsy())
                }
            }
        }
    }
}
