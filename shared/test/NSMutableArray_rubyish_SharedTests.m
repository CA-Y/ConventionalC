#import "NSMutableArray+rubyish.h"
#import <SenTestingKit/SenTestingKit.h>

@interface NSMutableArray_rubyish_SharedTests:SenTestCase
@end

@interface NSMutableArray_rubyish_SharedTests()
  @property(retain) NSMutableArray* abc;
  @property(retain) NSMutableArray* empty;
@end

@implementation NSMutableArray_rubyish_SharedTests

@synthesize abc, empty;

-(void)setUp
{
    [super setUp];
    abc = @[@"a", @"b", @"c"].mutableCopy;
    empty = NSMutableArray.new;
}

-(void)testCollect
{
    [self testMap];
}

-(void)testCompact
{
    NSMutableArray* result = @[@"a", @"b", @"c"].mutableCopy;
    STAssertEqualObjects(result.compact, abc, nil);
}

-(void)testMap
{
    NSArray* result = [abc map:(id)^(NSString *o){ return [o stringByAppendingString:o]; }];
    STAssertEqualObjects(result, (@[@"aa", @"bb", @"cc"]), nil);
}

-(void)testReplace
{
    NSArray* replaced = @[@"replaced"];
    STAssertEqualObjects([abc replace:replaced], replaced, nil);
}

-(void)testReverse
{
    STAssertEqualObjects(abc.reverse, (@[@"c", @"b", @"a"]), nil);
    STAssertEqualObjects(abc.reverse.reverse, abc, nil);
}

-(void)testSelect
{
    NSArray* result = [abc select:^BOOL(id o){return [@"b" isEqual:o];}];
    NSArray* compare = @[(@"b")];
    STAssertEqualObjects(result, compare, nil);
}

-(void)testShuffle
{
    NSArray* oneTo99 = [NSArray newWithSize:100 block:(id)^(int i){return @(i+1);}];
    NSArray* result = [oneTo99.mutableCopy shuffle];
    STAssertFalse([oneTo99 isEqual:result], nil);
    STAssertEqualObjects(result.sorted, oneTo99, nil);
}

-(void)testSort
{
    STAssertEqualObjects([(@[@"c", @"a", @"b"]).mutableCopy sort], abc, nil);
    STAssertEqualObjects((abc.reverse.sort), abc, nil);
}

@end
