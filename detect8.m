
image = imread('testimage1.tif');
template = imread('8_28x28.tif');
tempvalid = 0;
difference = zeros(28,28);
count = 0;
for i = 1:28
    difference (i,:) = 255;
end

output = zeros(700,700);
for i = 1:700
    output (i,:) = 255;
end

for x = 1: 672
    for y = 1:672
        for i = 1:28
            difference (i,:) = 255;
        end
        sumDifference = 0;
        for x1 = 1:28
            for y1 = 1:28
                difference(x1,y1) = abs(image(x1+x-1,y1+y-1) - template(x1,y1));
                if(difference(x1,y1) ~= 0)
                    sumDifference = sumDifference + 1;
                end
            end
        end
        
        
        
        if(sumDifference <= 5)
            count = count +1;
            for x1 = 1:28
                for y1 = 1:28
                    output(x1+x-1,y1+y-1) = 0;
                end
            end
        end
        
        
    end
end
imwrite(output, 'difference.tif');
