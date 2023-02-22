//
//  File.swift
//  
//
//  Created by Mustafa Khalil on 2023-02-22.
//

import Foundation

public protocol SectionViewModel: Hashable {
  var sectionType: String { get }
  var viewModels: [AnyHashable] { get }
}
