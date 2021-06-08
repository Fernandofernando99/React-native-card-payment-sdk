package com.reactnativesdkcardpayment;

import androidx.annotation.NonNull;
import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Handler;
import android.os.Looper;

import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.module.annotations.ReactModule;
import com.google.gson.Gson;
import com.xendit.Models.Card;
import com.xendit.Models.Token;
import com.xendit.Models.XenditError;
import com.xendit.TokenCallback;
import com.xendit.Xendit;
import java.util.List;
import com.facebook.react.bridge.ActivityEventListener;

@ReactModule(name = SdkCardPaymentModule.NAME)
public class SdkCardPaymentModule extends ReactContextBaseJavaModule {
    public static final String NAME = "SdkCardPayment";

    public SdkCardPaymentModule(ReactApplicationContext reactContext) {
        super(reactContext);
    }

    @Override
    @NonNull
    public String getName() {
        return NAME;
    }

    // Example method
    // See https://reactnative.dev/docs/native-modules-android
    @ReactMethod
    public void multiply(int a, int b, Promise promise) {
        promise.resolve(a * b);
    }

    @ReactMethod
    public void createSingleUseToken(String publicKey, String cardNumber, String cardExpMonth, String cardExpYear, String cardCvn, int transactionAmount, boolean shouldAuthenticate, Promise promise) {
        Xendit xendit = new Xendit(getReactApplicationContext(), publicKey, getCurrentActivity());
        Card card = new Card(cardNumber, cardExpMonth, cardExpYear, cardCvn);
        Gson gson = new Gson();
        xendit.createSingleUseToken(card, transactionAmount, shouldAuthenticate, new TokenCallback() {
            @Override
            public void onSuccess(Token token) {
                // Handle successful tokenization
                String successResult = gson.toJson(token);
                promise.resolve(successResult);
            }

            @Override
            public void onError(XenditError xenditError) {
                // Handle error
                System.out.println("Tokenization ERROR " + xenditError.getErrorMessage());
                String errorResult = gson.toJson(xenditError);
                promise.resolve(errorResult);
            }
        });
    }

    public static native int nativeMultiply(int a, int b);
}
