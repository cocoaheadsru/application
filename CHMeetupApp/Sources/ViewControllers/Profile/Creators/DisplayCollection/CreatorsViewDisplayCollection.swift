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

  private var creatorsCollection: DataModelCollection<CreatorEntity> = {
    return DataModelCollection(type: CreatorEntity.self)
  }()

  private enum CreatorsType {
    case active(DataModelCollection<CreatorEntity>)
    case nonActive(DataModelCollection<CreatorEntity>)

    var collection: DataModelCollection<CreatorEntity> {
      switch self {
      case .active(let creators):
        let predicate = NSPredicate(format: "isActive = 1")
        return creators.filtered(predicate)
      case .nonActive(let creators):
        let predicate = NSPredicate(format: "isActive = 0")
        return creators.filtered(predicate)
      }
    }
  }

  private enum `Type` {
    case active
    case nonActive
  }

  weak var delegate: DisplayCollectionWithTableViewDelegate?
  private var sections: [Type] = [.active, .nonActive]

  var numberOfSections: Int {
    return CreatorsType.nonActive(creatorsCollection).collection.count > 0 ? 2 : 1
  }

  func numberOfRows(in section: Int) -> Int {
    switch sections[section] {
    case .active:
      return CreatorsType.active(creatorsCollection).collection.count
    case .nonActive:
      return CreatorsType.nonActive(creatorsCollection).collection.count
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
      return CreatorTableViewCellModel(entity: CreatorsType.active(creatorsCollection).collection[indexPath.row])
    case .nonActive:
      return CreatorTableViewCellModel(entity: CreatorsType.nonActive(creatorsCollection).collection[indexPath.row])
    }
  }

  func didSelect(indexPath: IndexPath) {
    var model = CreatorEntity()
    switch sections[indexPath.section] {
    case .active:
      model = CreatorsType.active(creatorsCollection).collection[indexPath.row]
    case .nonActive:
      model = CreatorsType.nonActive(creatorsCollection).collection[indexPath.row]
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
