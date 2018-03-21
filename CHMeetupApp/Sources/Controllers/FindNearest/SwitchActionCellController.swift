//
//  SwitchActionCellController.swift
//  CHMeetupApp
//
//  Created by Chingis Gomboev on 20/03/2018.
//  Copyright © 2018 CocoaHeads Community. All rights reserved.
//

import UIKit

class SwitchActionCellController {

  func create(on viewController: UIViewController,
              selectAction: Action? = nil,
              cancelAction: Action? = nil) -> SwitchActionPlainObject {
    return SwitchActionPlainObject(
      text: "Люди вокруг".localized,
      imageName: "air-drop",
      isOn: isOn(),
      selectAction: selectAction,
      switchAction: { [weak viewController, weak self] isOn in
        guard let vc = viewController, let `self` = self else { return }
        self.showAlert(on: vc, isOn: isOn, cancelAction: cancelAction)
    })
  }

  private func showAlert(on vc: UIViewController, isOn: Bool, cancelAction: Action? = nil) {
    let message: String = isOn ?
      "Включая этот режим люди вокруг смогут видеть вас".localized :
      "Выключая этот режим люди вокруг не смогут видеть вас".localized
    vc.showConfirmationAlert(
      title: "Люди рядом".localized,
      message: message,
      firstAction: {
        if isOn {
          BeaconTransmitter.turnOn()
        } else {
          BeaconTransmitter.turnOff()
        }
      },
      secondAction: cancelAction)
  }

  private func isOn() -> Bool {
    return BeaconTransmitter.isTurnedOn()
  }
}
