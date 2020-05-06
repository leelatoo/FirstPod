//
//  MSALResultToAuthResultConverter.swift
//  TestApp
//
//  Created by Leeladevi Balasundaram on 4/30/20.
//  Copyright © 2020 Leeladevi Balasundaram. All rights reserved.
//

import UIKit
import MSAL

public class MSALResultToAuthResultConverter: NSObject
{
    public func convert(result : MSALResult) -> AuthResult
    {
        let authResult = AuthResult()
        authResult.accessToken = result.accessToken
        authResult.expiresOn = result.expiresOn
        authResult.extendedLifeTimeToken = result.extendedLifeTimeToken
        authResult.idToken = result.idToken
        authResult.scopes = result.scopes
        
        authResult.tenantProfile = convert(msalTenantProfile: result.tenantProfile)
        
        let accountId = AccountId(identifier: result.account.homeAccountId?.identifier,
                                  objectId: result.account.homeAccountId?.objectId,
                                  tenantId: result.account.homeAccountId?.tenantId)
        
        var tenantProfiles : [TenantProfile] = []
        if result.account.tenantProfiles != nil && result.account.tenantProfiles?.count ?? 0  > 0
        {
            for item in result.account.tenantProfiles!
            {
                tenantProfiles.append(convert(msalTenantProfile: item))
            }
        }
        authResult.account = Account(username: result.account.username,
                                     homeAccountId: accountId,
                                     environment: result.account.environment,
                                     tenantProfiles: tenantProfiles)
        
        authResult.uniqueId = result.tenantProfile.identifier

        authResult.authorityUrl = result.authority.url
        authResult.correlationId = result.correlationId
        
        return authResult
    }
    
    func convert(msalTenantProfile : MSALTenantProfile) -> TenantProfile
    {
        return TenantProfile(identifier: msalTenantProfile.identifier ?? "",
        tenantId: msalTenantProfile.tenantId ?? "",
        environment: msalTenantProfile.environment ?? "",
        isHomeTenantProfile: msalTenantProfile.isHomeTenantProfile,
        claims: msalTenantProfile.claims)
    }
}
