import { NativeModules } from 'react-native';

type SdkCardPaymentType = {
  multiply(a: number, b: number): Promise<number>;
};

const { SdkCardPayment } = NativeModules;

export default SdkCardPayment as SdkCardPaymentType;
