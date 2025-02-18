//
//  Seasons.swift
//  TraktKit
//
//  Created by Maximilian Litteral on 11/26/15.
//  Copyright © 2015 Maximilian Litteral. All rights reserved.
//

import Foundation

extension TraktManager {

    // MARK: - Summary
    
    /**
     Returns all seasons for a show including the number of episodes in each season.
     
     If you add `?extended=episodes` to the URL, it will return all episodes for all seasons.
     
     **Note**: This returns a lot of data, so please only use this method if you need it all!
     
     */
    @discardableResult
    public func getSeasons(showID id: ShowIds.TraktId, extended: [ExtendedType] = [.min], completion: @escaping SeasonsCompletionHandler) -> URLSessionDataTaskProtocol? {
        guard var request = mutableRequest(forPath: "shows/\(id)/seasons",
                                           withQuery: ["extended": extended.queryString()],
                                           isAuthorized: false,
                                           withHTTPMethod: .GET) else { return nil }
        request.cachePolicy = .reloadIgnoringCacheData
        return performRequest(request: request,
                              completion: completion)
    }

    // MARK: - Season

    /**
     Returns all episodes for a specific season of a show.TranslationsIf you'd like to included translated episode titles and overviews in the response, include the `translations` parameter in the URL. Include `all` languages by setting the parameter to all or use a specific 2 digit country language code to further limit it.

     **Note**: This returns a lot of data, so please only use this parameter if you actually need it!

     ✨ Extended
     */
    @discardableResult
    public func getEpisodesForSeason(showID id: ShowIds.TraktId, season: Int, translatedInto language: String? = nil, extended: [ExtendedType] = [.min], completion: @escaping EpisodesCompletionHandler) -> URLSessionDataTaskProtocol? {

        var query = ["extended": extended.queryString()]
        query["translations"] = language

        guard var request = mutableRequest(forPath: "shows/\(id)/seasons/\(season)",
            withQuery: query,
            isAuthorized: false,
            withHTTPMethod: .GET) else { return nil }

        request.cachePolicy = .reloadIgnoringCacheData
        return performRequest(request: request,
                              completion: completion)
    }

    // MARK: - Comments

    /**
     Returns all top level comments for a season. Most recent comments returned first.
     
     📄 Pagination
     */
    @discardableResult
    public func getAllSeasonComments(showID id: ShowIds.TraktId, season: Int, pagination: Pagination? = nil, completion: @escaping CommentsCompletionHandler) -> URLSessionDataTaskProtocol? {
        var query: [String: String] = [:]

        // pagination
        if let pagination = pagination {
            for (key, value) in pagination.value() {
                query[key] = value
            }
        }

        guard var request = mutableRequest(forPath: "shows/\(id)/seasons/\(season)/comments",
                                           withQuery: query,
                                           isAuthorized: false,
                                           withHTTPMethod: .GET) else { return nil }
        request.cachePolicy = .reloadIgnoringCacheData
        return performRequest(request: request,
                              completion: completion)
    }

    // MARK: - Lists

    /**
     Returns all lists that contain this season. By default, `personal` lists are returned sorted by the most `popular`.

     📄 Pagination
     */
    @discardableResult
    public func getListsContainingSeason(showID id: ShowIds.TraktId, season: Int, listType: ListType? = nil, sortBy: ListSortType? = nil, pagination: Pagination? = nil, completion: @escaping paginatedCompletionHandler<TraktList>) -> URLSessionDataTaskProtocol? {
        var path = "shows/\(id)/seasons/\(season)/lists"
        if let listType = listType {
            path += "/\(listType)"

            if let sortBy = sortBy {
                path += "/\(sortBy)"
            }
        }

        var query: [String: String] = [:]

        // pagination
        if let pagination = pagination {
            for (key, value) in pagination.value() {
                query[key] = value
            }
        }

        guard let request = mutableRequest(forPath: path,
                                           withQuery: query,
                                           isAuthorized: false,
                                           withHTTPMethod: .GET) else { return nil }
        return performRequest(request: request,
                              completion: completion)
    }

    // MARK: - Ratings

    /**
     Returns rating (between 0 and 10) and distribution for a season.
     */
    @discardableResult
    public func getSeasonRatings(showID id: ShowIds.TraktId, season: Int, completion: @escaping RatingDistributionCompletionHandler) -> URLSessionDataTaskProtocol? {
        guard var request = mutableRequest(forPath: "shows/\(id)/seasons/\(season)/ratings",
                                           withQuery: [:],
                                           isAuthorized: false,
                                           withHTTPMethod: .GET) else { return nil }
        request.cachePolicy = .reloadIgnoringCacheData
        
        return performRequest(request: request,
                              completion: completion)
    }

    // MARK: - Stats

    /**
     Returns lots of season stats.
     */
    @discardableResult
    public func getSeasonStatistics(showID id: ShowIds.TraktId, season: Int, completion: @escaping statsCompletionHandler) -> URLSessionDataTaskProtocol? {
        guard var request = mutableRequest(forPath: "shows/\(id)/seasons/\(season)/stats",
                                           withQuery: [:],
                                           isAuthorized: false,
                                           withHTTPMethod: .GET) else { return nil }
        request.cachePolicy = .reloadIgnoringCacheData
        
        return performRequest(request: request,
                              completion: completion)
    }

    // MARK: - Watching

    /**
     Returns all users watching this season right now.
     */
    @discardableResult
    public func getUsersWatchingSeasons(showID id: ShowIds.TraktId, season: Int, completion: @escaping ObjectsCompletionHandler<User>) -> URLSessionDataTaskProtocol? {
        guard var request = mutableRequest(forPath: "shows/\(id)/seasons/\(season)/watching",
                                           withQuery: [:],
                                           isAuthorized: false,
                                           withHTTPMethod: .GET) else { return nil }
        request.cachePolicy = .reloadIgnoringCacheData
        
        return performRequest(request: request, completion: completion)
    }
    
    // MARK: - People
    
    /**
     ✨ **Extended Info**
     Returns all `cast` and `crew` for a show, including the `episode_count` for which they appears. Each `cast` member will have a `characters` array and a standard person object.
     The `crew` object will be broken up into `production`, `art`, `crew`, `costume & make-up`, `directing`, `writing`, `sound`, `camera`, `visual effects`, `lighting`, and `editing` (if there are people for those crew positions). Each of those members will have a `jobs` array and a standard `person` object.
     
     **Guest Stars**
     
     If you add `?extended=guest_stars` to the URL, it will return all guest stars that appeared in at least 1 episode of the show.
     
     **Note**: This returns a lot of data, so please only use this extended parameter if you actually need it!
     */
    @discardableResult
    public func getPeopleInSeason(showID id: ShowIds.TraktId, season: Int, extended: [ExtendedType] = [.min], completion: @escaping ObjectCompletionHandler<CastAndCrew<TVCastMember, TVCrewMember>>) -> URLSessionDataTaskProtocol? {
        guard let request = mutableRequest(forPath: "shows/\(id)/seasons/\(season)/people",
            withQuery: ["extended": extended.queryString()],
            isAuthorized: false,
            withHTTPMethod: .GET) else { return nil }
        return performRequest(request: request,
                              completion: completion)
    }
}
