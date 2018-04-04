# matlab-mylib
这个库是自己在做图像质量评价实验时需要经常用到的函数的汇总，函数部分为手动实现，部分阅读论文时大牛实现好的代码（在注释中均已表明出处）。lib一直更新。

## mscn.m
【别人论文实现的方法】
一种归一化方法，在BRISQUE算法中被提出。
[Mittal, A., Moorthy, A. K., & Bovik, A. C. (2012). No-reference image quality assessment in the spatial domain.IEEE Transactions on Image Processing, 21(12), 4695-4708.]

## SDSP.m
【别人论文实现的方法】
LinZhang的算法中使用的求图像显著性的方法。

## sort
【自己手动实现】
将LIVE图像库中的图像按照mos值排序，并将排序后的图像存储在target文件夹下，图像名称以次序命名。
