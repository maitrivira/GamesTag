//
//  Profile.swift
//  dicodingSubmission2
//
//  Created by Maitri Vira on 07/09/21.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    let defaults = UserDefaults.standard
    let encoder = JSONEncoder()
    func addBio(name: String, job: String, desc: String) {
        defaults.set(name, forKey: "name")
        defaults.set(job, forKey: "job")
        defaults.set(desc, forKey: "desc")
    }
    func getName() -> String {
        guard let name = defaults.object(forKey: "name") as? String else {
            return ""
        }
        return name
    }
    func getJob() -> String {
        guard let job = defaults.object(forKey: "job") as? String else {
            return ""
        }
        return job
    }
    func getDesc() -> String {
        guard let desc = defaults.object(forKey: "desc") as? String else {
            return ""
        }
        return desc
    }
}
