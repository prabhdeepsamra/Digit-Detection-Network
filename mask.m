function [masked_image] = mask(image)
coords = segment(image);
masked_image = zeros(720,720);
for i = 1:720
    masked_image (i,:) = 255;
end

for i = 1: 625
    if( coords(1,i) ~=0)
        x = coords(1,i)+4;
        y = coords(2,i)+4;
        for z1 = -3:33
            for z2 = -10:40
                masked_image(x+z1,y+z2)=0;
            end
        end
    end
end
masked_image(1:10,:)=[];
masked_image(:,1:10)=[];
masked_image(701:size(masked_image,1),:)=[];
masked_image(:,701:size(masked_image,2))=[];
imwrite(masked_image, 'masked.tif')
end

