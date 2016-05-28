//
//  CardPage.m
//  CardPage
//
//  Created by ymj_work on 16/5/22.
//  Copyright © 2016年 ymj_work. All rights reserved.
//

#import "CardPage.h"
#import "CollectionFlowLayout.h"
#import "CollectionViewCell.h"

#define cellWidth 300
#define itemSpacing 10
#define ButtonHeight 80


@interface CardPage()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,strong) NSArray *imageNameArray;
@property (nonatomic,assign) int itemNumber;
@property (nonatomic,strong) UIButton *leftBtn;
@property (nonatomic,strong) UIButton *rightBtn;
@property (nonatomic,assign) CGRect collectionViewRect;
@property (nonatomic,assign) CGRect pageControlRect;


@end



@implementation CardPage

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
        [self initSubviews];
    }
    return self;
}

-(void)initData{
    _itemNumber = 5;
    _imageNameArray = @[@"1",@"2",@"3",@"4",@"5"];
    _collectionViewRect = CGRectMake(0, 80, self.frame.size.width, 400);
    _pageControlRect = CGRectMake(100, 500, 200, 40);
}

-(void)initSubviews{
    
    [self addSubview:self.collectionView];
    [self addSubview:self.pageControl];
    [self addSubview:self.leftBtn];
    [self addSubview:self.rightBtn];
    
}


-(UICollectionView*)collectionView{
    //自定义UICollectionViewFlowLayout
    UICollectionViewFlowLayout *layout = [[CollectionFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = itemSpacing;
    layout.itemSize = CGSizeMake(cellWidth, cellWidth);
    //初始化collectionView
    _collectionView = [[UICollectionView alloc] initWithFrame:_collectionViewRect collectionViewLayout:layout];
    [_collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
    _collectionView.backgroundColor = [UIColor lightGrayColor];
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    return _collectionView;
}


-(UIPageControl*)pageControl{
    _pageControl = [[UIPageControl alloc]initWithFrame:_pageControlRect];
    _pageControl.numberOfPages = 5;
    [_pageControl setPageIndicatorTintColor:[UIColor lightGrayColor]];
    [_pageControl setCurrentPageIndicatorTintColor:[UIColor grayColor]];
    
    return _pageControl;
}

-(UIButton*)leftBtn{
    float leftBtnOrigin_Y = _collectionView.frame.size.height/2 + _collectionView.frame.origin.y - ButtonHeight/2;
    _leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, leftBtnOrigin_Y, 40, ButtonHeight)];
    _leftBtn.imageView.image = [UIImage imageNamed:@"left"];
    [_leftBtn setImage:[UIImage imageNamed:@"left"] forState:UIControlStateNormal];
    [_leftBtn addTarget:self action:@selector(lastPage:) forControlEvents:UIControlEventTouchUpInside];
    if (_collectionView.contentOffset.x<self.frame.size.width/2){
        _leftBtn.alpha = 0;
    }else{
        _leftBtn.alpha = 0.5;
    }
    
    return _leftBtn;
}

-(UIButton*)rightBtn{
    float rightBtnOrigin_Y = _collectionView.frame.size.height/2 + _collectionView.frame.origin.y - ButtonHeight/2;
    _rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width-40, rightBtnOrigin_Y, 40, ButtonHeight)];
    [_rightBtn setImage:[UIImage imageNamed:@"right"] forState:UIControlStateNormal];
    _rightBtn.imageView.image = [UIImage imageNamed:@"right"];
    [_rightBtn addTarget:self action:@selector(nextPage:) forControlEvents:UIControlEventTouchUpInside];
    
    _rightBtn.alpha = 0.5;
    NSLog(@"rightbutton");
    NSLog(@"_collectionView.contentSize.width%f",_collectionView.contentSize.width);
    return _rightBtn;
    
}

-(void)lastPage:(UIButton*)button{
    float last_X = _collectionView.contentOffset.x - (cellWidth+itemSpacing);
    [_collectionView setContentOffset:CGPointMake(last_X, 0) animated:YES];
    //set后collectionView的contentOffset.x的值还未改变，判断时多考虑一个单元
    if (_collectionView.contentOffset.x<(self.frame.size.width/2+cellWidth+itemSpacing)){
        _leftBtn.alpha = 0;
        _rightBtn.alpha = 0.4;
    }else{
        _leftBtn.alpha = 0.4;
        _rightBtn.alpha = 0.4;
    }
}

-(void)nextPage:(UIButton*)button{
    float next_X = _collectionView.contentOffset.x + (cellWidth+itemSpacing);
    [_collectionView setContentOffset:CGPointMake(next_X, 0) animated:YES];
    //set后collectionView的contentOffset.x的值还未改变，判断时多考虑一个单元
    if(_collectionView.contentOffset.x > (_collectionView.contentSize.width-(cellWidth+itemSpacing)*5/2)){
        _leftBtn.alpha = 0.4;
        _rightBtn.alpha = 0;
    }else{
        _leftBtn.alpha = 0.4;
        _rightBtn.alpha = 0.4;
    }
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _itemNumber;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    cell.imageV.image = [UIImage imageNamed:_imageNameArray[indexPath.row]];
    cell.backgroundColor = [UIColor whiteColor];
    cell.layer.cornerRadius = 10.f;
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    _pageControl.currentPage = indexPath.row;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int index = (scrollView.contentOffset.x+self.bounds.size.width/2)/cellWidth;
    _pageControl.currentPage = index;
    //滑动过程中不显示左右翻页按钮
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _leftBtn.alpha = 0;
    _rightBtn.alpha = 0;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //滑动结束时显示
    int index = (scrollView.contentOffset.x+self.bounds.size.width/2)/(cellWidth+itemSpacing);
    if (index == 0){
        _leftBtn.alpha = 0;
        _rightBtn.alpha = 0.4;
    }else if(index == (_itemNumber-1)){
        _leftBtn.alpha = 0.4;
        _rightBtn.alpha = 0;
    }else{
        _leftBtn.alpha = 0.4;
        _rightBtn.alpha = 0.4;
        
    }
    
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
