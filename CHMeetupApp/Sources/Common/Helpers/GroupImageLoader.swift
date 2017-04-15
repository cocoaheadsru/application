//
//  ImageLoaderCell.swift
//  CHMeetupApp
//
//  Created by Igor Voynov on 14.04.17.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

class GroupImageLoader {

  let loader: AnyImageLoader

  init(loader: AnyImageLoader) {
    self.loader = loader
  }

  static var standard: GroupImageLoader {
    return GroupImageLoader(loader: KingfisherImageLoader.standard)
  }

  struct Task {
    let url: URL
    let loaderTask: ImageLoaderTask
  }

  typealias GroupTasks = [Int: [Task]]
  typealias CompletionBlock = (_ images: [UIImage]) -> Void

  private var groupTasks = GroupTasks()

  func loadImages(groupId id: Int, urls: [URL], completionHandler: CompletionBlock? = nil) {

    if let tasks = groupTasks[id] { // get tasks for id
      if urls != tasks.map { $0.url } { // if url list has changed
        _ = tasks.map { loader.cancel($0.loaderTask) } // cancel all loader tasks
        groupTasks[id] = nil // removed id
      } else {
        return
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
    groupTasks[id] = tasks

    group.notify(queue: DispatchQueue.main) {
      self.groupTasks[id] = nil // clean tasks for cell
      if let completionHandler = completionHandler {
        completionHandler(images)
      }
    }
  }
}
