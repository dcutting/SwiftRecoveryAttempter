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
let errorToThrow = SatelliteError.antennaFailure

@NSApplicationMain class AppDelegate: NSObject, NSApplicationDelegate {

  @IBOutlet weak var window: NSWindow!

  func applicationDidFinishLaunching(_ aNotification: Notification) {
    do {
      try launchSatellite()
    } catch let error as SatelliteError where error == SatelliteError.lowPower {
      print("Ignoring low power error.")
    } catch {
      present(error: error)
    }
  }

  func launchSatellite() throws {
    throw errorToThrow
  }

  func present(error: Error) {
    switch errorModal {
    case .window:
      window.presentError(error, modalFor: window, delegate: nil, didPresent: nil, contextInfo: nil)
    case .app:
      window.presentError(error)
    }
  }
}

enum SatelliteError: LocalizedError, RecoverableError {
  case antennaFailure
  case lowPower

  var errorDescription: String? {
    switch self {
    case .antennaFailure: return "Antenna failed"
    case .lowPower: return "Low power"
    }
  }

  var recoveryOptions: [String] {
    get { return ["Try again", "Cancel"] }
  }

  func attemptRecovery(optionIndex recoveryOptionIndex: Int, resultHandler handler: (_: Bool) -> Void) {
    print("Attempting recovery for window modal error.")
  }

  func attemptRecovery(optionIndex recoveryOptionIndex: Int) -> Bool {
    print("Attempting recovery for app modal error.")
    return true
  }
}
