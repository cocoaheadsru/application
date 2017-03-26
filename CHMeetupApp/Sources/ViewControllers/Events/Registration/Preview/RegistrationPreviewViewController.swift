//
//  RegistrationPreviewViewController.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 23/02/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

private let bottomMargin: CGFloat = 8

class RegistrationPreviewViewController: UIViewController {

  @IBOutlet fileprivate var tableView: UITableView! {
    didSet {
      tableView.allowsMultipleSelection = true
      tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: bottomMargin, right: 0)
      tableView.backgroundColor = UIColor.clear

      tableView.registerHeaderNib(for: DefaultTableHeaderView.self)
    }
  }

  fileprivate var bottomButton: BottomButton!
  fileprivate var displayCollection: FormDisplayCollection!

  override func viewDidLoad() {
    super.viewDidLoad()
    keyboardDelegate = self

    bottomButton = BottomButton(addingOnView: view, title: "Регистрация".localized)
    bottomButton.addTarget(self, action: #selector(registrationButtonAction), for: .touchUpInside)

    displayCollection = FormDisplayCollection()
    tableView.registerNibs(fromType: FormDisplayCollection.self)

    RegistrationController.loadRegFromServer(
      with: 1,
      completion: { [weak self] displayCollection, error in

        guard error == nil else {
          print(error!)
          return
        }

        guard let displayCollection = displayCollection else {
          return
        }

        self?.displayCollection = displayCollection
        self?.displayCollection.delegate = self
        self?.tableView.reloadData()
    })

    view.backgroundColor = UIColor(.lightGray)
  }

  func registrationButtonAction() {
    registrate(completion: {
      presentRegistrationConfirmViewController()
    })
  }

  func registrate(completion: () -> Void) {
    // Do staff here..
    completion()
  }

  func presentRegistrationConfirmViewController() {
    let confirmViewController = Storyboards.EventPreview.instantiateRegistrationConfirmViewController()
    navigationController?.pushViewController(confirmViewController, animated: true)
  }
}

// MARK: - UITableViewDataSource
extension RegistrationPreviewViewController: UITableViewDataSource {

  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return displayCollection.headerHeight(for: section)
  }

  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let header = tableView.dequeueReusableHeaderFooterView() as DefaultTableHeaderView
    header.headerLabel.text = displayCollection.headerTitle(for: section)
    return header
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
}

extension RegistrationPreviewViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    displayCollection.didSelect(indexPath: indexPath)
  }
}

extension RegistrationPreviewViewController: FormDisplayCollectionDelegate {
  func formDisplayRequestTo(selectItemsAt selectionIndexPaths: [IndexPath],
                            deselectItemsAt deselectIndexPaths: [IndexPath]) {
    tableView.beginUpdates()
    for indexPath in selectionIndexPaths {
      tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
    }
    for indexPath in deselectIndexPaths {
      tableView.deselectRow(at: indexPath, animated: true)
    }
    tableView.endUpdates()
  }
}

// MARK: - KeyboardHandlerDelegate
extension RegistrationPreviewViewController: KeyboardHandlerDelegate {

  func keyboardStateChanged(input: UIView?, state: KeyboardState, info: KeyboardInfo) {

    var buttonInsets: CGFloat = 0

    switch state {
    case .frameChanged, .opened:
      let tableViewBottomContentInsets = info.endFrame.height + bottomMargin + bottomButton.frame.height
      tableView.contentInset.bottom = tableViewBottomContentInsets
      tableView.scrollIndicatorInsets.bottom = info.endFrame.height + bottomButton.frame.height
      buttonInsets = info.endFrame.height
    case .hidden:
      tableView.contentInset.bottom = 0
      tableView.scrollIndicatorInsets.bottom = 0
      buttonInsets = 0
    }

    bottomButton.bottomInsetsConstant = buttonInsets
    info.animate({ [weak self] in
      self?.view.layoutIfNeeded()
    })
  }
}
