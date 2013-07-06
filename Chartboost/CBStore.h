//
//  CBStore.h
//  Chartboost
//
//  Created by Kenneth Ballenegger on 12/6/12.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef enum {
    kCBStorePurchaseStatusSuccessful = 1,
    kCBStorePurchaseStatusInsufficientFunds = 2,
    kCBStorePurchaseStatusIAPUnsuccessful = 3,
    kCBStorePurchaseStatusUnsuccessful = 0
} CBStorePurchaseStatus;

typedef void(^CBStorePurchaseCallback)(CBStorePurchaseStatus status, NSDictionary *item);


typedef enum {
    kCBStoreViewStatusLoading,
    kCBStoreViewStatusLoaded,
    kCBStoreViewStatusChanged,
    kCBStoreViewStatusFailed,
    kCBStoreViewStatusCachedContent
} CBStoreViewStatus;

typedef void(^CBStoreViewCallback)(CBStoreViewStatus status, NSArray *items, NSError *error);
typedef void (^CBStoreBalancesCallback)(NSDictionary *balances);





@interface CBStore : NSObject


+ (CBStore *)sharedStore;

- (void)cacheStoreView:(NSString *)view;


- (void)earn:(double)amount forCurrency:(NSString *)currency;
- (void)earn:(double)amount forCurrency:(NSString *)currency
        meta:(NSDictionary *)meta;

- (void)spend:(double)amount forCurrency:(NSString *)currency;
- (void)spend:(double)amount forCurrency:(NSString *)currency
         meta:(NSDictionary *)meta;

- (void)purchaseItem:(NSDictionary *)item safely:(BOOL)safely
            callback:(CBStorePurchaseCallback)callback;

- (void)subscribeToBalancesWhileAlive:(id)object
                             callback:(CBStoreBalancesCallback)callback;

- (void)subscribeToStoreView:(NSString *)view whileAlive:(id)object
         triggersImmediately:(BOOL)triggersImmediately
                    callback:(CBStoreViewCallback)callback;
- (void)subscribeToStoreView:(NSString *)view whileAlive:(id)object
                    callback:(CBStoreViewCallback)callback;

- (NSString *)localizedPriceForItem:(NSDictionary *)itemDictionary;

@end
