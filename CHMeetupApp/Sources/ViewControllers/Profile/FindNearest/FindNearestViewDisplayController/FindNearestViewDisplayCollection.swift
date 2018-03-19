//
//  FindNearestViewDisplayCollection.swift
//  CHMeetupApp
//
//  Created by Chingis Gomboev on 16/03/2018.
//  Copyright © 2018 CocoaHeads Community. All rights reserved.
//

import Foundation

final class FindNearestViewDisplayCollection: DisplayCollection {
  static var modelsForRegistration: [CellViewAnyModelType.Type] {
    return [NearestUserTableViewCellModel.self]
  }

  var nearestUsersCollection: TemplateModelCollection<NearestUserEntity> = {
    let dataCollection = DataModelCollection(type: NearestUserEntity.self).filtered("discovered == true")
    return TemplateModelCollection(dataCollection: dataCollection)
  }()

  weak var delegate: DisplayCollectionWithTableViewDelegate?

  func numberOfRows(in section: Int) -> Int {
      return nearestUsersCollection.count
  }

  func model(for indexPath: IndexPath) -> CellViewAnyModelType {
    return NearestUserTableViewCellModel(entity: nearestUsersCollection[indexPath.row])
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
