### 三个UIImageView+UIScrollView
- 分为2个步骤：
 - 移动到下一个imageView
 - 更改数据，把中间的的imageView移到scrollView上来还是显示完成时的图片，等待下一次调用
 
![](https://github.com/angmu/MGInfiniteScrollView/blob/master/Screenshot/snip01.gif)

### 两个UIImageView+UIScrollView
- 核心步骤：
 - scrollView的contentSize是3个imageView的大小
 - 中间的imageView在contentSize上固定不动(frame是固定的)
 - 另外一个imageView的frame可能在做，可能再右，根据情况改变frame

- 变化完成之后，做2件事：
 - 修改显示的image，把当前imageView设置为要显示图片。
 - 马上把当前imageView移动到中间，**这个过程很快，实际看不出来有修改和移动**

![](https://github.com/angmu/MGInfiniteScrollView/blob/master/Screenshot/snip02.gif)

### collection 循环滚动
- 最开始滚到中间部分
- 很多组，每组相同的数据


---
- 参考:
 - [UIImage图片无限滚动的实现](http://www.jianshu.com/p/1d9b8b82a5f9)
 - [iOS简单自定义滑动视图（UIScrollView）](http://www.jianshu.com/p/eb80b502f73e)
