// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

public final class Catalyst: Sendable {
    private let client: CatalystSwift

    init(client: CatalystSwift) {
        self.client = client
    }

    public func timelineHome(since: String? = nil, until: String? = nil) async throws -> [Status] {
        var parameters: [String: String] = [:]

        if since != nil {
            parameters["since"] = since
        }
        if until != nil {
            parameters["until"] = until
        }

        let obj: Statuses = try await client.get(endpoint: "/catalyst/v1/timeline/home", parameters: parameters)
        return obj.statuses
    }

    public func timelineFirehose(since: String? = nil, until: String? = nil) async throws -> [Status] {
        var parameters: [String: String] = [:]

        if since != nil {
            parameters["since"] = since
        }
        if until != nil {
            parameters["until"] = until
        }

        let obj: Statuses = try await client.get(endpoint: "/catalyst/v1/timeline/firehose", parameters: parameters)
        return obj.statuses
    }

    public func timelineByUser(username: String, since: String? = nil, until: String? = nil) async throws -> [Status] {
        var parameters: [String: String] = [:]

        if since != nil {
            parameters["since"] = since
        }
        if until != nil {
            parameters["until"] = until
        }

        let obj: Statuses = try await client.get(endpoint: "/catalyst/v1/timeline/user/by/username/\(username)", parameters: parameters)
        return obj.statuses
    }

    public func timelineByUserSingle(username: String, since: String? = nil, until: String? = nil) async throws -> [Status] {
        var parameters: [String: String] = [:]

        if since != nil {
            parameters["since"] = since
        }
        if until != nil {
            parameters["until"] = until
        }

        let obj: Statuses = try await client.get(endpoint: "/catalyst/v1/timeline/user/by/username/\(username)/gallery", parameters: parameters)
        return obj.statuses
    }

    public func relationships(username: String) async throws -> Relationships {
        return try await client.get(endpoint: "/catalyst/v1/relationships/\(username)", parameters: [:])
    }

    public func follow(id: String) async throws {
        var parameters: [String: String] = [
            "userId": id,
        ]

        let obj: EmptyResponse = try await client.post(endpoint: "/catalyst/v1/relationships", parameters: parameters)
    }

    public func unfollow(id: String) async throws {
        var parameters: [String: String] = [
            "userId": id,
        ]

        let obj: EmptyResponse = try await client.delete(endpoint: "/catalyst/v1/relationships", parameters: parameters)
    }

    public func availableReactions() async throws -> [AvailableReaction] {
        let obj: [AvailableReaction] = try await client.get(endpoint: "/catalyst/v1/reactions", parameters: [:])
        return obj
    }

    public func reactionsByStatus(id: String) async throws -> [String: Reaction] {
        let obj: ReactionWrapped = try await client.get(endpoint: "/catalyst/v1/status/\(id)/reactions", parameters: [:])
        return obj.reactions
    }

    public func incrementReactionByStatys(id: String, symbol: String) async throws -> ReactedValue {
        let obj: ReactedValue = try await client.post(endpoint: "/catalyst/v1/status/\(id)/reactions/\(symbol)", parameters: [:])
        return obj
    }

    public func decrementReactionByStatys(id: String, symbol: String) async throws -> ReactedValue {
        let obj: ReactedValue = try await client.delete(endpoint: "/catalyst/v1/status/\(id)/reactions/\(symbol)", parameters: [:])
        return obj
    }
}
