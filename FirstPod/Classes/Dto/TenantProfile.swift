//
//  TenantProfile.swift
//  TestApp
//
//  Created by Leeladevi Balasundaram on 4/30/20.
//  Copyright © 2020 Leeladevi Balasundaram. All rights reserved.
//

import UIKit

public class TenantProfile: NSObject
{
     init(identifier: String, tenantId: String, environment: String, isHomeTenantProfile: Bool, claims: [String : Any]?) {
            super.init()

            self.identifier = identifier
            self.tenantId = tenantId
            self.environment = environment
            self.isHomeTenantProfile = isHomeTenantProfile
            self.claims = claims
        }
    
// MARK: - Getting account identifiers
    public var identifier: String?
    public var environment: String?
    public var tenantId: String?
    public var isHomeTenantProfile = false
// MARK: - Reading id_token claims
   public var claims: [String : Any?]?
}
