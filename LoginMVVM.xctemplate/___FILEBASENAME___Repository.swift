//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import Alamofire

class ___VARIABLE_mainClassName___Repository {
    
    typealias LoginResponse = ((_ response: UserModel?, _ error: String?) -> ())
    
    func loginInServer(withUsername username:String, password:String, loginResponse:@escaping LoginResponse) {
        let parameters: Parameters = ["email": username, "password": password]
        let url = ""
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { (response) in
                switch response.result {
                case .success:
                    let user = try! JSONDecoder().decode(UserModel.self, from: response.data!)
                    loginResponse(user, nil)
                    break
                case .failure(let error):
                    loginResponse(nil, Utils.getErrorMessage(from: response.data, with: error))
                    break
                }
        }
    }
    
}
