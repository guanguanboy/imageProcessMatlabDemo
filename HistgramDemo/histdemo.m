a =imread('17121930144.png');
%imshow(a);
%imhist(a, 10000);

%ֱ��ͼ����
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

%ֱ��ͼ�ۼ�
for i=2:10000
    original_hist(i) = original_hist(i) + original_hist(i-1);
end
%bar(original_hist);
%plot(original_hist);

%ֱ��ͼ��һ��
for i=1:10000
    original_hist(i) =  256 * (1.0 - (original_hist(i)/nNumberOfNoneZeroPixels) );
end

%bar(original_hist);

b = zeros(480, 640);
grayscale = uint8(b); %ע��������Ҫ��������ת��Ϊ

%�����ͼ�ع�Ϊ�Ҷ�ͼ
for i=1:rows
    for j=1:columns
        if (a(i,j) ~= 0)
            grayscale(i,j) = original_hist(a(i,j));
        end
        
    end
    
end

imshow(grayscale);

%�����Ҷ�ͼ��ʾΪ��ɫͼ
color = label2rgb(grayscale);
%imshow(color);

%�����ͼ�ع�Ϊ��ɫͼ
yellowImage = zeros(480, 640, 3);
yellowImage = uint8(yellowImage);

for i=1:rows
    for j=1:columns
        if (a(i,j) ~= 0)
            %[a(i,j),i,j]
            if (original_hist(a(i,j)) == 0)
               continue; 
            end
            yellowImage(i,j,1) = original_hist(a(i,j))-1; %R������ȡֵ��Χ��0-255
            yellowImage(i,j,2) = original_hist(a(i,j))-1; %G������
        end
        
    end
    
end

%imshow(yellowImage);
