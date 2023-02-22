//
//  DemoTests.swift
//  DemoTests
//
//  Created by Mustafa Khalil on 2023-02-21.
//

import XCTest
import SnapshotTesting
@testable import DemoUI

final class ImageCellTests: XCTestCase {

  private var containerSize: CGSize!

  override func setUp() {
    containerSize = CGSize(width: 375, height: 414)
  }

  func testNormalCell() {
    let viewModel = ImageViewModel(
      imageSource: .local(image: UIColor.red.image()),
      isHighlighted: false,
      isExpanded: false)
    let cell = ImageViewCell(
      frame: CGRect(
        origin: .zero,
        size: viewModel.size(for: containerSize)))
    cell.bind(viewModel: viewModel)
    assertSnapshot(matching: cell, as: .image)
  }

  func testWithHighlightCell() {
    let viewModel = ImageViewModel(
      imageSource: .local(image: UIColor.red.image()),
      isHighlighted: true,
      isExpanded: false)
    let cell = ImageViewCell(
      frame: CGRect(
        origin: .zero,
        size: viewModel.size(for: containerSize)))
    cell.bind(viewModel: viewModel)
    assertSnapshot(matching: cell, as: .image)
  }

  func testWithExpandedCell() {
    let viewModel = ImageViewModel(
      imageSource: .local(image: UIColor.red.image()),
      isHighlighted: false,
      isExpanded: true)
    let cell = ImageViewCell(
      frame: CGRect(
        origin: .zero,
        size: viewModel.size(for: containerSize)))
    cell.bind(viewModel: viewModel)
    assertSnapshot(matching: cell, as: .image)
  }

}
