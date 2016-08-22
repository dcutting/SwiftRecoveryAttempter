//
//  AppDelegate.swift
//  SwiftRecoveryAttempter
//
//  Created by Dan Cutting on 22/08/2016.
//  Copyright © 2016 cutting.io. All rights reserved.
//

import Cocoa

enum ErrorModal {
  case window, app
}

let errorModal = ErrorModal.app

@NSApplicationMain class AppDelegate: NSObject, NSApplicationDelegate {

  @IBOutlet weak var window: NSWindow!

  func applicationDidFinishLaunching(_ aNotification: Notification) {
    let error = makeError()

    switch errorModal {
    case .window:
      window.presentError(error, modalFor: window, delegate: nil, didPresent: nil, contextInfo: nil)
    case .app:
      window.presentError(error)
    }
  }

  func makeError() -> NSError {
    let userInfo = [
      NSLocalizedDescriptionKey: "Error",
      NSLocalizedRecoverySuggestionErrorKey: "There was a temporary problem.",
      NSLocalizedRecoveryOptionsErrorKey: ["Try again", "Cancel"],
      NSRecoveryAttempterErrorKey: RecoveryAttempter()
    ]
    let error = NSError(domain: "MyDomain", code: 1, userInfo: userInfo)
    return error
  }
}

class RecoveryAttempter: NSObject {
  override func attemptRecovery(fromError error: NSError, optionIndex recoveryOptionIndex: Int, delegate: AnyObject?, didRecoverSelector: Selector?, contextInfo: UnsafeMutablePointer<Void>?) {
    print("Attempting recovery for window modal error.")
  }

  override func attemptRecovery(fromError error: NSError, optionIndex recoveryOptionIndex: Int) -> Bool {
    print("Attempting recovery for app modal error.")
    return true
  }
}
