//
//  DemoTests.swift
//  DemoTests
//
//  Created by Mustafa Khalil on 2023-02-21.
//

import XCTest
import SnapshotTesting
@testable import DemoUI

final class SpacerViewCellTests: XCTestCase {

  private var containerSize: CGSize!

  override func setUp() {
    containerSize = CGSize(width: 375, height: 414)
  }

  func testTinySpacing() {
    let viewModel = SpacerViewModel(backgroundColor: .red, height: 10)
    let cell = SpacerViewCell(
      frame: CGRect(
        origin: .zero,
        size: viewModel.size(for: containerSize)))
    cell.bind(viewModel: viewModel)
    assertSnapshot(matching: cell, as: .image)
  }

  func testBigSpacing() {
    let viewModel = SpacerViewModel(backgroundColor: .red, height: 100)
    let cell = SpacerViewCell(
      frame: CGRect(
        origin: .zero,
        size: viewModel.size(for: containerSize)))
    cell.bind(viewModel: viewModel)
    assertSnapshot(matching: cell, as: .image)
  }

}
