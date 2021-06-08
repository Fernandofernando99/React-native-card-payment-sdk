import { NativeModules } from 'react-native';

type SdkCardPaymentType = {
  createSingleUseToken(publicKey: String, cardNumber: String, cardExpMonth: String, cardExpYear: String, cardCvn: String,  transactionAmount: number, shouldAuthenticate: boolean): Promise<object>;
};

const { SdkCardPayment } = NativeModules;
const sdkPackage = { ...SdkCardPayment};

export default sdkPackage as SdkCardPaymentType;
