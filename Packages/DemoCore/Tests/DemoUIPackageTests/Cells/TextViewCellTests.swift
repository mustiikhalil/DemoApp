//
//  DemoTests.swift
//  DemoTests
//
//  Created by Mustafa Khalil on 2023-02-21.
//

import XCTest
import SnapshotTesting
@testable import DemoUI

final class TextViewCellTests: XCTestCase {

  private var containerSize: CGSize!

  override func setUp() {
    containerSize = CGSize(width: 375, height: 414)
  }

  func testDefaultSpacing() {
    let viewModel = TextViewModel(
      text: "Header")
    let cell = TextViewCell(
      frame: CGRect(
        origin: .zero,
        size: viewModel.size(for: containerSize)))
    cell.bind(viewModel: viewModel)
    assertSnapshot(matching: cell, as: .image)
  }

  func testSmallSpacing() {
    let viewModel = TextViewModel(
      text: "Header",
      insets: .smallInsets)
    let cell = TextViewCell(
      frame: CGRect(
        origin: .zero,
        size: viewModel.size(for: containerSize)))
    cell.bind(viewModel: viewModel)
    assertSnapshot(matching: cell, as: .image)
  }

  func testOnlySidesSpacing() {
    let viewModel = TextViewModel(
      text: "Header",
      insets: .onlySides)
    let cell = TextViewCell(
      frame: CGRect(
        origin: .zero,
        size: viewModel.size(for: containerSize)))
    cell.bind(viewModel: viewModel)
    assertSnapshot(matching: cell, as: .image)
  }

  func testDefaultFont() {
    let viewModel = TextViewModel(
      text: "Header")
    let cell = TextViewCell(
      frame: CGRect(
        origin: .zero,
        size: viewModel.size(for: containerSize)))
    cell.bind(viewModel: viewModel)
    assertSnapshot(matching: cell, as: .image)
  }

  func testChangedFont() {
    let viewModel = TextViewModel(
      text: "Header",
      font: .titleBold)
    let cell = TextViewCell(
      frame: CGRect(
        origin: .zero,
        size: viewModel.size(for: containerSize)))
    cell.bind(viewModel: viewModel)
    assertSnapshot(matching: cell, as: .image)
  }

  func testColor() {
    let viewModel = TextViewModel(
      text: "Header",
      textColor: .red)
    let cell = TextViewCell(
      frame: CGRect(
        origin: .zero,
        size: viewModel.size(for: containerSize)))
    cell.bind(viewModel: viewModel)
    assertSnapshot(matching: cell, as: .image)
  }

}
