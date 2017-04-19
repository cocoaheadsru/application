//
//  GiveSpeechViewController.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 23/02/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

class GiveSpeechViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

  @IBOutlet var tableView: UITableView! {
    didSet {
      let configuration = TableViewConfiguration(bottomInset: 8, estimatedRowHeight: 44)
      tableView.configure(with: .custom(configuration))
      tableView.registerHeaderNib(for: DefaultTableHeaderView.self)
    }
  }

  var displayCollection: GiveSpeechDisplayCollection!
  var bottomButton: BottomButton!

  override func viewDidLoad() {
    super.viewDidLoad()

    keyboardDelegate = self
    setupGestureRecognizer()

    displayCollection = GiveSpeechDisplayCollection()
    tableView.registerNibs(from: displayCollection)

    title = "Стать спикером".localized.uppercased()

    bottomButton = BottomButton(addingOnView: view, title: "Подать заявку".localized)
    bottomButton.addTarget(self, action: #selector(sendSpeech), for: .touchUpInside)
  }

  func setupGestureRecognizer() {
    let dissmisKeyboardTouch =
      UITapGestureRecognizer(target: self,
                             action: #selector(GiveSpeechViewController.dismissKeyboard))
    view.addGestureRecognizer(dissmisKeyboardTouch)
  }

  func sendSpeech() {

    if let failed = displayCollection.failedSection {
      tableView.failedShakeSection(failed)
    } else {
      bottomButton.isHidden = true
      NotificationController.present(to: self,
                                     with: "Заявка отправлена".localized,
                                     description: "Спасибо. Ваша заявка успешно отправлена.".localized,
                                     completion: {
                                      self.navigationController?.popToRootViewController(animated: true)
      })

      let currentUser = UserPreferencesEntity.value.currentUser
      if let userId = currentUser?.remoteId, let token = currentUser?.token {
        let request = RequestPlainObject.giveSpeech(title: displayCollection.nameText,
                                                    description: displayCollection.descriptionText,
                                                    userId: userId,
                                                    token: token)
        Server.standard.request(request) { answer, error in
          print(error ?? "")
          print(answer ?? "")
        }
      }
    }
  }

  func dismissKeyboard() {
    view.endEditing(true)
  }

  func numberOfSections(in tableView: UITableView) -> Int {
    return displayCollection.numberOfSections
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return displayCollection.numberOfRows(in: section)
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let model = displayCollection.model(for: indexPath)
    let cell = tableView.dequeueReusableCell(for: indexPath, with: model)
    return cell
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return displayCollection.height(for: indexPath)
  }

  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return displayCollection.headerHeight(for: section)
  }

  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let header = tableView.dequeueReusableHeaderFooterView() as DefaultTableHeaderView
    header.headerLabel.text = displayCollection.headerTitle(for: section)
    return header
  }
}

// MARK: - KeyboardHandlerDelegate
extension GiveSpeechViewController: KeyboardHandlerDelegate {
  func keyboardStateChanged(input: UIView?, state: KeyboardState, info: KeyboardInfo) {

    var scrollViewContentInsets = tableView.contentInset
    var indicatorInsets = tableView.scrollIndicatorInsets
    var buttonInsets: CGFloat = 0

    switch state {
    case .frameChanged, .opened:
      let scrollViewBottomInset = info.endFrame.height + tableView.defaultBottomInset + bottomButton.frame.height
      scrollViewContentInsets.bottom = scrollViewBottomInset
      indicatorInsets.bottom = info.endFrame.height + bottomButton.frame.height
      buttonInsets = info.endFrame.height
    case .hidden:
      scrollViewContentInsets.bottom = 0
      indicatorInsets.bottom = 0
      buttonInsets = 0
    }

    tableView.contentInset = scrollViewContentInsets
    tableView.scrollIndicatorInsets = indicatorInsets

    bottomButton.bottomInsetsConstant = buttonInsets
    info.animate ({ [weak self] in
      self?.view.layoutIfNeeded()
    })
  }
}
