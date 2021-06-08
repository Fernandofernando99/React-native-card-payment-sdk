import Xendit

@objc(SdkCardPayment)
class SdkCardPayment: NSObject {

    @objc(multiply:withB:withResolver:withRejecter:)
    func multiply(a: Float, b: Float, resolve:RCTPromiseResolveBlock,reject:RCTPromiseRejectBlock) -> Void {
        resolve(a*b)
    }

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
                // let jsonData = try! JSONSerialization.data(withJSONObject:errorResult, options: JSONSerialization.WritingOptions()) as NSData
                // let jsonString = NSString(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue) as! String
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
