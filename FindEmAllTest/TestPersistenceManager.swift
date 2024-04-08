//
//  TestPersistenceManager.swift
//  FindEmAllTest
//
//  Created by Porori on 4/8/24.
//

import XCTest
@testable import FindEmAll

final class TestPersistenceManager: XCTestCase {
    
    var validator: PersistenceValidator!
    var manager: PersistenceManager!
    
    // Test instance created
    override func setUp() {
        validator = PersistenceValidator()
        manager = PersistenceManager.shared
    }
    
    // Test instance removed
    override func tearDown() {
        validator = nil
        manager = nil
    }
    
    func testDataPersistenceSuccessful() {
        // Arrange
        let pokemonId = 10
        let failId = 9
        
        // Act
        manager.savePokeData(pokemonId)
        
        // Assert
        /// Fail Test
        let failValidation = validator.hasSavedData(id: pokemonId, testingNumber: failId)
        XCTAssertTrue(failValidation, "데이터가 올바르게 저장되지 않았습니다")
        
        /// Pass Test
        let validation = validator.hasSavedData(id: pokemonId, testingNumber: pokemonId)
        XCTAssertTrue(validation, "데이터가 올바르게 저장되었습니다.")
    }

}
