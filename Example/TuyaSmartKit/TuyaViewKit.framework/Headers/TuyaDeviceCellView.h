//
//  TuyaDeviceDellView.h
//  TuyaViewSDK
//
//  Created by fengyu on 15/9/11.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import "TuyaBaseView.h"

@class TuyaDeviceCellView;

@protocol TuyaDeviceCellViewViewDelegate <NSObject>

-(void)deviceCellViewTap:(TuyaDeviceCellView *)deviceCellView;

@end

typedef enum {
    TuyaDeviceStatusOnline = 1,
    TuyaDeviceStatusOffline,
    TuyaDeviceStatusShareOnline,
    TuyaDeviceStatusShareOffline,
} TuyaDeviceStatus;

@interface TuyaDeviceCellView : UITableViewCell

@property(nonatomic,assign) NSObject<TuyaDeviceCellViewViewDelegate> *delegate;
@property(nonatomic,assign) BOOL isLastCell;

-(void)setDeviceStatus:(TuyaDeviceStatus)deviceStatus;
-(void)setDeviceIcon:(UIImage *)image;
-(void)setDeviceName:(NSString *)name;


@end
