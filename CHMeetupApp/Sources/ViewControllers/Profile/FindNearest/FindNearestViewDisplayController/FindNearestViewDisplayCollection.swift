//
//  FindNearestViewDisplayCollection.swift
//  CHMeetupApp
//
//  Created by Chingis Gomboev on 16/03/2018.
//  Copyright © 2018 CocoaHeads Community. All rights reserved.
//

import UIKit

final class FindNearestViewDisplayCollection: DisplayCollection {
  static var modelsForRegistration: [CellViewAnyModelType.Type] {
    return [NearestUserTableViewCellModel.self, SwitchTableViewCellModel.self]
  }

  fileprivate enum `Type`: Int {
    case switchActionButtons
    case nearestUsers
  }

  fileprivate var sections: [Type] = [.switchActionButtons, .nearestUsers]

  var nearestUsersCollection: TemplateModelCollection<NearestUserEntity> = {
    let dataCollection = DataModelCollection(type: NearestUserEntity.self).filtered("discovered == true")
    return TemplateModelCollection(dataCollection: dataCollection)
  }()

  private let switchActionController = SwitchActionCellController()
  private var switchActionPlainObjects: [SwitchTableViewCellModel] = []

  weak var delegate: DisplayCollectionWithTableViewDelegate?

  func updateActionCellsSection(on viewController: UIViewController,
                                with tableView: UITableView) {
    switchActionPlainObjects = []
    let switchActionPlainObject = switchActionController.create(
      on: viewController,
      cancelAction: { [weak delegate] in
        delegate?.updateUI()
    })
    let switchModel = SwitchTableViewCellModel(action: switchActionPlainObject, delegate: self)
    switchActionPlainObjects.append(switchModel)
  }

  var nearestUsersSection: IndexSet {
    return IndexSet(integer: Type.nearestUsers.rawValue)
  }

  var numberOfSections: Int {
    return sections.count
  }

  func numberOfRows(in section: Int) -> Int {
    switch sections[section] {
    case .switchActionButtons:
      return switchActionPlainObjects.count
    case .nearestUsers:
      return nearestUsersCollection.count
    }
  }

  func model(for indexPath: IndexPath) -> CellViewAnyModelType {
    switch sections[indexPath.section] {
    case .switchActionButtons:
      return switchActionPlainObjects[indexPath.row]
    case .nearestUsers:
      return NearestUserTableViewCellModel(entity: nearestUsersCollection[indexPath.row])
    }

  }

  func didSelect(indexPath: IndexPath) {
    //NOTHING YET
  }
}

extension FindNearestViewDisplayCollection: TemplateModelCollectionDelegate {
  func templateModelCollectionDidUpdateData() {
    delegate?.updateUI()
  }
}

extension FindNearestViewDisplayCollection: SwitchTableViewCellDelegate {
  func switchTableViewCellDidChangeValue(_ switchCell: SwitchTableViewCell) {
    guard let indexPath = delegate?.getIndexPath(from: switchCell) else {
      assertionFailure("IndexPath is unknown")
      return
    }
    switchActionPlainObjects[indexPath.row].action.switchAction?(switchCell.switchView.isOn)
  }
}
