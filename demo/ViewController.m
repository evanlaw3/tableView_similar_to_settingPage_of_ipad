//
//  ViewController.m
//  demo
//
//  Created by 罗西 on 8/23/15.
//  Copyright (c) 2015 com.demo. All rights reserved.
//

#import "ViewController.h"
#import "ratingBarView.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>{
    
}

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *logoArray;
@property (nonatomic,strong) NSArray *itemArray;

@end

@implementation ViewController

#define INSERT_TABLEVIEW 20

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //隐藏tabBar栏，显示navigationBar栏
    self.navigationController.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBarHidden = NO;
    self.title = @"请问需要什么帮助";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view setBackgroundColor:[UIColor colorWithRed:238.0/255 green:238.0/255 blue:238.0/255 alpha:1]];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(INSERT_TABLEVIEW, 64, self.view.bounds.size.width-INSERT_TABLEVIEW*2, self.view.bounds.size.height-64) style:UITableViewStyleGrouped];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setBackgroundColor:[UIColor colorWithRed:238.0/255 green:238.0/255 blue:238.0/255 alpha:1]];
    
    self.logoArray = [[NSArray alloc]initWithObjects:@"会员", @"付款", @"帮助", nil];
    self.itemArray = [[NSArray alloc]initWithObjects:@"账户信息", @"支付方式", @"使用LianLian", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    else{
        return 3;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

/**
 *  cell的属性
 */
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"123"];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"123"];
    }
    
    if (indexPath.section == 0) {
        cell.textLabel.text = @"查看更多订单";
        cell.textLabel.textColor = [UIColor grayColor];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
    }
    else{
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 30-15, 30, 30)];
        [imageView setImage:[UIImage imageNamed:[self.logoArray objectAtIndex:indexPath.row]]];
        [cell addSubview:imageView];
        
        UILabel *itemLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 30-15, 100, 30)];
        itemLabel.text = [self.itemArray objectAtIndex:indexPath.row];
        itemLabel.textColor = [UIColor grayColor];
        itemLabel.font = [UIFont systemFontOfSize:14];
        [cell addSubview:itemLabel];
    }
    
    //公告箭头
    UIImageView *imageView_arrow = [[UIImageView alloc]initWithFrame:CGRectMake(tableView.frame.size.width - 30, 30-6, 12, 12)];
    [imageView_arrow setImage:[UIImage imageNamed:@"arrow_right_img"]];
    [cell addSubview:imageView_arrow];
    
    return cell;
}

#define WIDTH_OF_TABLEVIEW 280

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(tintColor)]) {
        if (tableView == self.tableView) {
            CGFloat cornerRadius = 5.f;
            cell.backgroundColor = [UIColor clearColor];
            CAShapeLayer *layer = [[CAShapeLayer alloc] init];
            CGMutablePathRef pathRef = CGPathCreateMutable();
            CGRect bounds = CGRectInset(cell.bounds, 0, 0);
            BOOL addLine = NO;
            if (indexPath.row == 0 && indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
                CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
            } else if (indexPath.row == 0) {
                CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
                CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
                addLine = YES;
            } else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
                CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
                CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
            } else {
                CGPathAddRect(pathRef, nil, bounds);
                addLine = YES;
            }
            layer.path = pathRef;

            CFRelease(pathRef);
            layer.fillColor = [UIColor clearColor].CGColor;
            layer.fillColor = [UIColor colorWithWhite:1.f alpha:0.8f].CGColor;
            
            CAShapeLayer *shapeLayer = [CAShapeLayer layer];
            shapeLayer.path = layer.path;
            shapeLayer.lineCap = kCALineCapRound;
            shapeLayer.strokeColor = [[UIColor lightGrayColor] CGColor];
            shapeLayer.lineWidth = 0.5;
            shapeLayer.fillColor = [[UIColor clearColor] CGColor];
            
            if (addLine == YES) {
                CALayer *lineLayer = [[CALayer alloc] init];
                CGFloat lineHeight = (1.f / [UIScreen mainScreen].scale);
                lineLayer.frame = CGRectMake(CGRectGetMinX(bounds), bounds.size.height-lineHeight, bounds.size.width, lineHeight);
                lineLayer.backgroundColor = tableView.separatorColor.CGColor;
                [layer addSublayer:lineLayer];
            }
            UIView *testView = [[UIView alloc] initWithFrame:bounds];
            [testView.layer insertSublayer:layer atIndex:0];
            [testView.layer addSublayer:shapeLayer];
            testView.backgroundColor = [UIColor clearColor];
            cell.backgroundView = testView;
        }
    }
}

#define HEIGHT_OF_HEADER1 70
#define HEIGHT_OF_HEADER2 210

/**
 *  Header的高度
 */
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return HEIGHT_OF_HEADER2;
    }
    return ( HEIGHT_OF_HEADER1 );
}

/**
 *  Footer的高度
 */
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if( section == 1){
        return 30;
    }
    return ( CGFLOAT_MIN );
}

//可返回每个section-footer的自定义视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    float heightOfHeader = 0.0;
    if (section == 0) {
        heightOfHeader = HEIGHT_OF_HEADER2;
    }
    else{
        heightOfHeader = HEIGHT_OF_HEADER1;
    }
    
    //headerView
    UIView *container_header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_OF_TABLEVIEW, heightOfHeader)];
    [container_header setBackgroundColor:[UIColor colorWithRed:238.0/255 green:238.0/255 blue:238.0/255 alpha:1]];
    
    //两条线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(40-INSERT_TABLEVIEW, 30, 80, 1)];
    lineView.backgroundColor = [UIColor colorWithRed:186.0/255 green:186.0/255 blue:186.0/255 alpha:1];
    [container_header addSubview:lineView];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width-80-40-INSERT_TABLEVIEW, 30, 80, 1)];
    lineView2.backgroundColor = [UIColor colorWithRed:186.0/255 green:186.0/255 blue:186.0/255 alpha:1];
    [container_header addSubview:lineView2];
    
    
    //label
    UILabel *label = [UILabel new];
    label.frame = CGRectMake(container_header.frame.size.width/2-30, 30, 60, 20);
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentNatural;
    [container_header addSubview:label];
    label.center = CGPointMake(self.view.frame.size.width/2-INSERT_TABLEVIEW, 30);
    NSLog(@"center:%f",label.center.x);
    NSLog(@"origin:%f",label.frame.origin.x);
    NSLog(@"selfVieww：%f",self.view.frame.size.width);
    
    if(section == 0){
        label.text = @"恋练问题";
        
        UIView *personalView = [[UIView alloc]initWithFrame:CGRectMake(0, 60, self.view.frame.size.width - INSERT_TABLEVIEW*2, 130)];
        [container_header addSubview:personalView];
        //[personalView setBackgroundColor:[UIColor colorWithRed:254.0/255 green:255/255 blue:255/255 alpha:1]];
        personalView.backgroundColor = [UIColor colorWithWhite:1.f alpha:0.8f];
        personalView.layer.cornerRadius = 3;
        
        //白边
        UIView *bgView = [[UIButton alloc]initWithFrame:CGRectMake(20, 20, 64, 64)];
        [bgView setBackgroundColor:[UIColor whiteColor]];
        bgView.layer.masksToBounds = YES;
        bgView.layer.cornerRadius = 32;
        [personalView addSubview:bgView];
        bgView.layer.shadowColor = [UIColor blackColor].CGColor;
        bgView.layer.shadowOffset = CGSizeMake(0, 10);
        //bgView.layer.shadowRadius = 8;
        bgView.layer.shadowOpacity = 0.8;
        
        //头像
        UIButton *psBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 30, 60, 60)];
        [psBtn setImage:[UIImage imageNamed:@"photo"] forState:UIControlStateNormal];
        psBtn.layer.masksToBounds = YES;
        psBtn.layer.cornerRadius = 30;
        [personalView addSubview:psBtn];
        
        bgView.center = psBtn.center;
        
        //ID
        UILabel *idLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 30, 60, 30)];
        idLabel.text = @"天涯路人";
        [idLabel setFont:[UIFont systemFontOfSize:14]];
        [personalView addSubview:idLabel];
        
        //project
        UILabel *proLabel = [[UILabel alloc]initWithFrame:CGRectMake(165, 30, 60, 30)];
        proLabel.text = @"高尔夫";
        [proLabel setFont:[UIFont systemFontOfSize:14]];
        [personalView addSubview:proLabel];
        
        //price
        UILabel *priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(220, 30, 60, 30)];
        priceLabel.text = @"￥10000";
        [priceLabel setFont:[UIFont systemFontOfSize:14]];
        [personalView addSubview:priceLabel];
        
        //星星
        ratingBarView *bar = [[ratingBarView alloc]initWithFrame:CGRectMake(90, 60, 60, 20) topImg:@"star_1.jpg" bottomImg:@"star_2.jpg"];
        [personalView addSubview:bar];
        bar.starNumber = 3;
        bar.enable = NO;
        bar.backgroundColor = [UIColor clearColor];
        [bar setViewColor:[UIColor clearColor]];
        
        //date
        UILabel *dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(165, 60, 120, 30)];
        dateLabel.text = @"15/7/8 9:00";
        [personalView addSubview:dateLabel];
        [dateLabel setFont:[UIFont systemFontOfSize:14]];
        [dateLabel setTextColor:[UIColor lightGrayColor]];
        
        bar.center = CGPointMake(90+30, dateLabel.center.y);
        
    }
    else{
        label.text = @"其他主题";
    }
    
    return container_header;
}

/**
 *  点击事件
 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
