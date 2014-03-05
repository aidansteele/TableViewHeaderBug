#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) NSDictionary *sections;
@property (nonatomic, strong) NSMutableArray *expanded;
@end

@implementation ViewController

- (id)initWithStyle:(UITableViewStyle)style;
{
  if ((self = [super initWithStyle:style]))
  {
    [self setSections:@{
      @"Section A": @[@"Row 1", @"Row 2", @"Row 3"],
      @"Section B": @[@"Row 4", @"Row 5", @"Row 6"],
      @"Section C": @[@"Row 7", @"Row 8", @"Row 9"],
      @"Section D": @[@"Row 10", @"Row 11", @"Row 12"],
      @"Section E": @[@"Row 13", @"Row 14", @"Row 15"],
    }];

    [self setExpanded:[@[@YES, @YES, @YES, @YES, @YES] mutableCopy]];
  }

  return self;
}

- (void)loadView;
{
  [super loadView];
  [[self tableView] registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ident"];
}

- (NSString *)keyForSection:(NSInteger)section;
{
  NSArray *keys = [[self sections] allKeys];
  NSArray *sorted = [keys sortedArrayUsingSelector:@selector(compare:)];
  return [sorted objectAtIndex:section];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
{
  UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"ident"];

  if (!view)
  {
    view = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"ident"];
    [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerTap:)]];
  }

  [view setTag:section];
  [[view textLabel] setText:[self keyForSection:section]];

  return view;
}

- (void)headerTap:(UITapGestureRecognizer *)tap;
{
  NSInteger section = [[tap view] tag];
  NSString *key = [self keyForSection:section];
  NSArray *rows = [[self sections] objectForKey:key];

  BOOL will_expand = ![[[self expanded] objectAtIndex:section] boolValue];
  [[self expanded] replaceObjectAtIndex:section withObject:@(will_expand)];

  NSMutableArray *paths = [NSMutableArray array];
  for (NSUInteger idx = 0; idx < [rows count]; idx++)
  {
    [paths addObject:[NSIndexPath indexPathForRow:idx inSection:section]];
  }

  if (will_expand)
  {
    [[self tableView] insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationAutomatic];
  }
  else
  {
    [[self tableView] deleteRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationAutomatic];
  }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
  return [[self sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
  NSString *key = [self keyForSection:section];
  NSArray *rows = [[self sections] objectForKey:key];
  BOOL expanded = [[[self expanded] objectAtIndex:section] boolValue];
  return expanded ? [rows count] : 0;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section;
{
  UITableViewHeaderFooterView *hfv = (UITableViewHeaderFooterView *)view;
  NSLog(@"%@: %@", NSStringFromSelector(_cmd), [[hfv textLabel] text]);
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section;
{
  UITableViewHeaderFooterView *hfv = (UITableViewHeaderFooterView *)view;
  NSLog(@"%@: %@", NSStringFromSelector(_cmd), [[hfv textLabel] text]);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ident" forIndexPath:indexPath];

  NSString *key = [self keyForSection:[indexPath section]];
  NSString *row = [[[self sections] objectForKey:key] objectAtIndex:[indexPath row]];

  [[cell textLabel] setText:row];
  return cell;
}

@end
