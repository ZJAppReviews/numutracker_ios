//
//  NumuCredential.swift
//  Numu Tracker
//
//  Created by Bradley Root on 3/10/18.
//  Copyright © 2018 Numu Tracker. All rights reserved.
//

import Foundation

class NumuCredential {
    
    private struct protectionSpace {
        static let production = URLProtectionSpace(host: "www.numutracker.com", port: 443, protocol: "https", realm: "Numu Tracker", authenticationMethod: NSURLAuthenticationMethodHTTPBasic)
    }
    
    static func storeCredential(username: String?, password: String?) {
        if let username = username,
            let password = password {
            let credential = URLCredential(user: username, password: password, persistence: .synchronizable)
                URLCredentialStorage.shared.setDefaultCredential(credential, for: protectionSpace.production)
        }
    }
    
    static func removeCredential() {
        if let credential = URLCredentialStorage.shared.defaultCredential(for: protectionSpace.production) {
            URLCredentialStorage.shared.remove(credential, for: protectionSpace.production, options: ["NSURLCredentialStorageRemoveSynchronizableCredentials": true])
        }
    }
    
    static func checkForCredential() -> Bool {
        if URLCredentialStorage.shared.defaultCredential(for: protectionSpace.production) != nil {
            print("Found Credential")
            return true
        } else {
            return false
        }
    }
    
    static func getUsername() -> String? {
        if let credential = URLCredentialStorage.shared.defaultCredential(for: protectionSpace.production) {
            return credential.user
        }
        return nil
    }
    
    static func convertCredential() -> Bool {
        // Function to convert credentials stored in UserDefaults to URLCredential
        
        return false
    }
    
    
}
