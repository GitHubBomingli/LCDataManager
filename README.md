# LCDataManager
Pass values or events<br>
任意位置传递值或事件

## 调用
LCDataManager.framework

## 方法
```
/**
 存值

 @param object 值
 @param key 区别值的唯一标识符
 */
+ (void)save:(id)object forKey:(NSString *)key;

/**
 取值，或值发生改变时回调（并行、异步）

 @param key 区别值的唯一标识符
 @param reuseIdentifier 复用标识符
 @param changed 回调：并行队列、异步执行（多线程、一起执行），刷新UI请在dispatch_get_main_queue()队列中执行
 */
+ (void)valueChangedForKey:(NSString *)key reuseIdentifier:(NSString *)reuseIdentifier changed:(void(^)(id object, id oldObject))changed;

/**
 根据复用标识符放弃指定回调

 @param reuseIdentifier 复用标识符
 */
+ (void)resignCallbackWithReuseIdentifier:(NSString *)reuseIdentifier;
```

## 示例
### 取值，或值发生改变时回调
```
[LCDataManager valueChangedForKey:@"messageKey" reuseIdentifier:@"reuseIdentifierForSecondViewController" changed:^(id object, id oldObject) {
        if (object) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.messageLabel.text = (NSString *)object;
            });
        }
    }];
```
### 存值，生命周期到应用结束
```
[LCDataManager save:self.textField.text forKey:@"messageKey"];
```
### 注销指定回调
```
[LCDataManager resignCallbackWithReuseIdentifier:@"reuseIdentifierForSecondViewController"];
```

## Note
1、如果同时存在多个回调获取同一个key对应的值，则当该值发生改变时，会并行异步分发出去。因此，回调后在异线程中，如果是需要刷新页面，则需要回调主线程<br>
2、reuseIdentifier：是回调的复用标识符，如果多个回调的reuseIdentifier相同，则最后编译的会替换之前的回调
