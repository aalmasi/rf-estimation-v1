function output = getParams(opts)

opts.DataPath               = 'F:\Data\Cat Experiments\CatBZ\Raw-Data';
opts.StimFilePath           = 'F:\Data\Cat Experiments\CatBZ\Stimulus Files';
opts.ImagePath              = 'F:\Stimuli\WGN';
% opts.ImagePath              = 'F:\Stimuli\NaturalScenes_VH';
% opts.ImagePath              = 'F:\Stimuli\Whitened-Natural Images';
% opts.ImagePath_adaptation   = 'Z:\IN VIVO LAB\Data\CAT\Experiments\CATBO\Images';
opts.StimTableFilePath      = 'F:\Data\Cat Experiments\CatBZ\Spike Sorting\Track2\Part1';
opts.SpikePath              = 'F:\Data\Cat Experiments\CatBZ\Spike Sorting\Track2\Part1\SPK Files';
% opts.SpikePath              = 'Z:\IN VIVO LAB\Data\CAT\Experiments\CATBO\Spike-Sorted\spk_files';

opts.cellInfoTable = 'F:\Data\Cat Experiments\CatBZ\Spike Sorting\Track2\Part1\CATBZ-Track2-Part1-CellsSummary.xlsx';
opts.NEV.nChannels   = 32;
opts.NEV.Channel2ElectrodeMap = 1:60;
% opts.NEV.nChannels   = 32;
% opts.NEV.Channel2ElectrodeMap = 1:32;
opts.NEV.Fs = 3e4;
opts.SignificanceTestSTA = 0;
opts.SignificanceTestSTC = 0;
opts.nBootstrap = 500;

plotwidth = 29.7;
plotheight = 21;
leftmargin = 1;
rightmargin = 0.5;
bottommargin = 0.5;
topmargin = 0.5;
nbx = 4;
nby = 4;
spacex = 0.8;
spacey = 1.5;

positions = subplot_pos(plotwidth,plotheight,leftmargin,rightmargin,bottommargin,topmargin,nbx,nby,spacex,spacey);
positions = positions(:, 4:-1:1);
opts.plotAllChannelsPositions = positions;
output = opts;
end