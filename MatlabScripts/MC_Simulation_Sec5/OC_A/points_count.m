function [ count_num ] = points_count( area_range,f_MC_GR,f_MC_FR )

n = size(f_MC_GR,1);
count_num = 0;

for i = 1:n
    if f_MC_GR(i)>=area_range(1) && f_MC_GR(i)<=area_range(2) && f_MC_FR(i)>=area_range(3) && f_MC_FR(i)<=area_range(4)
        count_num = count_num+1;
    else
        continue
    end
end

end

