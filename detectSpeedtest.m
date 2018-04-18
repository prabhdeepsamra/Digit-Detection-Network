template = zeros(26,26,10);
tempvalid = 0;
difference = zeros(26,26,10);
output = zeros(700,700);
count = 0;
sumDifference = zeros(1,10);

image = imread('test_10_rand_8.tif');
s1 = '0';
s2 = '_26x26.tif';

masked = mask(image);

for i = 0:9
    s3 = strcat(s1,s2);
    template(:,:,i+1) = imread(s3);
    s1 = s1+1;
end

for i = 1:28
    difference (i,:,:) = 255;
end

for i = 1:700
    output (i,:) = 255;
end



for x = 1: 672
    for y = 1:672
        for i = 1:28
            difference (i,:) = 255;
        end
        
        sumDifference = zeros(1,10);
        
        
        
        if (masked(x,y) == 0)
            
            for x1 = 1:26
                for y1 = 1:26
                    
                    
                    for i = 1: 10
                        difference(x1,y1,i) = abs(image(x1+x-1,y1+y-1) - template(x1,y1,i));
                        if(difference(x1,y1,i) ~= 0)
                            sumDifference(1,i) = sumDifference(1,i) + 1;
                        end
                        
                    end
                    
                    
                end
            end
            
            
            
            
            
            
            
            for i = 1: 10
                if(sumDifference(1,i) <= 5)
                    count = count +1;
                    i-1
                    for x1 = 1:26
                        for y1 = 1:26
                            output(x1+x-1,y1+y-1) = 0;
                        end
                    end
                end
            end
        end
        
    end
end

imwrite(output, 'difference.tif');
