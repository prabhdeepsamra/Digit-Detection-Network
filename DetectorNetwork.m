%initialize variables
template = zeros(26,26,10);
tempvalid = 0;
difference = zeros(26,26,10);
output = zeros(700,700);
count = 0;
sumDifference = zeros(1,10);
badTemplates = zeros(26,26,10);
thresholdValues = zeros(1,10);
s1 = '0';
s2 = '_26x26.tif';
s4 = '_noise_26x26.tif';

for i = 1:28
    difference (i,:,:) = 255;
end

for i = 1:700
    output (i,:) = 256;
end

%get the input image. this can be changed.
image = imread('test_10_rand_shapes_noise_0.tif');

%mask the input image
masked = mask(image);
imwrite(masked, 'masked.tif');


%load in the templates
for i = 0:9
    %templates for receiving units
    s3 = strcat(s1,s2);
    template(:,:,i+1) = imread(s3);
    
    %set bad templates for thresholding
    s3 = strcat(s1,s4);
    badTemplates(:,:,i+1) = imread(s3);
    s1 = s1+1;
end

%set the thresholding value to the perfect version, change one to
%badTemplates for imperfect values (still buggy).this can be changed.
thresholdValues = threshold(template, template);


%loop through entire image
for x = 1: 672
    for y = 1:672
        
        %reset differnce matrix
        for i = 1:28
            difference (i,:) = 255;
        end
        
        %reset sumdifference matrix
        sumDifference = zeros(1,10);
        
        
        %only look for numbers if it is marked by the mask
        if (masked(x,y) == 0)
            
            %get the difference from each receiving unit
            for x1 = 1:26
                for y1 = 1:26
                    for i = 1: 10
                        difference(x1,y1,i) = abs(image(x1+x-1,y1+y-1) - template(x1,y1,i));
                        currentwindow(x1,y1)=image(x1+x-1,y1+y-1);
                        if(difference(x1,y1,i) ~= 0)
                            sumDifference(1,i) = sumDifference(1,i) + 1;
                        end
                        
                    end
                    
                    
                end
            end

            %uncomment to see the current window moving by
            % imshow(currentwindow);
           
            %see if the receiving units activated
            for i = 1: 10
                if(sumDifference(1,i) <= thresholdValues(1,i)+30)
                    count = count +1;
                    i-1
                    for x1 = 1:26
                        for y1 = 1:26
                            output(x1+x-1,y1+y-1) = template(x1,y1,i);
                            if (x1 == 1 || y1 ==1 ||x1 == 26 || y1 ==26 )
                                output(x1+x-1,y1+y-1) =0;
                            end
                        end
                    end
                end 
            end
        end
    end
end

imwrite(output, 'difference.tif');
