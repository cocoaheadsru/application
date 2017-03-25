//
//  StylesTemplate.swift
//  StyleGenerator
//
//  Created by Denis on 19.03.17.
//  Copyright © 2017 DenRee. All rights reserved.
//

import Cocoa

class StylesTemplate: GeneratedTemplate {

  // MARK: - Public

  func generate() throws -> TemplateOutputCode {
    var output = ""

    output += .header
    output += .line(string: "import UIKit.UIFont")
    output += .newLine

    output += .mark(title: "Stylable")
    output += .snippet(type: .protocol, for: "StyleAttribute", nestedTypes: [])
    output += .newLine

    let associatedtypeLine = String.CodeSymbols.line(string: "associatedtype AttributeType: StyleAttribute")
    let tuneFunction = String.CodeSymbols.line(string: "func tune(with attributes: [AttributeType])")
    output += .snippet(type: .protocol, for: "Stylable", nestedTypes: [associatedtypeLine, tuneFunction])
    output += .newLine

    output += .mark(title: "Label Style")

    var labelStyleCases = [EnumCase]()
    labelStyleCases.append(EnumCase("font(UIFont.FontType, size: CGFloat)", nil))
    labelStyleCases.append(EnumCase("color(UIColor.Color)", nil))
    let labelStyleEnum = String.CodeSymbols.enum(name: "LabelStyleAttribute: Style", cases: labelStyleCases)
    output += labelStyleEnum
    output += .newLine

    output += .mark(title: "Stylable extensions")

    // Create func tune(with styles: [LabelStyle])
    let labelTuneFuncTitle = "func tune(with attributes: [LabelStyleAttribute])"
    var switchCases = [SwitchCase]()
    switchCases.append(SwitchCase("font(let name, let size)", "self.font = UIFont(name, size: size)"))
    switchCases.append(SwitchCase("color(let color)", "self.textColor = UIColor(colorType: color)"))
    let stylesSwitch = String.CodeSymbols.switch(value: "attribute", cases: switchCases)

    let forCycleTitle = "attribute in attributes"
    let forCycle = [String.CodeSymbols.forCycle(iteratorTitle: forCycleTitle, nestedTypes: [stylesSwitch])]
    let labelTuneFunc = String.CodeSymbols.function(title: labelTuneFuncTitle, body: forCycle)

    // Create extension
    let forTypeName = "UILabel: Stylable"
    let fontExtension = String.CodeSymbols.snippet(type: .extension, for: forTypeName, nestedTypes: [labelTuneFunc])

    output += fontExtension
    output += .newLine

    // swiftlint:disable:next line_length
    let usage = "/** USAGE \nlet label = UILabel()\nlabel.tune(with: [\n.font(.gothamPro, size: 13),\n.color(.darkGray)\n])\n*/"
    output += usage
    return output
  }
}
