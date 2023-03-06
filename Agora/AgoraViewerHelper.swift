//
//  AgoraViewerHelper.swift
//  Agora
//
//  Created by Nyi Ye Han on 04/03/2023.
//

import Foundation
import AgoraUIKit
import UIKit


class AgoraViewerHelper: AgoraVideoViewerDelegate {
    
  static var agview: AgoraViewer = {
      
    AgoraViewer(
      connectionData: AgoraConnectionData(
        appId: Utils.APP_ID, rtcToken: Utils.TOKEN
      ),
      style: .floating,
      delegate: AgoraViewerHelper.delegate
    )
      
  }()
  static var delegate = AgoraViewerHelper()
    
  func extraButtons() -> [UIButton] {
    let button = UIButton()
    button.setImage(UIImage(named: "pinpoint-logo"), for: .normal)
    button.backgroundColor = .systemGreen
    button.isSelected = self.pinPointEnabled
    button.backgroundColor = self.pinPointEnabled ? .systemGreen : .systemRed
    button.addTarget(self, action: #selector(self.togglePinpoint), for: .touchUpInside)
    return [button]
  }

  func registerPinPoint() {
    // nothing yet
  }

  func joinedChannel(channel: String) {
    // nothing yet
  }

  var pinPointEnabled: Bool = true

  @objc func togglePinpoint(_ sender: UIButton) {
    pinPointEnabled.toggle()
    sender.backgroundColor = self.pinPointEnabled ? .systemGreen : .systemRed
  }
}
