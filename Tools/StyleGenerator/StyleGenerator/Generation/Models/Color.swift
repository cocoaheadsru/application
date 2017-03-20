//
//  Color.swift
//  StyleGenerator
//
//  Created by Denis on 10.03.17.
//  Copyright © 2017 DenRee. All rights reserved.
//

import Foundation

// swiftlint:disable force_cast

struct ColorsCollection: TemplateModel {

  // MARK: - Properties

  let colors: [Color]

  // MARK: - Public

  init(_ parameters: TemplateInputParameters) {
    let fontsParameters = parameters["colors"] as! [TemplateInputParameters]
    self.colors = TemplateModelsFactory.makeModels(from: fontsParameters)
  }
}

struct Color: TemplateModel {

  // MARK: - Properties

  let name: String
  let hex: String

  // MARK: - Public

  init(_ parameters: TemplateInputParameters) {
    guard let name = parameters["name"] as? String else {
      exit(with: "'Name' parameter for Color doesn't exist as String")
      self.name = ""
      self.hex = ""
      return
    }

    guard let hex = parameters["color"] as? String else {
      exit(with: "'color' parameter for Color doesn't exist as String")
      self.name = ""
      self.hex = ""
      return
    }

    self.name = name
    self.hex = hex
  }
}
