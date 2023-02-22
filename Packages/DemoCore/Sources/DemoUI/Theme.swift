//
//  File.swift
//  
//
//  Created by Mustafa Khalil on 2023-02-22.
//

import UIKit

public enum Theme {
  public enum Size {
    public enum Padding {
      public static let small: CGFloat = 4
      public static let base: CGFloat = 8
      public static let large: CGFloat = 16
      public static let xxlarge: CGFloat = 32
    }
  }
}

extension UIColor {
  public static let gold = UIColor(red: 255 / 255, green: 215 / 255, blue: 0, alpha: 1)
}

extension UIFont {
  public static let headerBoldLarge: UIFont = .systemFont(ofSize: 24, weight: .bold)
  public static let headerBold: UIFont = .systemFont(ofSize: 18, weight: .bold)
  public static let titleBold: UIFont = .systemFont(ofSize: 14, weight: .bold)
  public static let labelFont: UIFont = .systemFont(ofSize: 12, weight: .light)
}
