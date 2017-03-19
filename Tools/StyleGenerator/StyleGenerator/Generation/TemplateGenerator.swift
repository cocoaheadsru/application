//
//  TemplateGenerator.swift
//  TemplateGenerator
//
//  Created by Denis on 10.03.17.
//  Copyright © 2017 DenRee. All rights reserved.
//

import Foundation

// MARK: - Models

typealias TemplateOutputCode = String

enum TemplateError: DescribedError {
  case wrongData(option: TemplateOption)

  var message: String {
    switch self {
    case .wrongData(let option):
      return "It looks like json for \(option) is wrong"
    }
  }
}

protocol GeneratedTemplate {
  func generate() throws -> TemplateOutputCode
}

protocol GeneratedModelTemplate: GeneratedTemplate {
  associatedtype TemplateModel
  init(_ model: TemplateModel)
}

// MARK: - Generator

class TemplateGenerator {

  // MARK: - Public

  func generateFiles(for parameters: ConsoleInputParameters) {
    do {
      let templateParameters = try FileController.readTemplateParameters(from: parameters.inputPath)
      let styleAttributes = StyleAttributes(templateParameters)
      let template = makeTemplate(for: parameters.option, with: styleAttributes)
      let code = try template?.generate()
      if let code = code {
        try FileController.write(code: code, in:  parameters.outputPath)
      } else {
        exit(with: "Something went wrong")
      }
    } catch {
      exit(with: error)
    }
  }

  // MARK: - Private

  private func makeTemplate(for option: TemplateOption, with attributes: StyleAttributes) -> GeneratedTemplate? {
    var result: GeneratedTemplate?

    switch option {
    case .unknown: break
    case .colors:
      result = ColorsTemplate(attributes.colors)
    case .fonts:
      result = FontsTemplate(attributes.fonts)
    case .styles:
      result = StylesTemplate()
    }

    return result
  }
}
