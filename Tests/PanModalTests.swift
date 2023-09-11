//
//  PanModalTests.swift
//  PanModalTests
//
//  Created by Tosin Afolabi on 2/26/19.
//  Copyright © 2019 PanModal. All rights reserved.
//

import XCTest
@testable import PanModal

/**
 ⚠️ Run tests on iPhone 14 iOS (16.2) Sim
 values updated to match this ios and sim from the original project as the ios version and iphone expected were too old
 */

class PanModalTests: XCTestCase {

    class MockViewController: UIViewController, PanModalPresentable {
        var panScrollable: UIScrollView? { return nil }
    }

    class AdjustedMockViewController: UITableViewController, PanModalPresentable {
        var panScrollable: UIScrollView? { return tableView }
        var shortFormHeight: PanModalHeight { return .contentHeight(300) }
        var longFormHeight: PanModalHeight { return .maxHeightWithTopInset(50) }
        // for testing purposes - to mimic safe area insets
        var topLayoutOffset: CGFloat { return 20 }
        var bottomLayoutOffset: CGFloat { return 44 }
    }

    private var vc: AdjustedMockViewController!

    override func setUp() {
        super.setUp()
        vc = AdjustedMockViewController()
    }

    override func tearDown() {
        super.tearDown()
        vc = nil
    }

    func testPresentableDefaults() {

        let vc = MockViewController()

        XCTAssertEqual(vc.topOffset, 65.0)
        XCTAssertEqual(vc.shortFormHeight, PanModalHeight.maxHeight)
        XCTAssertEqual(vc.longFormHeight, PanModalHeight.maxHeight)
        XCTAssertEqual(vc.springDamping, 0.8)
        XCTAssertEqual(vc.panModalBackgroundColor, UIColor.black.withAlphaComponent(0.7))
        XCTAssertEqual(vc.dragIndicatorBackgroundColor, UIColor.lightGray)
        XCTAssertEqual(vc.scrollIndicatorInsets, .init(top: 0, left: 0, bottom: 34, right: 0))
        XCTAssertEqual(vc.anchorModalToLongForm, true)
        XCTAssertEqual(vc.allowsExtendedPanScrolling, false)
        XCTAssertEqual(vc.allowsDragToDismiss, true)
        XCTAssertEqual(vc.allowsTapToDismiss, true)
        XCTAssertEqual(vc.isUserInteractionEnabled, true)
        XCTAssertEqual(vc.isHapticFeedbackEnabled, true)
        XCTAssertEqual(vc.shouldRoundTopCorners, false)
        XCTAssertEqual(vc.showDragIndicator, false)
        XCTAssertEqual(vc.shouldRoundTopCorners, false)
        XCTAssertEqual(vc.cornerRadius, 8.0)
        XCTAssertEqual(vc.transitionDuration, PanModalAnimator.Constants.defaultTransitionDuration)
        XCTAssertEqual(vc.transitionAnimationOptions, [.curveEaseInOut, .allowUserInteraction, .beginFromCurrentState])
    }

    func testPresentableYValues() {

        XCTAssertEqual(vc.topLayoutOffset, 20)
        XCTAssertEqual(vc.bottomLayoutOffset, 44)

        XCTAssertEqual(vc.topMargin(from: .maxHeight), 0)
        XCTAssertEqual(vc.topMargin(from: .maxHeightWithTopInset(40)), 40)
        XCTAssertEqual(vc.topMargin(from: .contentHeight(200)), -234)
        XCTAssertEqual(vc.topMargin(from: .contentHeightIgnoringSafeArea(200)), -200)

        XCTAssertEqual(vc.shortFormYPos, 115)
        XCTAssertEqual(vc.longFormYPos, 115)
        XCTAssertEqual(vc.bottomYPos, vc.view.frame.height)

        XCTAssertEqual(vc.view.frame.height, 0)
    }
}
