//
//  File.swift
//  
//
//  Created by Mustafa Khalil on 2023-02-21.
//

import UIKit

extension NSDirectionalEdgeInsets {

  public static let defaultInsets = NSDirectionalEdgeInsets(
    top: Theme.Size.Padding.xxlarge,
    leading: Theme.Size.Padding.base,
    bottom: Theme.Size.Padding.base,
    trailing: Theme.Size.Padding.base)

  public static let smallInsets = NSDirectionalEdgeInsets(
    top: Theme.Size.Padding.base,
    leading: Theme.Size.Padding.base,
    bottom: Theme.Size.Padding.small,
    trailing: Theme.Size.Padding.base)

  public static let onlySides = NSDirectionalEdgeInsets(
    top: 0,
    leading: Theme.Size.Padding.base,
    bottom: 0,
    trailing: Theme.Size.Padding.base)

}

extension UIView {

  public func addSubview(_ view: UIView, insets: UIEdgeInsets, toSafeArea: Bool = false) {
    addSubview(view)
    view.translatesAutoresizingMaskIntoConstraints = false
    if toSafeArea {
      NSLayoutConstraint.activate([
        view.topAnchor.constraint(
          equalTo: layoutMarginsGuide.topAnchor,
          constant: insets.top),
        view.bottomAnchor.constraint(
          equalTo: layoutMarginsGuide.bottomAnchor,
          constant: -insets.bottom),
        view.leadingAnchor.constraint(
          equalTo: layoutMarginsGuide.leadingAnchor,
          constant: insets.left),
        view.trailingAnchor.constraint(
          equalTo: layoutMarginsGuide.trailingAnchor,
          constant: -insets.right),
      ])
    } else {
      NSLayoutConstraint.activate([
        view.topAnchor.constraint(
          equalTo: topAnchor,
          constant: insets.top),
        view.bottomAnchor.constraint(
          equalTo: bottomAnchor,
          constant: -insets.bottom),
        view.leadingAnchor.constraint(
          equalTo: leadingAnchor,
          constant: insets.left),
        view.trailingAnchor.constraint(
          equalTo: trailingAnchor,
          constant: -insets.right),
      ])
    }
  }
}
