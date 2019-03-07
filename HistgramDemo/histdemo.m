a =imread('17121930144.png');
%imshow(a);
%imhist(a, 10000);

%直方图计算
[rows, columns] = size(a);
original_hist = zeros(10000,1);
nNumberOfNoneZeroPixels = 0;
for i=1:rows
    for j=1:columns
        if (a(i,j) ~= 0)
            original_hist(a(i,j)) = original_hist(a(i,j)) + 1;
            nNumberOfNoneZeroPixels = nNumberOfNoneZeroPixels + 1;
        end
        
    end
    
end
%bar(original_hist);
%plot(original_hist);

%直方图累加
for i=2:10000
    original_hist(i) = original_hist(i) + original_hist(i-1);
end
%bar(original_hist);
%plot(original_hist);

%直方图归一化
for i=1:10000
    original_hist(i) =  256 * (1.0 - (original_hist(i)/nNumberOfNoneZeroPixels) );
end

%bar(original_hist);

b = zeros(480, 640);
grayscale = uint8(b); %注意这里需要将其类型转换为

%将深度图重构为灰度图
for i=1:rows
    for j=1:columns
        if (a(i,j) ~= 0)
            grayscale(i,j) = original_hist(a(i,j));
        end
        
    end
    
end

imshow(grayscale);

%将将灰度图显示为彩色图
color = label2rgb(grayscale);
%imshow(color);

%将深度图重构为黄色图
yellowImage = zeros(480, 640, 3);
yellowImage = uint8(yellowImage);

for i=1:rows
    for j=1:columns
        if (a(i,j) ~= 0)
            %[a(i,j),i,j]
            if (original_hist(a(i,j)) == 0)
               continue; 
            end
            yellowImage(i,j,1) = original_hist(a(i,j))-1; %R分量，取值范围是0-255
            yellowImage(i,j,2) = original_hist(a(i,j))-1; %G分量，
        end
        
    end
    
end

%imshow(yellowImage);
