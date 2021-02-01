function savepdf(figureHandle,size)
% Print PDF and PNG of figures
% Inputs
%   figureHandle: figure handle e.g. gcf
%   size: one of 'beamer', 'square', 'square9', 'beamerCol', 'paper'
% Outputs
%   -
%
% Armin Witte, 2017-03-29

set(figureHandle, 'PaperPositionMode', 'manual');
set(figureHandle, 'PaperUnits', 'centimeters');

if strcmp(size,'beamer')
%     set(figureHandle, 'PaperPosition', [-0.0 -0.0 13.4 7.9]);
%     set(figureHandle, 'PaperPosition', [0 0 11.8 7.5]);
%     set(figureHandle, 'PaperSize', [11.8 7.5]);
    
    dx = 11.8;
    dy = 6.5;

    set(figureHandle, 'PaperPosition', [0 0 dx dy]);
    set(figureHandle, 'PaperSize', [dx dy]);
    
elseif strcmp(size,'square')
%     set(figureHandle, 'PaperPosition', [-0.0 -0.0 13.4 7.9]);
%     set(figureHandle, 'PaperPosition', [0 0 11.8 7.5]);
%     set(figureHandle, 'PaperSize', [11.8 7.5]);
    
    dx = 8;
    dy = 8;

    set(figureHandle, 'PaperPosition', [0 0 dx dy]);
    set(figureHandle, 'PaperSize', [dx dy]);
    
elseif strcmp(size,'square9')
%     set(figureHandle, 'PaperPosition', [-0.0 -0.0 13.4 7.9]);
%     set(figureHandle, 'PaperPosition', [0 0 11.8 7.5]);
%     set(figureHandle, 'PaperSize', [11.8 7.5]);
    
    dx = 9;
    dy = 9;

    set(figureHandle, 'PaperPosition', [0 0 dx dy]);
    set(figureHandle, 'PaperSize', [dx dy]);
    
elseif strcmp(size,'beamerCol')
    
%     dx = 6.5;
%     dy = 6.5;
    dx = 7;
    dy = 7;

    set(figureHandle, 'PaperPosition', [0 0 dx dy]);
    set(figureHandle, 'PaperSize', [dx dy]);

elseif strcmp(size,'paper')
    
    dx = 15.9;
    dy = 10.0;

    set(figureHandle, 'PaperPosition', [0 0 dx dy]);
    set(figureHandle, 'PaperSize', [dx dy]);
    
else
    error('unknown size! (possible sizes: beamer)')
end

figureName = strrep(figureHandle.Name,' ','_');
figureName = figureName(1:min(16,length(figureName)));

if ~isdir('figures')
    mkdir('figures')
end

% saveas(figureHandle, strcat('figures/', figureName), 'pdf')
print('-dpdf','-cmyk',strcat('figures/', figureName,'.pdf'))
print('-dpng','-r600',strcat('figures/', figureName,'.png'))