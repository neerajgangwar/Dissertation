%clear all
%clc

a = [54 130 540];

for i = 1 : 1 : length(a)
    dim = a(i);
    datafile = ['result_' num2str(dim) '.mat'];
    load(datafile, 'C');
    subplot(3, 2, i);
    image(C);
    axis square
  
    title(['AR Database/Dimension = ' num2str(dim)])
    map = colormap;
    rows = uint16(linspace(1, size(map, 1), 32));
    map = map(rows, :);
    colormap(map)
    colormap(gray)
    colorbar
end

% h = colorbar;
% set(h, 'Position', [0.8314, 0.11, 0.0581, 0.8150]);
% 
% for i = 1 : 1 : length(a)
%     pos = get(ax(i), 'Position');
%     set(ax(i), 'Position', [pos(1) pos(2) 0.85*pos(3) pos(4)]);
% end