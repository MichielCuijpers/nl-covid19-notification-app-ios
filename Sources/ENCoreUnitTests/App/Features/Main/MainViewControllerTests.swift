/*
 * Copyright (c) 2020 De Staat der Nederlanden, Ministerie van Volksgezondheid, Welzijn en Sport.
 *  Licensed under the EUROPEAN UNION PUBLIC LICENCE v. 1.2
 *
 *  SPDX-License-Identifier: EUPL-1.2
 */

@testable import ENCore
import Foundation
import XCTest

final class MainViewControllerTests: XCTestCase {
    private var viewController: MainViewController!
    private let router = MainRoutingMock()
    private let statusBuilder = StatusBuildableMock()
    private let moreInformationBuilder = MoreInformationBuildableMock()

    override func setUp() {
        super.setUp()

        let theme = ENTheme()

        viewController = MainViewController(theme: theme)
        viewController.router = router
    }

    // MARK: - MoreInformationListener

    func test_moreInformationRequestsAbout_callsRouter() {
        XCTAssertEqual(router.routeToAboutAppCallCount, 0)

        viewController.moreInformationRequestsAbout()

        XCTAssertEqual(router.routeToAboutAppCallCount, 1)
    }

    func test_moreInformationRequestsReceivedNotification_callsRouter() {
        XCTAssertEqual(router.routeToReceivedNotificationCallCount, 0)

        viewController.moreInformationRequestsReceivedNotification()

        XCTAssertEqual(router.routeToReceivedNotificationCallCount, 1)
    }

    func test_moreInformationRequestsInfected_callsRouter() {
        XCTAssertEqual(router.routeToInfectedCallCount, 0)

        viewController.moreInformationRequestsInfected()

        XCTAssertEqual(router.routeToInfectedCallCount, 1)
    }

    func test_moreInformationRequestsRequestTest_callsRouter() {
        XCTAssertEqual(router.routeToRequestTestCallCount, 0)

        viewController.moreInformationRequestsRequestTest()

        XCTAssertEqual(router.routeToRequestTestCallCount, 1)
    }

    func test_viewDidLoad_callsRouterInRightOrder() {
        XCTAssertEqual(router.attachStatusCallCount, 0)
        XCTAssertEqual(router.attachMoreInformationCallCount, 0)

        var callCountIndex = 0
        var attachStatusCallCountIndex = 0
        var attachMoreInformationCallCountIndex = 0

        router.attachStatusHandler = { _ in
            callCountIndex += 1
            attachStatusCallCountIndex = callCountIndex
        }

        router.attachMoreInformationHandler = {
            callCountIndex += 1
            attachMoreInformationCallCountIndex = callCountIndex
        }

        _ = viewController.view

        XCTAssertEqual(router.attachStatusCallCount, 1)
        XCTAssertEqual(router.attachMoreInformationCallCount, 1)
        XCTAssertEqual(attachStatusCallCountIndex, 1)
        XCTAssertEqual(attachMoreInformationCallCountIndex, 2)
    }
}
