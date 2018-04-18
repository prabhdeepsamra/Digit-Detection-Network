function [coordinates] = segment(image)

breakloop = 0;
coordinates = zeros(2,625);
valid = zeros(700,700);
for i = 1:700
    valid (i,:) = 255;
end

for x = 1:30: 671
    for y = 1:30:671
        breakloop = 0;
        for x1 = 1:31
            for y1 = 1:31
                if(image(x1+x-1,y1+y-1) == 0 || (x>3 && y>3 && image(x1+x-2,y1+y-2)==0))
                    for i = 1:625
                        if (coordinates(1,i) == 0 && breakloop == 0)
                            coordinates(1,i)=x;
                            coordinates(2,i)=y;
                            breakloop =1;
                        end
                    end
                end
            end
        end
    end
end


end

