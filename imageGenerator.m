%procedurally generate 10 images with digits scattered randomly througout
%initialize
image = zeros(700,700);
valid = zeros(700,700);
template = zeros(30,30,12);
tempvalid = 0;
s1 = '0';
s2 = '_30x30.tif';

%get templates
for i = 0:9
    s3 = strcat(s1,s2);
    template(:,:,i+1) = imread(s3);
    s1 = s1+1;
end
template(:,:,11) = imread('square.tif');
template(:,:,12) = imread('triangle.tif');

%string for output names
s1 = '0';
s2 = 'test_10_rand_shapes_noise_';

%loop 10 times for 10 images
for i = 1:10
    
    %reset image
    for i = 1:700
        image (i,:) = 255;
    end
    %reset valid matrix (this is so numbers dont overlap)
    valid = zeros(700,700);
    
    %loop through entire image
    for x = 1: 672
        for y = 1:672
            tempvalid = 0;
            
            %set tempvalid
            for x1 = 1:28
                for y1 = 1:28
                    if(valid(x1+x-1,y1+y-1) == 1)
                        tempvalid = 1;
                    end
                end
            end
            
            %write random template to image
            if (randi(15000) == 15000 && tempvalid == 0)
                z1 = randi(12);
                for x1 = 1:28
                    for y1 = 1:28
                        valid(x1+x-1,y1+y-1) = 1;
                        image(x1+x-1,y1+y-1) = template(x1,y1,z1);
                    end
                end
            end
        end
    end
    
    %add noise
    for x = 15: 685
        for y = 15:685
            if (randi(70) == 15)
                z1 = randi(2);
                if (z1 == 1)
                    image(x,y) =255;
                else
                    image(x,y) =0;
                end
            end
            
        end
    end
    
    %trim image
    image(701:size(image,1),:)=[];
    image(:,701:size(image,2))=[];
 
    %output image
    s3 = strcat(s2,s1,'.tif');
    imwrite(image, s3);
    s1 = s1+1;
end


