figure(1);imshow('color_0.jpg');
color = imread('color_0.jpg');

figure(2);imshow('depth_0.png');
a = imread('depth_0.png');

%a = flip(a);
%a =flip(a);
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
%将深度图重构为黄色图
yellowImage = zeros(rows, columns, 3);
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

%color = flip(color, 2);
ronghe = yellowImage + color;
figure(3); imshow(ronghe);


%yellowImage = flip(yellowImage);
%yellowImage = flip(yellowImage);
%ronghe1 = yellowImage + color;
%figure(4); imshow(ronghe1);
