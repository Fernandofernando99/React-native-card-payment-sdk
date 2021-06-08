import * as React from 'react';

import { StyleSheet, View, Text, Button, TextInput, Dimensions, Alert } from 'react-native';
import SdkCardPayment from 'react-native-sdk-card-payment';

export default function App() {
  const [result, setResult] = React.useState<string | undefined>('');
  const [cardNumber, setCardNumber] = React.useState<string>('');
  const [cardExpMonth, setCardExpMonth] = React.useState<string>('');
  const [cardExpYear, setCardExpYear] = React.useState<string>('');
  const [cardCvn, setCardCvn] = React.useState<string>('');
  const [transactionAmount, setTransactionAmount] = React.useState<string>('');
  const { height, width } = Dimensions.get('window');
  const [isTokenizeButtonDisabled, setTokenizeButtonDisabled] = React.useState<boolean>(true);
  /**
   * this key only for test transaction (not real), for your own apps, 
   * you can create your own key using xendit dashboard, 
   * store this on your server and get this public key when the page loaded
   * */ 
  const PUBLISHABLE_KEY = 'xnd_public_development_mPkileYzGpSKmgLqa5F0fts7zK6n9ZhHrrip92duBOHbE8xWKSUaZziXlZcZlE'
  const CVN_LENGTH = 3
  const CARD_EXP_MONTH_LENGTH = 2
  const CARD_EXP_YEAR_LENGTH = 4
  const CARD_NUMBER_MAX_LENGTH = 20

  // to be called when you want to perform tokenization
  const createTokenAndAuthenticate = async () => {
    const formattedAmount = Number(transactionAmount);
    try {
      const tokenizationResponse = await SdkCardPayment.createSingleUseToken(PUBLISHABLE_KEY, cardNumber, cardExpMonth, cardExpYear, cardCvn, formattedAmount, true);
      console.log("TOKEN =>>>",tokenizationResponse);
      setResult(JSON.stringify(tokenizationResponse));
    } catch (error) {
      console.log("ERROR =>>>>", error); 
    }
    
  }

  // to show last process response  
  const showLastResponse = () => {
    if (result) {
      Alert.alert("Response",result);
    } else {
      Alert.alert("Response","No response stored");
    }
  }

  React.useEffect(() => {
    if (cardCvn?.length === 3 && cardNumber?.length > 14 && cardExpMonth.length === 2 && cardExpYear.length === 4 && transactionAmount.length > 0) {
      setTokenizeButtonDisabled(false)
    } else {
      setTokenizeButtonDisabled(true)
    }
  }, [cardCvn, cardNumber, cardExpYear, cardExpMonth, transactionAmount])

  return (
    <View style={styles.container}>
      <Text style={{fontWeight: 'bold', fontSize: 18 }}>EXAMPLE APP</Text>
      <TextInput 
        onChangeText={setCardNumber}
        value={cardNumber}
        maxLength={CARD_NUMBER_MAX_LENGTH}
        placeholder="Input card number"
        keyboardType="numeric"
        style={{borderWidth: 1.0, width: width *0.55, height: height *0.05, fontWeight: 'bold', fontSize: 16, borderRadius: 5, marginBottom: 15, marginTop: 25, padding: 0, textAlign: 'center'}}
      />
      <View style={{flexDirection: 'row'}}>
        <TextInput 
          onChangeText={setCardExpMonth}
          value={cardExpMonth}
          placeholder="MM"
          keyboardType="numeric"
          maxLength={CARD_EXP_MONTH_LENGTH}
          style={{borderWidth: 1.0, borderRadius: 5,  width: width *0.15, margin: 0, padding: 0, textAlign: 'center'}}
        />
        <Text style={{fontWeight: 'bold', fontSize: 18, marginLeft: 5, marginRight: 5, textAlignVertical: 'center' }}>/</Text>
        <TextInput 
          onChangeText={setCardExpYear}
          value={cardExpYear}
          placeholder="YYYY"
          keyboardType="numeric"
          maxLength={CARD_EXP_YEAR_LENGTH}
          style={{borderWidth: 1.0, width: width *0.15, borderRadius: 5, margin: 0, padding: 0, textAlign: 'center'}}
        />
      </View>
      <TextInput 
          onChangeText={setCardCvn}
          value={cardCvn}
          placeholder="CVN/CVV"
          keyboardType="numeric"
          maxLength={CVN_LENGTH}
          style={{borderWidth: 1.0, width: width *0.25, borderRadius: 5, margin: 0, marginTop: 5, padding: 0, textAlign: 'center'}}
        />
      <TextInput 
          onChangeText={setTransactionAmount}
          value={transactionAmount}
          placeholder="Purchase Amount"
          keyboardType="numeric"
          style={{borderWidth: 1.0, width: width *0.45, height: height *0.05, borderRadius: 5, margin: 0, marginTop: 15, padding: 0, textAlign: 'center'}}
        />
      <View style={{margin: 10}}>
        <Button 
          onPress={() => createTokenAndAuthenticate()}
          title="Create Token And Authenticate"
          disabled={isTokenizeButtonDisabled}
        />
      </View>
      <View style={{margin: 10}}>
        <Button 
          onPress={() => showLastResponse()}
          title="Show Last Response"
        />
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  box: {
    width: 60,
    height: 60,
    marginVertical: 20,
  },
});
