# matlab-mylib
这个库是自己在做图像、视频质量评价（I/VQA）实验时需要经常用到的函数的汇总，函数部分为手动实现，部分为其他论文里的代码（均已表明出处）。lib一直更新。

## mscn.m
【论文[1]实现的方法】
 - 一种归一化方法，在BRISQUE算法中被提出。
 - **[1]** Mittal, A., Moorthy, A. K., & Bovik, A. C. (2012). No-reference image quality assessment in the spatial domain.IEEE Transactions on Image Processing, 21(12), 4695-4708.

## SDSP.m
【论文[2]实现的方法】
 - LinZhang的算法中使用的求图像显著性的方法。
 - **[2]** L. Zhang, L. Zhang, X. Mou, and D. Zhang, “FSIM: A feature similarity index for image quality assessment,” IEEE Trans. Image Process., vol. 20, no. 8, pp. 2378–2386, Aug. 2011.

## sortLIVEByMOS.m
【自己手动实现】
 - 将LIVE图像库中的图像按照mos值排序，并将排序后的图像存储在target文件夹下，图像名称以次序命名。
