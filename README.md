# react-native-sdk-card-payment

React native sdk for handling card payment transaction

## Installation

```sh
npm install react-native-sdk-card-payment
```

## Usage

```js
import SdkCardPayment from "react-native-sdk-card-payment";

// ...

const result = await SdkCardPayment.createSingleUseToken(
        PUBLISHABLE_KEY,
        cardNumber,
        cardExpMonth,
        cardExpYear,
        cardCvn,
        formattedAmount,
        true
      );
```

## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## License

MIT
