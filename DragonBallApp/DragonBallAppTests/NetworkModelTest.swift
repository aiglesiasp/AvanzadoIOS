//
//  NetworkModelTest.swift
//  DragonBallAppTests
//
//  Created by Aitor Iglesias Pubill on 21/11/22.
//

import XCTest
@testable import DragonBallApp


enum errorMock: Error {
    case mockCase
}


final class NetworkModelTest: XCTestCase {

    private var urlSessionMock: URLSessionMock!
    private var sut: NetworkModel!
    
    override func setUpWithError() throws {
        
        urlSessionMock = URLSessionMock()
        sut = NetworkModel(urlSession: urlSessionMock)
    }

    override func tearDownWithError() throws {
       sut = nil
    }
    
    
    //-------------------------------------------------------------//
    // MARK: TEST PARA EL LOGIN
    //-------------------------------------------------------------//
    //MARK: - TEST LOGIN WITH NO DATA -
    func testLoginFailWithNoData() {
        var error: NetworkError?
        //GIVEN - Creamos variables
        urlSessionMock.data = nil
        //WHEN - Llamamos al LOGIN
        sut.login(user: "", password: "") { _ , networkError in
            error = networkError
        }
        //THEN -
        XCTAssertEqual(error, .noData)
    }
    
    //MARK: - TEST LOGIN WITH ERROR -
    func testLoginFailWithError() {
        var error: NetworkError?
        //GIVEN - Creamos variables
        urlSessionMock.data = nil
        urlSessionMock.error = errorMock.mockCase
        //WHEN - Llamamos al LOGIN
        sut.login(user: "", password: "") { _ , networkError in
            error = networkError
        }
        //THEN -
        XCTAssertEqual(error, .other)
    }

    
    //MARK: - TEST LOGIN SUCCES
    func testLoginSuccessWithMockToken() {
        var error: NetworkError?
        var retrievedToken: String?
        
        //GIVEN - Creamos variables
        urlSessionMock.data = "TokenString".data(using: .utf8)
        urlSessionMock.response = HTTPURLResponse(url: URL(string: "http")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        //WHEN - Llamamos al LOGIN
        sut.login(user: "", password: "") { token , networkError in
            error = networkError
            retrievedToken = token
        }
        //THEN -
        XCTAssertEqual(retrievedToken, "TokenString",  "should have received a token")
        XCTAssertNil(error, "there should be no error")
    }
    
    //MARK: - TEST LOGIN WITH ERROR CODE NIL
    func testLoginFailWithErrorCodeNil() {
        var error: NetworkError?
        
        //GIVEN - Creamos variables
        urlSessionMock.data = "TokenString".data(using: .utf8)
        urlSessionMock.response = nil
        //WHEN - Llamamos al LOGIN
        sut.login(user: "", password: "") { _ , networkError in
            error = networkError
        }
        //THEN -
        //XCTAssertEqual(retrievedToken, "TokenString",  "should have received a token")
        XCTAssertEqual(error, .errorCode(code: nil))
    }
    
    //MARK: - TEST LOGIN WITH ERROR CODE
    func testLoginFailWithErrorCode() {
        var error: NetworkError?
        
        //GIVEN - Creamos variables
        urlSessionMock.data = "TokenString".data(using: .utf8)
        urlSessionMock.response = HTTPURLResponse(url: URL(string: "http")!, statusCode: 404, httpVersion: nil, headerFields: nil)
        //WHEN - Llamamos al LOGIN
        sut.login(user: "", password: "") { _ , networkError in
            error = networkError
        }
        //THEN -
        //XCTAssertEqual(retrievedToken, "TokenString",  "should have received a token")
        XCTAssertEqual(error, .errorCode(code: 404))
    }
    
    
    
    //-------------------------------------------------------------//
    // MARK: TEST PARA EL GET HEROES
    //-------------------------------------------------------------//
    //MARK: - FUNCION TEST GET HEROES OKEY -
    func testGetHeroesSuccess() {
        var retrievedHeroes: [Hero]?
        var error: NetworkError?
        //GIVEN - Creamos variables
        sut.token = "testToken"
        urlSessionMock.data = getHeroesData(resourceName: "heroes")
        urlSessionMock.response = HTTPURLResponse(url: URL(string: "http")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        //When
        sut.getHeroes { heroes, networkError in
            error = networkError
            retrievedHeroes = heroes
        }
        //THEN
        XCTAssertNotNil(urlSessionMock.data)
        XCTAssertNil(error, "there should be no error")
        XCTAssertTrue((retrievedHeroes?.count ?? 0) > 0 , "There should be heroes")
        XCTAssertEqual(retrievedHeroes?.first?.id, "Hero ID", "should be the same hero as in the json file")
    }
    
    //MARK: - FUNCION TEST GET HEROES OKEY SIN HEROES-
    func testGetHeroesSuccessWithNoHeroes() {
        var retrievedHeroes: [Hero]?
        var error: NetworkError?
        //GIVEN - Creamos variables
        sut.token = "testToken"
        urlSessionMock.data = getHeroesData(resourceName: "noHeroes")
        urlSessionMock.response = HTTPURLResponse(url: URL(string: "http")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        //When
        sut.getHeroes { heroes, networkError in
            error = networkError
            retrievedHeroes = heroes
        }
        //THEN
        XCTAssertNotNil(urlSessionMock.data)
        XCTAssertNil(error, "there should be no error")
        XCTAssertNotNil(retrievedHeroes)
        XCTAssertEqual(retrievedHeroes?.count, 0)
    }
    
    
    //MARK: - TEST GET HEROES WITH NO DATA -
    func testGetHeroesFailWithNoData() {
        var error: NetworkError?
        //GIVEN - Creamos variables
        urlSessionMock.data = nil
        //WHEN - Llamamos al LOGIN
        sut.token = "testToken"
        sut.getHeroes { _, networkError in
            error = networkError
        }
        //THEN -
        XCTAssertEqual(error, .noData)
    }
    
    //MARK: - TEST GET HEROES WITH ERROR -
    func testGetHeroesFailWithError() {
        var error: NetworkError?
        //GIVEN - Creamos variables
        urlSessionMock.data = nil
        urlSessionMock.error = errorMock.mockCase
        //WHEN - Llamamos al LOGIN
        sut.token = "testToken"
        sut.getHeroes { _, networkError in
            error = networkError
        }
        //THEN -
        XCTAssertEqual(error, .other)
    }
    
    //MARK: - TEST GET HEROES WITH TOKEN NIL
    func testGetHeroesFailWithTokenNil() {
        var error: NetworkError?
        
        //GIVEN - Creamos variables
        urlSessionMock.data = "TokenString".data(using: .utf8)
        urlSessionMock.response = nil
        //WHEN - Llamamos al LOGIN
        sut.token = nil
        sut.getHeroes { _, networkError in
            error = networkError
        }
        //THEN -
        //XCTAssertEqual(retrievedToken, "TokenString",  "should have received a token")
        XCTAssertEqual(error, .other)
    }

    
    //MARK: - TEST GET HEROES WITH ERROR CODE NIL
    func testGetHeroesFailWithErrorCodeNil() {
        var error: NetworkError?
        
        //GIVEN - Creamos variables
        urlSessionMock.data = "TokenString".data(using: .utf8)
        urlSessionMock.response = nil
        //WHEN - Llamamos al LOGIN
        sut.token = "testToken"
        sut.getHeroes { _, networkError in
            error = networkError
        }
        //THEN -
        //XCTAssertEqual(retrievedToken, "TokenString",  "should have received a token")
        XCTAssertEqual(error, .errorCode(code: nil))
    }
    
    //MARK: - TEST GET HEROES WITH ERROR CODE
    func testGetHeroesFailWithErrorCode() {
        var error: NetworkError?
        
        //GIVEN - Creamos variables
        urlSessionMock.data = "TokenString".data(using: .utf8)
        urlSessionMock.response = HTTPURLResponse(url: URL(string: "http")!, statusCode: 404, httpVersion: nil, headerFields: nil)
        //WHEN - Llamamos al LOGIN
        sut.token = "testToken"
        sut.getHeroes { _ , networkError in
            error = networkError
        }
        //THEN -
        //XCTAssertEqual(retrievedToken, "TokenString",  "should have received a token")
        XCTAssertEqual(error, .errorCode(code: 404))
    }
}






extension NetworkModelTest {
    func getHeroesData (resourceName: String) -> Data? {
        let bundle = Bundle(for: NetworkModelTest.self)
        
        guard let path = bundle.path(forResource: resourceName, ofType: "json") else {
            return nil
            
        }
        
        return try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        
    }
}


