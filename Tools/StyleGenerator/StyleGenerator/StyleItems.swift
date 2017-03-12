//
//  Style.swift
//  StyleGenerator
//
//  Created by Denis on 10.03.17.
//  Copyright © 2017 DenRee. All rights reserved.
//

import Foundation

//MARK: - Additions

typealias StyleParameters = [String: Any]

protocol StyleItem {
  init(_ parameters: StyleParameters)
}

//MARK: - Color

final class Color: StyleItem {

  //MARK: - Properties

  fileprivate(set) var name = String()
  fileprivate(set) var hex = String()

  //MARK: - Public

  required init(_ parameters: StyleParameters) {
    if let name = parameters["name"] as? String {
      self.name = name
    }

    if let hex = parameters["hex"] as? String {
      self.hex = hex
    }
  }
}

//MARK: - Font

final class Font: StyleItem {

  //MARK: - Properties
  
  fileprivate(set) var name = String()
  fileprivate(set) var font = String()

  //MARK: - Public

  required init(_ parameters: StyleParameters) {
    if let name = parameters["name"] as? String {
      self.name = name
    }

    if let font = parameters["font"] as? String {
      self.font = font
    }
  }
}
