//
//  CreatorsViewDisplayCollection.swift
//  CHMeetupApp
//
//  Created by Sam Mejlumyan on 20/04/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit
import RealmSwift

final class CreatorsViewDisplayCollection: DisplayCollection {
  static var modelsForRegistration: [CellViewAnyModelType.Type] {
    return [CreatorTableViewCellModel.self]
  }

  var creators: TemplateModelCollection<CreatorEntity> = {
    let dataCollection = DataModelCollection(type: CreatorEntity.self)
    return TemplateModelCollection(dataCollection: dataCollection,
                                   templatesCount: Constants.TemplatesCounts.creators)
  }()

  private func getCreators(isActive: Int = 1) -> DataModelCollection<CreatorEntity> {
    let dataCollection = DataModelCollection(type: CreatorEntity.self)
    let predicate = NSPredicate(format: "isActive = \(isActive)")
    return dataCollection.filtered(predicate)
  }

  private enum `Type` {
    case active
    case nonActive
  }

  weak var delegate: DisplayCollectionWithTableViewDelegate?
  private var sections: [Type] = [.active, .nonActive]

  var numberOfSections: Int {
    return creators.count - getCreators().count > 0 ? 2 : 1
  }

  func numberOfRows(in section: Int) -> Int {
    switch sections[section] {
    case .active:
      return getCreators().count
    case .nonActive:
      return getCreators(isActive: 0).count
    }
  }

  func headerHeight(for section: Int) -> CGFloat {
    guard let delegate = delegate else {
      assertionFailure("Subscribe to this delegate")
      return 0
    }
    let insets = DefaultTableHeaderView.titleInsets
    let title = headerTitle(for: section)
    let width = delegate.getTableViewSize().width - insets.left - insets.right
    let height = TextFrameAttributes(string: title, width: width).textHeight
    return height + insets.top + insets.bottom
  }

  func headerTitle(for section: Int) -> String {
    switch sections[section] {
    case .active:
      return "Активные".localized
    case .nonActive:
      return "Не активные".localized
    }
  }

  func model(for indexPath: IndexPath) -> CellViewAnyModelType {
    switch sections[indexPath.section] {
    case .active:
      return CreatorTableViewCellModel(entity: getCreators()[indexPath.row])
    case .nonActive:
      return CreatorTableViewCellModel(entity: getCreators(isActive: 0)[indexPath.row])
    }
  }

  func didSelect(indexPath: IndexPath) {
    var model = CreatorEntity()
    switch sections[indexPath.section] {
    case .active:
      model = getCreators()[indexPath.row]
    case .nonActive:
      model = getCreators(isActive: 0)[indexPath.row]
    }
    let viewController = Storyboards.Profile.instantiateCreatorDetailViewController()
    viewController.creatorId = model.id
    delegate?.push(viewController: viewController)
  }
}

// MARK: - TemplateModelCollectionDelegate

extension CreatorsViewDisplayCollection: TemplateModelCollectionDelegate {
  func templateModelCollectionDidUpdateData() {
    delegate?.updateUI()
  }
}
