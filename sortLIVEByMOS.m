% sort images in LVIE by mos

load('E:\DATABASE\databaserelease2\LIVE_dmos2.mat')
dmos = zeros(982,2);
dmos(:,1) = (1:982)';
dmos(:,2) = dmos_new';
dmos_sort = sortrows(dmos,-2);

dir = 'E:\DATABASE\databaserelease2';
targetDir = 'E:\DATABASE\databaserelease2\target\';

for i=1:982
    if(dmos_sort(i,1) / 808>1)
        sourcePath = '\fastfading';
        sourcePath = strcat(dir,sourcePath,'\img',int2str(dmos_sort(i,1)-808),'.bmp')
    else if(dmos_sort(i,1) / 634>1)
            sourcePath = '\gblur';
            sourcePath = strcat(dir,sourcePath,'\img',int2str(dmos_sort(i,1)-634),'.bmp')
        else if(dmos_sort(i,1)/460>1)
                sourcePath = '\wn';
                sourcePath = strcat(dir,sourcePath,'\img',int2str(dmos_sort(i,1)-460),'.bmp')
            else if(dmos_sort(i,1)/227>1)
                    sourcePath = '\jpeg';
                    sourcePath = strcat(dir,sourcePath,'\img',int2str(dmos_sort(i,1)-227),'.bmp')
                else
                    sourcePath = '\jp2k';
                    sourcePath = strcat(dir,sourcePath,'\img',int2str(dmos_sort(i,1)),'.bmp')
                end
            end
        end
    end
    
    name = strcat(int2str(i),'.bmp');
    target = strcat(targetDir, name)
    copyfile(sourcePath,target);
end
