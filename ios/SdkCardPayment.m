#import <React/RCTBridgeModule.h>
#import <React/RCTViewManager.h>

@interface RCT_EXTERN_MODULE(SdkCardPayment, NSObject)

RCT_EXTERN_METHOD(createSingleUseToken:(NSString *)PublicKey withCardNumber:(NSString *)cardNumber withCardExpMonth:(NSString *)cardExpMonth withCardExpYear:(NSString *)cardExpYear withCardCvn:(NSString *)cardCvn withTransactionAmount:(float)transactionAmount withShouldAuthenticate:(BOOL)ShouldAuthenticate
                 withResolver:(RCTPromiseResolveBlock)resolve
                 withRejecter:(RCTPromiseRejectBlock)reject)
RCT_EXTERN_METHOD(createMultiUseToken:(NSString *)PublicKey withCardNumber:(NSString *)cardNumber withCardExpMonth:(NSString *)cardExpMonth withCardExpYear:(NSString *)cardExpYear withCardCvn:(NSString *)cardCvn withTransactionAmount:(float)transactionAmount withShouldAuthenticate:(BOOL)ShouldAuthenticate
                 withResolver:(RCTPromiseResolveBlock)resolve
                 withRejecter:(RCTPromiseRejectBlock)reject)
RCT_EXTERN_METHOD(createAuthentication:(NSString *)PublicKey withTokenId:(NSString *)tokenId withTransactionAmount:(float)transactionAmount withCurrency:(NSString *)currency
                 withResolver:(RCTPromiseResolveBlock)resolve
                 withRejecter:(RCTPromiseRejectBlock)reject)
@end
