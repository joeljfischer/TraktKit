//
//  TraktWatchedProgress.swift
//  TraktKit
//
//  Created by Maximilian Litteral on 7/31/16.
//  Copyright © 2016 Maximilian Litteral. All rights reserved.
//

import Foundation

/// Watched progress. Shows/Progress/Watched
/// https://trakt.docs.apiary.io/reference/shows/watched-progress/get-show-watched-progress
public struct TraktShowWatchedProgress: Codable, Hashable {
    // Extended: Min
    /// Number of episodes that have aired
    public let aired: Int
    /// Number of episodes that have been watched
    public let completed: Int
    /// When the last episode was watched
    public let lastWatchedAt: Date?
    /// When the last reset of progress was
    public let resetAt: Date?
    public let seasons: [TraktSeasonWatchedProgress]
    public let nextEpisode: TraktEpisode?

    public init(aired: Int, completed: Int, lastWatchedAt: Date? = nil, resetAt: Date? = nil, seasons: [TraktSeasonWatchedProgress], nextEpisode: TraktEpisode? = nil) {
        self.aired = aired
        self.completed = completed
        self.lastWatchedAt = lastWatchedAt
        self.resetAt = resetAt
        self.seasons = seasons
        self.nextEpisode = nextEpisode
    }
    
    enum CodingKeys: String, CodingKey {
        case aired
        case completed
        case resetAt = "reset_at"
        case lastWatchedAt = "last_watched_at"
        case seasons
        case nextEpisode = "next_episode"
    }
}

/// Watched progress of a season. From `TraktShowWatchedProgress`.
/// https://trakt.docs.apiary.io/reference/shows/watched-progress/get-show-watched-progress
public struct TraktSeasonWatchedProgress: Codable, Hashable, Identifiable {
    public var id: Int { number }
    
    // Extended: Min
    /// Season number
    public let number: Int
    /// Number of episodes that have aired
    public let aired: Int
    /// Number of episodes that have been watched
    public let completed: Int
    public let title: String?
    public let episodes: [TraktEpisodeWatchedProgress]

    public init(number: Int, aired: Int, completed: Int, title: String? = nil, episodes: [TraktEpisodeWatchedProgress]) {
        self.number = number
        self.aired = aired
        self.completed = completed
        self.title = title
        self.episodes = episodes
    }
}

/// Watched progress of a season. From `TraktSeasonWatchedProgress`.
/// https://trakt.docs.apiary.io/reference/shows/watched-progress/get-show-watched-progress
public struct TraktEpisodeWatchedProgress: Codable, Hashable, Identifiable {
    public var id: Int { number }

    // Extended: Min
    /// The episode number
    public let number: Int
    /// Has this episode been watched
    public let completed: Bool
    /// When the last episode was watched
    public let lastWatchedAt: Date?

    public init(number: Int, completed: Bool, lastWatchedAt: Date? = nil) {
        self.number = number
        self.completed = completed
        self.lastWatchedAt = lastWatchedAt
    }
    
    enum CodingKeys: String, CodingKey {
        case number
        case completed
        case lastWatchedAt = "last_watched_at"
    }
}
