//
//  Extensions.swift
//  Numu Tracker
//
//  Created by Bradley Root on 3/11/18.
//  Copyright © 2018 Numu Tracker. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

extension UIDevice {
    var iPhone: Bool {
        return UIDevice().userInterfaceIdiom == .phone
    }
    enum ScreenType: String {
        case iPhone4
        case iPhone5
        case iPhone6
        case iPhone6Plus
        case unknown
    }
    var screenType: ScreenType {
        guard iPhone else { return .unknown }
        switch UIScreen.main.nativeBounds.height {
        case 960:
            return .iPhone4
        case 1136:
            return .iPhone5
        case 1334:
            return .iPhone6
        case 2208:
            return .iPhone6Plus
        default:
            return .unknown
        }
    }
}

extension Array where Element : JSONCodable {
    init(from url: String) {
        if let url = URL(string: url),
            let data = try? Data(contentsOf: url),
            let json = try? JSON(data: data),
            let arr = json.array  {
            self = arr.flatMap { Element(json: $0) }
        }
        else {
            self = []
        }
    }
}


extension Array where Element : JSONCodable {
    init(with json: JSON) {
        if let arr = json.array {
            self = arr.flatMap { Element(json: $0) }
        } else {
            self = []
        }
    }
}

extension ReleaseItem : JSONCodable { }
extension ArtistItem: JSONCodable { }

extension String {
    static let logged = "logged"
    static let newReleased = "newReleased"
    static let newAnnouncements = "newAnnouncements"
    static let moreReleases = "moreReleases"
    static let username = "username"
    static let password = "password"
}

extension UserDefaults {
    var logged: Bool {
        get {
            return bool(forKey: .logged)
        }
        set {
            set(newValue, forKey: .logged)
        }
    }
    
    var newReleased: Bool {
        get {
            return bool(forKey: .newReleased)
        }
        set {
            set(newValue, forKey: .newReleased)
        }
    }
    
    var newAnnouncements: Bool {
        get {
            return bool(forKey: .newAnnouncements)
        }
        set {
            set(newValue, forKey: .newAnnouncements)
        }
    }
    
    var moreReleases: Bool {
        get {
            return bool(forKey: .moreReleases)
        }
        set {
            set(newValue, forKey: .moreReleases)
        }
    }
    
    var username: String? {
        get {
            return string(forKey: .username)
        }
        set {
            if let v = newValue {
                set(v, forKey: .username)
            }
            else {
                removeObject(forKey: .username)
            }
        }
    }
    
    var password: String? {
        get {
            return string(forKey: .password)
        }
        set {
            if let v = newValue {
                set(v, forKey: .password)
            }
            else {
                removeObject(forKey: .password)
            }
        }
    }
}

extension Notification.Name {
    static let LoggedIn = Notification.Name(rawValue: "com.numutracker.loggedIn")
    static let LoggedOut = Notification.Name(rawValue: "com.numutracker.loggedOut")
    static let UpdatedArtists = Notification.Name(rawValue: "com.numutracker.artistsImported")
    static let ClosedLogRegPrompt = Notification.Name(rawValue: "com.numutracker.closedLogRegPrompt")
}

extension UIView {
    func fadeIn() {
        // Move our fade out code from earlier
        UIView.animate(withDuration: 1.0, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0 // Instead of a specific instance of, say, birdTypeLabel, we simply set [thisInstance] (ie, self)'s alpha
        }, completion: nil)
    }
    
    func fadeOut() {
        UIView.animate(withDuration: 1.0, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.alpha = 0.0
        }, completion: nil)
    }
}

extension UIColor {
    static let shadow = UIColor(red: 28/255, green: 202/255, blue: 241/255, alpha: 1)
    static let bg = UIColor(red: 48/255, green: 156/255, blue: 172/255, alpha: 1)
}


extension UIImageView {
    func downloadImageFrom(link:String, contentMode: UIViewContentMode) {
        URLSession.shared.dataTask(with: URL(string:link)!, completionHandler: {
            (data, response, error) -> Void in
            DispatchQueue.main.async {
                self.contentMode =  contentMode
                data.map { self.image = UIImage(data: $0) }
            }
        }).resume()
    }
}
