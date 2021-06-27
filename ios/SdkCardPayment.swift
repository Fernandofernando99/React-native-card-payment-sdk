import Xendit

@objc(SdkCardPayment)
class SdkCardPayment: NSObject {

    @objc(createSingleUseToken:withCardNumber:withCardExpMonth:withCardExpYear:withCardCvn:withTransactionAmount:withShouldAuthenticate:withResolver:withRejecter:)
    func createSingleUseToken(publicKey: String, cardNumber: String, cardExpMonth: String, cardExpYear: String, cardCvn: String,  transactionAmount: Float, shouldAuthenticate: Bool, resolve: @escaping RCTPromiseResolveBlock,reject: @escaping RCTPromiseRejectBlock) -> Void {
        let rootViewController = UIApplication.shared.delegate?.window??.rootViewController
        let cardData = CardData()
        cardData.cardNumber = cardNumber
        cardData.cardExpMonth = cardExpMonth
        cardData.cardExpYear = cardExpYear
        cardData.cardCvn = cardCvn
        cardData.isMultipleUse = false
        cardData.amount = transactionAmount as NSNumber
        Xendit.publishableKey = publicKey
        let encoder = JSONEncoder()
        let errorResult:NSMutableDictionary = NSMutableDictionary()
        Xendit.createToken(fromViewController: rootViewController!, cardData: cardData, shouldAuthenticate: shouldAuthenticate) { 
            (token, error) in
            if (error != nil ) {
                // Handle error. Error is of type XenditError
                errorResult.setValue(error!.errorCode, forKey: "errorCode")
                errorResult.setValue(error!.message, forKey: "message")
                return
            } else {
                encoder.outputFormatting = .prettyPrinted
                encoder.keyEncodingStrategy = .convertToSnakeCase
                let successJsonData = try? encoder.encode(token);
                let sucessJsonString = String(data: successJsonData!, encoding: .utf8)
                resolve(sucessJsonString!)
            }
        }
    }

    @objc(createMultiUseToken:withCardNumber:withCardExpMonth:withCardExpYear:withCardCvn:withTransactionAmount:withShouldAuthenticate:withResolver:withRejecter:)
    func createMultiUseToken(publicKey: String, cardNumber: String, cardExpMonth: String, cardExpYear: String, cardCvn: String,  transactionAmount: Float, shouldAuthenticate: Bool, resolve: @escaping RCTPromiseResolveBlock,reject: @escaping RCTPromiseRejectBlock) -> Void {
        let rootViewController = UIApplication.shared.delegate?.window??.rootViewController
        let cardData = CardData()
        cardData.cardNumber = cardNumber
        cardData.cardExpMonth = cardExpMonth
        cardData.cardExpYear = cardExpYear
        cardData.cardCvn = cardCvn
        cardData.isMultipleUse = true
        cardData.amount = transactionAmount as NSNumber
        Xendit.publishableKey = publicKey
        let encoder = JSONEncoder()
        let errorResult:NSMutableDictionary = NSMutableDictionary()
        Xendit.createToken(fromViewController: rootViewController!, cardData: cardData, shouldAuthenticate: shouldAuthenticate) { 
            (token, error) in
            if (error != nil ) {
                // Handle error. Error is of type XenditError
                errorResult.setValue(error!.errorCode, forKey: "errorCode")
                errorResult.setValue(error!.message, forKey: "message")
                return
            } else {
                encoder.outputFormatting = .prettyPrinted
                encoder.keyEncodingStrategy = .convertToSnakeCase
                let successJsonData = try? encoder.encode(token);
                let sucessJsonString = String(data: successJsonData!, encoding: .utf8)
                resolve(sucessJsonString!)
            }
        }
    }

    @objc(createAuthentication:withTokenId:withTransactionAmount:withCurrency:withResolver:withRejecter:)
    func createAuthentication(publicKey: String, tokenId: String, transactionAmount: Float, currency: String, resolve: @escaping RCTPromiseResolveBlock,reject: @escaping RCTPromiseRejectBlock) -> Void {
        let rootViewController = UIApplication.shared.delegate?.window??.rootViewController
        Xendit.publishableKey = publicKey
        let amount = transactionAmount as NSNumber
        let encoder = JSONEncoder()
        let errorResult:NSMutableDictionary = NSMutableDictionary()
        Xendit.createAuthentication(fromViewController: rootViewController!, tokenId: tokenId, amount: amount) { 
            (token, error) in
            if (error != nil ) {
                // Handle error. Error is of type XenditError
                errorResult.setValue(error!.errorCode, forKey: "errorCode")
                errorResult.setValue(error!.message, forKey: "message")
                return
            } else {
                encoder.outputFormatting = .prettyPrinted
                encoder.keyEncodingStrategy = .convertToSnakeCase
                let successJsonData = try? encoder.encode(token);
                let sucessJsonString = String(data: successJsonData!, encoding: .utf8)
                resolve(sucessJsonString!)
            }
        }
    }
}
