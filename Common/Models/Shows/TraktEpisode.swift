//
//  TraktEpisode.swift
//  TraktKit
//
//  Created by Maximilian Litteral on 4/13/16.
//  Copyright © 2016 Maximilian Litteral. All rights reserved.
//

import Foundation

public struct TraktEpisode: Codable, Hashable, Identifiable {
    public var id: Int { ids.trakt }
    
    // Extended: Min
    public let season: Int
    public let number: Int
    public let title: String?
    public let ids: EpisodeId
    
    // Extended: Full
    public let overview: String?
    public let rating: Double?
    public let votes: Int?
    public let runtime: Int?
    public let firstAired: Date?
    public let updatedAt: Date?
    public let availableTranslations: [String]?
    
    enum CodingKeys: String, CodingKey {
        case season
        case number
        case title
        case ids
        
        case overview
        case rating
        case votes
        case runtime
        case firstAired = "first_aired"
        case updatedAt = "updated_at"
        case availableTranslations = "available_translations"
    }

    public init(season: Int, number: Int, title: String? = nil, ids: EpisodeId, overview: String? = nil, rating: Double? = nil, votes: Int? = nil, runtime: Int? = nil, firstAired: Date? = nil, updatedAt: Date? = nil, availableTranslations: [String]? = nil) {
        self.season = season
        self.number = number
        self.title = title
        self.ids = ids
        self.overview = overview
        self.rating = rating
        self.votes = votes
        self.runtime = runtime
        self.firstAired = firstAired
        self.updatedAt = updatedAt
        self.availableTranslations = availableTranslations
    }
}
