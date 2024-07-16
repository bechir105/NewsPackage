import XCTest
@testable import NewsPackage

final class NewsPackageTests: XCTestCase {
    func testFetchTopHeadlines() {
        let newsManager = NewsManager(apiKey: "9acbb09893ca4c0c95759c1842583feb")
        
        let expectation = self.expectation(description: "Fetching top headlines")
        
        newsManager.fetchTopHeadlines { articles in
            XCTAssertNotNil(articles, "Articles should not be nil")
            XCTAssertGreaterThan(articles?.count ?? 0, 0, "Should fetch at least one article")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
}
