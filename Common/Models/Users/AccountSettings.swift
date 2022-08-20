//
//  AccountSettings.swift
//  TraktKitTests
//
//  Created by Maximilian Litteral on 6/15/17.
//  Copyright © 2017 Maximilian Litteral. All rights reserved.
//

import Foundation

public struct AccountSettings: Codable, Hashable {
    public let user: User
    public let connections: Connections
    public let account: Account
    public let sharingText: SharingText?
    public let limits: Limits
    
    public struct Connections: Codable, Hashable {
        public let facebook: Bool
        public let twitter: Bool
        public let google: Bool
        public let tumblr: Bool
        public let medium: Bool
        public let slack: Bool
    }

    public struct Account: Codable, Hashable {
        public let timeZone: String?
        public let dateFormat: String?
        public let time24Hr: Bool?
        public let coverImage: URL?

        enum CodingKeys: String, CodingKey {
            case timeZone = "timezone"
            case dateFormat = "date_format"
            case time24Hr = "time_24hr"
            case coverImage = "cover_image"
        }
    }

    public struct SharingText: Codable, Hashable {
        public let watching: String?
        public let watched: String?
        public let rated: String?
    }

    public struct Limits: Codable, Hashable {
        public let list: ListLimits
        public let watchlist: ListLimits
        public let recommendations: ListLimits

        public struct ListLimits: Codable, Hashable {
            public let count: Int?
            public let itemCount: Int

            enum CodingKeys: String, CodingKey {
                case count
                case itemCount = "item_count"
            }
        }
    }
}
