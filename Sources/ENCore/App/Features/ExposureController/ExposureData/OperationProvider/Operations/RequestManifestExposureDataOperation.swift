/*
 * Copyright (c) 2020 De Staat der Nederlanden, Ministerie van Volksgezondheid, Welzijn en Sport.
 *  Licensed under the EUROPEAN UNION PUBLIC LICENCE v. 1.2
 *
 *  SPDX-License-Identifier: EUPL-1.2
 */

import Combine
import Foundation

struct ApplicationManifest: Codable {
    let exposureKeySetsIdentifiers: [String]
    let resourceBundleIdentifier: String
    let riskCalculationParametersIdentifier: String
    let appConfigurationIdentifier: String
    let creationDate: Date
}

final class RequestAppManifestDataOperation: ExposureDataOperation {
    typealias Result = ApplicationManifest

    private let defaultRefreshFrequency = 60 * 60 * 4 // 4 hours

    init(networkController: NetworkControlling,
         storageController: StorageControlling) {
        self.networkController = networkController
        self.storageController = storageController
    }

    // MARK: - ExposureDataOperation

    func execute() -> AnyPublisher<ApplicationManifest, ExposureDataError> {
        let updateFrequency = retrieveManifestUpdateFrequency()

        if let manifest = retrieveStoredManifest(), manifest.isValid(forUpdateFrequency: updateFrequency) {
            return Just(manifest)
                .setFailureType(to: ExposureDataError.self)
                .eraseToAnyPublisher()
        }

        return networkController
            .applicationManifest
            .mapError { $0.asExposureDataError }
            .flatMap(store(manifest:))
            .eraseToAnyPublisher()
    }

    // MARK: - Private

    private func retrieveManifestUpdateFrequency() -> Int? {
        // TODO: Get from appConfig once fetched
        return defaultRefreshFrequency
    }

    private func retrieveStoredManifest() -> ApplicationManifest? {
        return storageController.retrieveObject(identifiedBy: ExposureDataStorageKey.appManifest,
                                                ofType: ApplicationManifest.self)
    }

    private func store(manifest: ApplicationManifest) -> AnyPublisher<ApplicationManifest, ExposureDataError> {
        return Future { promise in
            self.storageController.store(object: manifest,
                                         identifiedBy: ExposureDataStorageKey.appManifest,
                                         completion: { _ in
                                             promise(.success(manifest))
            })
        }
        .eraseToAnyPublisher()
    }

    private let networkController: NetworkControlling
    private let storageController: StorageControlling
}

extension ApplicationManifest {
    func isValid(forUpdateFrequency updateFrequency: Int?) -> Bool {
        guard let updateFrequency = updateFrequency else {
            // no update frequency, deem as valid
            return true
        }

        return Date(timeIntervalSinceNow: TimeInterval(updateFrequency)) >= Date()
    }
}
