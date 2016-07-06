function [ output_args ] = visualizeFilters(Filters)
% Visualizing the filters by pseudocolors
    figure, % visualizing all filters
    for k=1:size(Filters,3);
        subplot(8,6,k);
        imagesc(Filters(:,:,k)); colorbar;
    end
end

