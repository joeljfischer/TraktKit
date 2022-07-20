//
//  TraktWatchedShow.swift
//  TraktKit
//
//  Created by Maximilian Litteral on 4/13/16.
//  Copyright © 2016 Maximilian Litteral. All rights reserved.
//

import Foundation

public struct TraktWatchedShow: Codable, Hashable, Identifiable {
    public var id: Int { show.id }
    
    // Extended: Min
    /// The total number of plays of episodes of this show
    public let plays: Int

    /// The last time a user watched a show. A user can set a custom date in the past, so this can't be used for sync.
    public let lastWatchedAt: Date?

    /// The last time the show was updated. Use this to determine if a full sync of the show is needed.
    public let lastUpdatedAt: Date?

    /// The show details
    public let show: TraktShow

    /// Season and episode information. Use extended info noSeasons to exclude this information.
    public let seasons: [TraktWatchedSeason]?
    
    enum CodingKeys: String, CodingKey {
        case plays
        case lastWatchedAt = "last_watched_at"
        case lastUpdatedAt = "last_updated_at"
        case show
        case seasons
    }

    /// Create a watched show for testing / preview purposes or recreating from cached data
    /// - Parameters:
    ///   - plays: The total number of plays of episodes of this show
    ///   - lastWatchedAt: The last time a user watched a show. A user can set a custom date in the past, so this can't be used for sync.
    ///   - lastUpdatedAt: The last time the show was updated. Use this to determine if a full sync of the show is needed.
    ///   - show: The show details
    ///   - seasons: Season and episode information. Use extended info noSeasons to exclude this information.
    public init(plays: Int, lastWatchedAt: Date?, lastUpdatedAt: Date?, show: TraktShow, seasons: [TraktWatchedSeason]?) {
        self.plays = plays
        self.lastWatchedAt = lastWatchedAt
        self.lastUpdatedAt = lastUpdatedAt
        self.show = show
        self.seasons = seasons
    }
}
