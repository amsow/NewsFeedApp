//
//  View+ViewControllable.swift
//  NewsApiFeed
//
//  Created by Amadou Diarra SOW on 04/11/2021.
//

import Foundation
import RIBs
import SwiftUI

@available(iOS 13, *)
extension ViewControllable where Self: View {
    var uiviewController: UIViewController {
        return UIHostingController(rootView: self)
    }
}
