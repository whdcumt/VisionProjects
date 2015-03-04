function [ sim_scores ] = face_match_l2( probe_feats, gal_feats )
%FACE_MATCH_L2 Summary of this function goes here
%   Detailed explanation goes here

sim_scores = zeros(size(probe_feats,1), size(gal_feats,1));
sim_scores = single(sim_scores);

for i=1:length(probe_feats)
    for j=1:length(gal_feats)
        sim_scores(i,j) = compare_sets(probe_feats{i}, gal_feats{j});
    end
    
    disp(['probe: ' num2str(i)]);
end

sim_scores = 1 - sim_scores ./ max(sim_scores(:));

end


function score = compare_sets(probe_set, gal_set)

score = inf;
for i=1:size(probe_set,1)
    probe_repmat = repmat(probe_set(i,:), size(gal_set, 1), 1);
    dists = sqrt(sum((probe_repmat-gal_set).^2, 2));
    score = min(score, min(dists));
end

end