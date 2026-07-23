//
//  InAppPurchases.swift
//
//  Created on 2026-07-23.
//

import Foundation
import Observation
import StoreKit

@MainActor @Observable public final class InAppPurchases {
    
    public var boughtNonConsumable: Bool = false
    
    public init() {
        Task(priority: .background) {
            for await verificationResult in Transaction.unfinished {
                await handle(updatedTransaction: verificationResult)
            }
            for await verificationResult in Transaction.currentEntitlements {
                await handle(updatedTransaction: verificationResult)
            }
            for await verificationResult in Transaction.updates {
                await handle(updatedTransaction: verificationResult)
            }
        }
    }
    
    private func handle(updatedTransaction verificationResult: VerificationResult<Transaction>) async {
        // The code below handles only verified transactions; handle unverified transactions based on your business model.
        guard case .verified(let transaction) = verificationResult else { return }

        if let _ = transaction.revocationDate {
            // Remove access to the product identified by `transaction.productID`.
            // `Transaction.revocationReason` provides details about the revoked transaction.
            guard transaction.productID == "com.merchv.podcasts.removeads" else { return }
            let reason = transaction.revocationReason
            print(reason)
            self.boughtNonConsumable = false
            await transaction.finish()
            return
        } else {
            // Provide access to the product identified by transaction.productID.
            guard transaction.productID == "com.merchv.podcasts.removeads" else { return }
            print("transaction ID \(transaction.id), product ID \(transaction.productID)")
                boughtNonConsumable = true
            await transaction.finish()
            return
        }
    }
}
