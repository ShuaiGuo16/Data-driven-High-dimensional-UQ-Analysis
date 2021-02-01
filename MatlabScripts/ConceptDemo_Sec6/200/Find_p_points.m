function [ index ] = Find_p_points( target_sample,sample_data_bank,p )
% ------------------------------------------------------------------
% [ index ] = Find_p_points( target_sample,sample_data_bank )
% ------------------------------------------------------------------
% Input:      % target_sample:         find p nearst points around target
%                                      sample point
%             % sample_data_bank:      search in the provided data bank of
%                                      samples
%             % p:                     first p points
% ------------------------------------------------------------------
% Output:     % index:                 recording the corresponding index in
%                                      the data bank
% ------------------------------------------------------------------

% compute distances
dis = zeros(size(sample_data_bank,1),1);

for i = 1:size(sample_data_bank,1)
    temp = target_sample - sample_data_bank(i,:);
    dis(i) = sqrt(sum(temp.^2));
end

% sort distance
[Y,record] = sort(dis);

index = record(1:p);


end

