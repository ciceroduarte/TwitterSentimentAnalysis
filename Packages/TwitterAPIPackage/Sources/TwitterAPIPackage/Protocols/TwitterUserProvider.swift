//
//  TwitterUserProvider.swift
//  
//
//  Created by Cicero Duarte on 14/11/21.
//

import Foundation

public protocol TwitterUserProvider {

    func fetchUser(byUsername username: String, completionHandler: @escaping (User?) -> Void)
    func fetchUserTimeline(withIdentifier userIdentifier: String, completion: @escaping ([Tweet]) -> Void)
}
