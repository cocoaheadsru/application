//
//  ImageLoaderCell.swift
//  CHMeetupApp
//
//  Created by Igor Voynov on 14.04.17.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

protocol ImageLoaderCell {
  typealias CompletionBlock = (_ images: [UIImage]) -> Void
  func loadImagesCell(_ id: Int, urls: [URL], completionHandler: ImageLoaderCell.CompletionBlock?)
}

class ImageLoaderCellImpl: ImageLoaderCell {

  static let shared = ImageLoaderCellImpl()

  let loader: AnyImageLoader!

  private init() {
    loader = KingfisherImageLoader.standard
  }

  struct Task {
    let url: URL
    let loaderTask: ImageLoaderTask
  }
  private var cellTasks = [ [Int: [Task]] ]()

  func loadImagesCell(_ id: Int, urls: [URL], completionHandler: ImageLoaderCell.CompletionBlock? = nil) {

    if let index = cellTasks.index(where: { $0.index(forKey: id) != nil }) { // get index for cell Id
      let tasks = cellTasks[index].flatMap({$0.value}) // get tasks list
      if urls != tasks.map({$0.url}) { // if url list has changed for cell
        _ = tasks.map({ loader.cancel($0.loaderTask) }) // cancel all loader tasks
        cellTasks.remove(at: index) // removed cell from list
      } else {
        return // if url list not changed for cell
      }
    }

    var images = [UIImage](repeating: UIImage(), count: urls.count) // for save order
    var tasks = [Task]()
    let group = DispatchGroup()
    for (index, url) in urls.enumerated() {
      group.enter()
      let task = Task(url: url, loaderTask: loader.loadImage(from: url, completionHandler: { image, _ in
        if let image = image { images[index] = image } // by index for save order
        group.leave()
      }))
      tasks.append(task)
    }
    cellTasks.append([id: tasks]) // add tasks for cell

    group.notify(queue: DispatchQueue.main) {
      // clean tasks for cell
      if let index = self.cellTasks.index(where: { $0.index(forKey: id) != nil }) {
        self.cellTasks.remove(at: index)
      }
      if let completionHandler = completionHandler {
        completionHandler(images)
      }
    }
  }
}
