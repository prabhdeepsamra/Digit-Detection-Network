%procedurally generate 10 images with digits scattered randomly througout
image = zeros(700,700);
valid = zeros(700,700);
template = zeros(30,30,10);
tempvalid = 0;

s1 = '0';
s2 = '_30x30.tif';

for i = 0:9
    s3 = strcat(s1,s2);
    template(:,:,i+1) = imread(s3);
    s1 = s1+1;
end

s1 = '0';
s2 = 'test_10_rand_';

for i = 1:10
    
    for i = 1:700
        image (i,:) = 255;
    end
    
    valid = zeros(700,700);
    
    for x = 1: 672
        for y = 1:672
            
            tempvalid = 0;
            
            for x1 = 1:28
                for y1 = 1:28
                    if(valid(x1+x-1,y1+y-1) == 1)
                        tempvalid = 1;
                    end
                end
            end
            
            if (randi(15000) == 15000 && tempvalid == 0)
                z1 = randi(10);
                for x1 = 1:28
                    for y1 = 1:28
                        valid(x1+x-1,y1+y-1) = 1;
                        image(x1+x-1,y1+y-1) = template(x1,y1,z1);
                    end
                end
            end
            
        end
    end
    image(701:size(image,1),:)=[];
    image(:,701:size(image,2))=[];
    imshow(image)
    s3 = strcat(s2,s1,'.tif');
    imwrite(image, s3);
    s1 = s1+1;
end


