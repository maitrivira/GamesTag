//
//  UIApplication.swift
//  dicodingSubmission2
//
//  Created by Maitri Vira on 13/09/21.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
