//
//  Account.swift
//  TestApp
//
//  Created by Leeladevi Balasundaram on 4/30/20.
//  Copyright © 2020 Leeladevi Balasundaram. All rights reserved.
//

import UIKit

public class Account {
    public var homeAccountId: AccountId?
    public var username: String?
    public var environment: String?
    public var TenantProfiles: [TenantProfile]?
    public var accountClaims: [String : String]?
    public var identifier: String?
//    private var lookupAccountIdentifier: MSIDAccountIdentifier?

    init(
        username: String?,
        homeAccountId: AccountId?,
        environment: String?,
        tenantProfiles: [TenantProfile]?
    ) {
        self.username = username
        self.homeAccountId = homeAccountId
        self.environment = environment
        self.TenantProfiles = tenantProfiles
    }

    /// Initialize an MSALAccount with MSIDAccount
    /// - Parameters:
    ///   - account:             MSID account
    ///   - createTenantProfile: Whether to create tenant profile based on the info of MSID account
    private init(
        msidAccount account: Account?,
        createTenantProfile: Bool
    ) {
    }

    private init(msalExternalAccount externalAccount: Account?) {
    }

    private func addTenantProfiles(_ tenantProfiles: [TenantProfile]?) {
    }
}

public class AccountId: NSObject
{
    /// Unique MSAL account identifier
    /// @note This is a non-displayable identifier and its format is not guaranteed. You should not make any assumptions about components or format of this identifier.
    public var identifier = ""
    /// Object id of the account in the tenant.
    /// Object id is the immutable identifier for an object in the Microsoft identity system, in this case, a user account. This ID uniquely identifies the user across applications - two different applications signing in the same user will receive the same value in the oid claim.
    public var objectId: String?
    /// An identifier for the AAD tenant that the account was acquired from
    public var tenantId: String?
    init(identifier: String?, objectId: String?, tenantId: String?)
    {
        self.identifier = identifier ?? ""
        self.objectId = objectId
        self.tenantId = tenantId
    }
    
}
