//
//  Generator.swift
//  StyleGenerator
//
//  Created by Denis on 10.03.17.
//  Copyright © 2017 DenRee. All rights reserved.
//

import Foundation

class Generator {

  // MARK: - Nested
  enum Style {
    case color
    case font
  }

  enum GeneratorError: DescribedError {
    case wrongData(style: Style)

    var message: String {
      switch self {
      case .wrongData(let style):
        return "It looks like json for \(style) is wrong"
      }
    }
  }

  // MARK: - COLORS

  func generateSwiftColorsFile(from file: StyleFile) throws -> String {
    guard file.colors.count > 0 else {
      throw GeneratorError.wrongData(style: .color)
    }

    var output = ""

    output += .header
    output += .line(string: "import UIKit.UIColor")
    output += .newLine
    output += .mark(title: "Pallete")

    //Create ColorType enum
    let colorEnumCases = file.colors.flatMap({ EnumCase($0.name, "\"\($0.hex)\"") })
    let colorEnum = String.CodeSymbols.enum(name: "ColorType", cases: colorEnumCases)

    //Create init func
    let initFuncTitle = "convenience init(_ colorType: ColorType)"
    let initFuncBody = String.CodeSymbols.line(string: "self.init(hexString: colorType.rawValue)")
    let initFunc = String.CodeSymbols.function(title: initFuncTitle, body: [initFuncBody])

    //Create extension
    let nestedTypes = [colorEnum,
                       .newLine,
                       initFunc]
    let colorExtension = String.CodeSymbols.snippet(type: .extension, for: "UIColor", nestedTypes: nestedTypes)

    output += colorExtension
    return output
  }

  // MARK: - FONTS

  func generateSwiftFontsFile(from file: StyleFile) throws -> String {
    guard file.fonts.count > 0 else {
      throw GeneratorError.wrongData(style: .font)
    }

    var output = ""

    output += .header
    output += .line(string: "import UIKit.UIFont")
    output += .newLine

    //Create FontType enum
    let enumCases = file.fonts.flatMap({ EnumCase("\($0.name)", "\"\($0.font)\"") })
    let fontEnum = String.CodeSymbols.enum(name: "FontType", cases: enumCases)

    //Create convenience init(_ fontType: FontType, size: CGFloat)
    let initFuncTitle = "convenience init(_ fontType: FontType, size: CGFloat)"
    let initFuncBody = String.CodeSymbols.line(string: "self.init(name: fontName.rawValue, size: size)!")
    let initFunc = String.CodeSymbols.function(title: initFuncTitle, body: [initFuncBody])

    //Create extension
    let nestedTypes = [fontEnum,
                       .newLine,
                       initFunc]
    let fontExtension = String.CodeSymbols.snippet(type: .extension, for: "UIFont", nestedTypes: nestedTypes)

    output += fontExtension
    return output
  }

  // MARK: - STYLES
  func generateSwiftStylesFile(from file: StyleFile) throws -> String {
    guard file.fonts.count > 0 else {
      throw GeneratorError.wrongData(style: .font)
    }

    guard file.colors.count > 0 else {
      throw GeneratorError.wrongData(style: .color)
    }

    var output = ""

    output += .header
    output += .line(string: "import UIKit.UIFont")
    output += .newLine

    output += .mark(title: "Stylable")
    output += .snippet(type: .protocol, for: "Style", nestedTypes: [])
    output += .newLine

    let associatedtypeLine = String.CodeSymbols.line(string: "associatedtype StyleType: Style")
    let tuneFunction = String.CodeSymbols.line(string: "func tune(with styles: [StyleType])")
    output += .snippet(type: .protocol, for: "Stylable", nestedTypes: [associatedtypeLine, tuneFunction])
    output += .newLine

    output += .mark(title: "Label Style")

    var labelStyleCases = [EnumCase]()
    labelStyleCases.append(EnumCase("font(UIFont.FontType, size: CGFloat)", nil))
    labelStyleCases.append(EnumCase("color(UIColor.Color)", nil))
    let labelStyleEnum = String.CodeSymbols.enum(name: "LabelStyle: Style", cases: labelStyleCases)
    output += labelStyleEnum
    output += .newLine

    output += .mark(title: "Stylable extensions")

    //Create func tune(with styles: [LabelStyle])
    let labelTuneFuncTitle = "func tune(with styles: [LabelStyle])"
    var switchCases = [SwitchCase]()
    switchCases.append(SwitchCase("font(let name, let size)", "self.font = UIFont(name, size: size)"))
    switchCases.append(SwitchCase("color(let color)", "self.textColor = UIColor(colorType: color)"))
    let stylesSwitch = String.CodeSymbols.switch(value: "style", cases: switchCases)

    let labelTuneFuncBody = [String.CodeSymbols.forCycle(nestedTypes: [stylesSwitch])]
    let labelTuneFunc = String.CodeSymbols.function(title: labelTuneFuncTitle, body: labelTuneFuncBody)

    //Create extension
    let forTypeName = "UILabel: Stylable"
    let fontExtension = String.CodeSymbols.snippet(type: .extension, for: forTypeName, nestedTypes: [labelTuneFunc])

    output += fontExtension
    output += .newLine

    //swiftlint:disable:next line_length
    let usage = "/** USAGE \nlet label = UILabel()\nlabel.tune(with: [\n.font(.gothamPro, size: 13),\n.color(.darkGray)\n])\n*/"

    output += usage

    return output
  }
}
