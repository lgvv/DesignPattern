/// Copyright (c) 2019 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import MapKit
import YelpAPI

/* 1.
 YLPClient를 확장하고 BusinessSearchClient 상속받는다.
 왜냐하면 search(with:term:limit:offset:success:failure:)를 구현해야 하기 때문에!
 */
extension YLPClient: BusinessSearchClient {
  
  public func search(with coordinate: CLLocationCoordinate2D,
                     term: String,
                     limit: UInt,
                     offset: UInt,
                     success: @escaping (([Business]) -> Void),
                     failure: @escaping ((Error?) -> Void)) {
    /* 2.
     검색을 수행하려면 전달된 CLocation 좌표 2D를 YLP 좌표로 변환하고 YLP 클라이언트에서
     검색을 호출한다.
     */
    let yelpCoordinate = YLPCoordinate(
      latitude: coordinate.latitude,
      longitude: coordinate.longitude)
    
    search(
      with: yelpCoordinate,
      term: term,
      limit: limit,
      offset: offset,
      sort: .bestMatched,
      completionHandler: { (searchResult, error) in
        
        /* 3.
         completionHandler에서 검색 결과가 있고 오류가 없는지 확인한다.
         오류가 있다면 failure를 호출한다.
         */
        guard let searchResult = searchResult,
              error == nil else {
                failure(error)
                return
              }
        
        /* 4.
         성공하는 경우 searchResult.businesss에서 adaptToBusiness()를 호출하여
         YLPBusiness 어레이를 Business 어레이로 변환합니다.
         */
        let businesses =
        searchResult.businesses.adaptToBusinesses()
        success(businesses)
      })
  }
}

/* 5.
 배열의 원소가 YLPBusiness일때 사용할 수 있는 extension을 생성한다.
 이것은 YLPBusiness -> Business array로 편리하게 바꿀 수 있게끔 제공한다.
 */
extension Array where Element: YLPBusiness {
  
  func adaptToBusinesses() -> [Business] {
    
    return compactMap { yelpBusiness in
      guard let yelpCoordinate =
              yelpBusiness.location.coordinate else {
                return nil
              }
      let coordinate = CLLocationCoordinate2D(
        latitude: yelpCoordinate.latitude,
        longitude: yelpCoordinate.longitude)
      
      return Business(name: yelpBusiness.name,
                      rating: yelpBusiness.rating,
                      location: coordinate)
    }
  }
}
