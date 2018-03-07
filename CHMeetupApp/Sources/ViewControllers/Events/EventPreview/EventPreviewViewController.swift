//
//  EventPreviewViewController.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 23/02/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

class EventPreviewViewController: UIViewController {

  private enum EventActionState {
    case isRegistrationEnabled
    case canCanceling
    case unknown
  }

  var selectedEventId: Int = 0

  @IBOutlet fileprivate var tableView: UITableView! {
    didSet {
      updateBottomButton()
    }
  }

  private var state: EventActionState = .unknown {
    didSet {
      updateBottomButton()
    }
  }

  var bottomButton: BottomButton?
  var displayCollection: EventPreviewDisplayCollection!

  func updateBottomButton() {
    bottomButton?.removeFromSuperview()

    var configuration = TableViewConfiguration.default
    configuration.bottomInset = 12.0 + (state != .unknown ? BottomButton.constantHeight : 0)
    configuration.bottomIndicatorInset = 8.0 + (state != .unknown ? BottomButton.constantHeight : 0)
    tableView.configure(with: .custom(configuration))

    switch state {
    case .isRegistrationEnabled:
      bottomButton = BottomButton(addingOnView: view, title: "Я пойду".localized)
      bottomButton?.addTarget(self, action: #selector(acceptAction), for: .touchUpInside)
      bottomButton?.bottomInsetsConstant = 8.0
    case .canCanceling:
      bottomButton = BottomButton(addingOnView: view, title: "Отменить заявку".localized)
      bottomButton?.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
      bottomButton?.bottomInsetsConstant = 8.0
      bottomButton?.style = .canceling
    case .unknown:
      break
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Встреча".localized

    view.backgroundColor = UIColor(.lightGray)

    displayCollection = EventPreviewDisplayCollection()
    displayCollection.delegate = self
    tableView.registerNibs(from: displayCollection)

    let dataModel = DataModelCollection(type: EventEntity.self)
    displayCollection.event = dataModel.first(where: { $0.id == selectedEventId })
    if let event = displayCollection.event {
      fetchSpeeches(on: event)
      displayCollection.updateActionCellsSection(on: self, with: tableView, event: event)
      bottomButton?.setTitle(event.status.statusText, for: .normal)

      if event.status.allowRegister {
        state = .isRegistrationEnabled
      } else if event.allowCanceling {
        state = .canCanceling
      }

    }
  }

  @objc func acceptAction() {
    let viewController = ViewControllersFactory.eventRegistrationOrAuthViewController(
      eventId: selectedEventId
    )
    navigationController?.pushViewController(viewController, animated: true)
  }

  @objc func cancelAction() {
    showConfirmationAlert(title: "Подтвердите действие".localized,
                          message: "Вы уверены, что хотите отменить свою заявку?".localized,
                          buttonFirstTitle: "Нет".localized,
                          buttonSecondTitle: "Да".localized,
                          firstAction: nil) { [weak self] in
      self?.canceletion()
    }
  }

  func canceletion() {
    showProgressHUD()
    RegistrationController.unregister(for: selectedEventId) { [weak self] (success) in
      if success {
        self?.displayCollection.event?.status = .canRegister
        self?.showSuccessNotification()
      } else {
        self?.showFaildNotification()
      }
      self?.dismissProgressHUD()
    }
  }

  func showFaildNotification() {
    let notification = NotificationHelper.viewController(title: "Ошибка!".localized,
      description: "Не удалось отменить заявку. Регистрация закрыта.".localized,
      emoji: "😔")
    self.present(viewController: notification)
  }

  func showSuccessNotification() {
    let notification = NotificationHelper.viewController(title: "Заявка отменена!".localized,
                                                         // swiftlint:disable:next line_length
                                                         description: "Спасибо, что освободили место для других участников. Будем ждать вас на будущих встречах.".localized,
                                                         emoji: "🗑",
                                                         completion: {
      self.navigationController?.popToRootViewController(animated: true)
    })
    self.present(viewController: notification)
  }

  override func updateUI() {
    if let event = displayCollection.event {
      displayCollection.updateActionCellsSection(on: self, with: tableView, event: event)
    }
    super.updateUI()
  }
}

extension EventPreviewViewController: UITableViewDelegate, UITableViewDataSource {

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

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    displayCollection.didSelect(indexPath: indexPath)
  }
}

extension EventPreviewViewController {
  func fetchSpeeches(on eventEntity: EventEntity) {
    displayCollection.speeches.isLoading = true
    let speechesRequest = SpeechPlainObject.Requests.speechesOnEvent(with: selectedEventId)
    SpeechFetching.fetchElements(request: speechesRequest, to: eventEntity, completion: { [weak self] in
      self?.displayCollection.speeches.isLoading = false
      self?.tableView.reloadData()
    })
  }
}
