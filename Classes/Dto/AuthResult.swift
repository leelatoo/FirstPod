//
//  AuthResult.swift
//  TestApp
//
//  Created by Leeladevi Balasundaram on 4/30/20.
//  Copyright © 2020 Leeladevi Balasundaram. All rights reserved.
//

import Foundation

public class AuthResult: NSObject {
// MARK: - Token response
    public var accessToken = ""
    public var expiresOn: Date!
    public var extendedLifeTimeToken = false
//    public var tenantId: String?
    public var idToken: String?
    public var scopes: [String] = []
// MARK: - Account information
    public var tenantProfile: TenantProfile!
    public var account: Account!
    public var uniqueId: String?
// MARK: - Request information
    public var authorityUrl: URL!
    public var correlationId: UUID!
}
