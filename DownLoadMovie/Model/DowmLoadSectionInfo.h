

#import <Foundation/Foundation.h>
#import "DownLoadTabHeaderView.h"
#import "MemDownLoadSectionModel.h"



@interface DowmLoadSectionInfo : NSObject 

@property (assign, nonatomic) BOOL open;
@property (strong, nonatomic) MemDownLoadSectionModel* selectPlay;
@property (strong, nonatomic) DownLoadTabHeaderView* headerView;

@property (nonatomic,strong) NSMutableArray *rowHeights;

- (NSUInteger)countOfRowHeights;
- (id)objectInRowHeightsAtIndex:(NSUInteger)idx;
- (void)insertObject:(id)anObject inRowHeightsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromRowHeightsAtIndex:(NSUInteger)idx;
- (void)replaceObjectInRowHeightsAtIndex:(NSUInteger)idx withObject:(id)anObject;
- (void)insertRowHeights:(NSArray *)rowHeightArray atIndexes:(NSIndexSet *)indexes;
- (void)removeRowHeightsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceRowHeightsAtIndexes:(NSIndexSet *)indexes withRowHeights:(NSArray *)rowHeightArray;

@end
