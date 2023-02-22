//
//  DemoTests.swift
//  DemoTests
//
//  Created by Mustafa Khalil on 2023-02-21.
//

import XCTest
import SnapshotTesting
@testable import DemoUI

final class TitleViewCellTests: XCTestCase {

  private var containerSize: CGSize!

  override func setUp() {
    containerSize = CGSize(width: 375, height: 414)
  }

  func testDefaultSpacing() {
    let viewModel = TitleViewModel(
      text: "Header")
    let cell = TitleViewCell(
      frame: CGRect(
        origin: .zero,
        size: viewModel.size(for: containerSize)))
    cell.bind(viewModel: viewModel)
    assertSnapshot(matching: cell, as: .image)
  }

  func testSmallSpacing() {
    let viewModel = TitleViewModel(
      text: "Header",
      insets: .smallInsets)
    let cell = TitleViewCell(
      frame: CGRect(
        origin: .zero,
        size: viewModel.size(for: containerSize)))
    cell.bind(viewModel: viewModel)
    assertSnapshot(matching: cell, as: .image)
  }

  func testOnlySidesSpacing() {
    let viewModel = TitleViewModel(
      text: "Header",
      insets: .onlySides)
    let cell = TitleViewCell(
      frame: CGRect(
        origin: .zero,
        size: viewModel.size(for: containerSize)))
    cell.bind(viewModel: viewModel)
    assertSnapshot(matching: cell, as: .image)
  }

  func testDefaultFont() {
    let viewModel = TitleViewModel(
      text: "Header")
    let cell = TitleViewCell(
      frame: CGRect(
        origin: .zero,
        size: viewModel.size(for: containerSize)))
    cell.bind(viewModel: viewModel)
    assertSnapshot(matching: cell, as: .image)
  }

  func testChangedFont() {
    let viewModel = TitleViewModel(
      text: "Header",
      font: .titleBold)
    let cell = TitleViewCell(
      frame: CGRect(
        origin: .zero,
        size: viewModel.size(for: containerSize)))
    cell.bind(viewModel: viewModel)
    assertSnapshot(matching: cell, as: .image)
  }

  func testColor() {
    let viewModel = TitleViewModel(
      text: "Header",
      textColor: .red)
    let cell = TitleViewCell(
      frame: CGRect(
        origin: .zero,
        size: viewModel.size(for: containerSize)))
    cell.bind(viewModel: viewModel)
    assertSnapshot(matching: cell, as: .image)
  }

}
