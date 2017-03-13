//
//  Style.swift
//  StyleGenerator
//
//  Created by Denis on 10.03.17.
//  Copyright © 2017 DenRee. All rights reserved.
//

import Foundation

// swiftlint:disable force_cast

// MARK: - Additions

typealias StyleParameters = [String: Any]

protocol StyleItem {
  init(_ parameters: StyleParameters)
}

// MARK: - Color

struct Color: StyleItem {

  // MARK: - Properties

  let name: String
  let hex: String

  // MARK: - Public

  init(_ parameters: StyleParameters) {
    //TODO: Need to add handler with message
    self.name = parameters["name"] as! String
    self.hex = parameters["hex"] as! String
  }
}

// MARK: - Font

struct Font: StyleItem {

  // MARK: - Properties
  let name: String
  let font: String

  // MARK: - Public

  init(_ parameters: StyleParameters) {
    //TODO: Need to add handler with message
    self.font = parameters["font"] as! String
    if let name = parameters["name"] as? String {
      self.name = name
    } else {
      self.name = Font.generateName(from: self.font)
    }
  }

  // MARK: - Private

  //Convert from "GothamPro-Light" -> "gothamProLight"
  fileprivate static func generateName(from font: String) -> String {
    if font.isEmpty {
      return ""
    }

    let firstChar = String(font.characters.prefix(1)).lowercased()
    let remainChars = String(font.characters.dropFirst()).replacingOccurrences(of: "-", with: "")

    return firstChar + remainChars
  }
}
