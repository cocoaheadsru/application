//
//  Generator.swift
//  StyleGenerator
//
//  Created by Denis on 10.03.17.
//  Copyright © 2017 DenRee. All rights reserved.
//

import Foundation

class Generator {

  //MARK: - Nested
  
  enum Style: String {
    case color = "color"
    case font = "font"
  }

  enum GeneratorError: DescribedError {
    case wrongData(style: Style)

    var message: String {
      switch self {
      case .wrongData(let style):
        return "It looks like json for \(style.rawValue) is wrong"
      }
    }
  }

  //MARK: - Public

  func generateSwiftColorsFile(from file: StyleFile) throws -> String {
    guard file.colors.count > 0 else {
      throw GeneratorError.wrongData(style: .color)
    }

    var output = String()

    output += .header
    output += .line(string: "import UIKit.UIColor")
    output += .newLine
    output += .mark(title: "Pallete")

    //Create ColorType enum
    let colorEnum = String.CodeSymbols.enum(name: "ColorType", cases: file.colors.flatMap({ $0.name }))

    //Create appColor(_ colorType: ColorType) -> UIColor
    let appColorFuncTitle = "static func appColor(_ colorType: ColorType) -> UIColor"
    var colorCases = [SwitchCase]()
    for color in file.colors {
      let switchCase = (color.name, "return UIColor(hexString: \"\(color.hex)\")")
      colorCases.append(switchCase)
    }
    let appColorFuncBody = String.CodeSymbols.switch(value: "colorType", cases: colorCases)
    let appColorFunc = String.CodeSymbols.function(title: appColorFuncTitle, body: [appColorFuncBody])

    //Create init func
    let initFuncTitle = "convenience init(_ colorType: ColorType)"
    var initFuncColorCases = [SwitchCase]()
    for color in file.colors {
      let switchCase = (color.name, "self.init(hexString: \"\(color.hex)\")")
      initFuncColorCases.append(switchCase)
    }
    let initFuncBody = String.CodeSymbols.switch(value: "colorType", cases: initFuncColorCases)
    let initFunc = String.CodeSymbols.function(title: initFuncTitle, body: [initFuncBody])

    //Create extenision
    let colorExtension = String.CodeSymbols.extension(for: "UIColor", nestedTypes: [colorEnum, .newLine, .line(string: "@available(*, deprecated)"), appColorFunc, .newLine, initFunc])

    output += colorExtension
    
    return output
  }

  func generateSwiftFontsFile(from file: StyleFile) throws -> String {
    guard file.fonts.count > 0 else {
      throw GeneratorError.wrongData(style: .font)
    }

    var output = String()

    output += .header
    output += .line(string: "import UIKit.UIFont")
    output += .newLine

    //Create FontType enum
    var enumCases = file.fonts.flatMap({ "\($0.name)(size: CGFloat)" })
    enumCases.append("systemFont(size: CGFloat)")
    let fontEnum = String.CodeSymbols.enum(name: "FontType", cases: enumCases)

    //Create appFont(_ fontType: FontType) -> UIFont
    let appFontFuncTitle = "static func appFont(_ fontType: FontType) -> UIFont"
    var switchCases = [SwitchCase]()
    for font in file.fonts {
      let switchCase = ("\(font.name)(let size)", "return UIFont(name: \"\(font.font)\", size: size) ?? UIFont.systemFont(ofSize: size)")
      switchCases.append(switchCase)
    }
    switchCases.append(("systemFont(let size)", "return UIFont.systemFont(ofSize: size)"))

    let appFontFuncBody = String.CodeSymbols.switch(value: "fontType", cases: switchCases)
    let appFontFunc = String.CodeSymbols.function(title: appFontFuncTitle, body: [appFontFuncBody])

    //Create extenision
    let fontExtension = String.CodeSymbols.extension(for: "UIFont", nestedTypes: [fontEnum, .newLine, appFontFunc])

    output += fontExtension
    
    return output
  }
}
