//
//  StyleFile.swift
//  StyleGenerator
//
//  Created by Denis on 10.03.17.
//  Copyright © 2017 DenRee. All rights reserved.
//

import Foundation

class StyleFile {

  //MARK: - Properties

  var colors = [Color]()
  var fonts = [Font]()

  //MARK: - Public

  init(from parameters: Dictionary<String,[StyleParameters]>) {
    self.colors = StyleFile.makeStyleItems(from: parameters["colors"])
    self.fonts = StyleFile.makeStyleItems(from: parameters["fonts"])
  }
}

fileprivate extension StyleFile {

  // MARK: - Private 

  static func makeStyleItems<ItemType: StyleItem>(from parameters: [StyleParameters]?) -> [ItemType] {
    guard let parameters = parameters else {
      //TODO: Need to handle it
      print("parameters are empty")
      return [ItemType]()
    }
    
    var result = [ItemType]()
    for parameter in parameters {
      result.append(ItemType(parameter))
    }

    return result
  }
}
