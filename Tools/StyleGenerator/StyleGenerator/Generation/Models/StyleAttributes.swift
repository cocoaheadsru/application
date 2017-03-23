//
//  StyleAttributes.swift
//  StyleGenerator
//
//  Created by Denis on 19.03.17.
//  Copyright © 2017 DenRee. All rights reserved.
//

import Cocoa

struct StyleAttributes: TemplateModel {

  // MARK: - Properties

  let colors: ColorsCollection
  let fonts: FontsCollection

  // MARK: - Public

  init?(_ parameters: TemplateInputParameters) {
    guard let colors = ColorsCollection(parameters) else {
      return nil
    }
    guard let fonts = FontsCollection(parameters) else {
      return nil
    }
    self.colors = colors
    self.fonts = fonts
  }
}
