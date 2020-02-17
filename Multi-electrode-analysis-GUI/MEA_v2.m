function MEA_v2()
%% MEA Analysis Program v2.0
% created and copy right by Ali Almasi, 2016
% Date Upgraded: 16/09/2019

%% Setting up the GUI main figure

hfig = figure(...
    'Units','Normalized',...
    'MenuBar','none',...
    'Toolbar','none',...
    'Visible','off',...
    'name', 'Spike Analysis Toolbox',...
    'Position', [0.25 0.25 0.32 0.5]);
movegui('center')



tgroup1 = uitabgroup('Parent', hfig, 'position', [0.01 0.35 .98 0.64]);
tab1 = uitab('Parent', tgroup1, 'Title', 'Load Data');
tab4 = uitab('Parent', tgroup1, 'Title', 'Set Path');

tgroup2 = uitabgroup('Parent', hfig, 'position', [0.01 0.01 .98 0.3]);
tab2 = uitab('Parent', tgroup2, 'Title', 'Spike Train Statistics');
tab3 = uitab('Parent', tgroup2, 'Title', 'Spike-Triggered Analysis');
tab5 = uitab('Parent', tgroup2, 'title', 'Tuning');
tab6 = uitab('Parent', tgroup2, 'title', 'Contrast Reversing Gratings');
tab7 = uitab('Parent', tgroup2, 'title', 'GQM');

% panel1 = uipanel('Parent', hfig, 'Position', [0.01 0.01 .98 0.3],...
%        'Title', 'Data Channel', 'FontSize', 12);


%% ----------------------- Load Data Tab ------------------------------------

% pop-up menu to select the data type
dataMenu = uicontrol(tab1,...
    'Style', 'popupmenu',...
    'Units', 'Normalized',...
    'Position', [0.05 0.8 0.3 0.15],...
    'String', {'Blackrock NEV file', 'Spike Times file', 'Klusta .kwik file', 'Cell info file'},...
    'Value', 1,...
    'Callback', @datatypePopUpMenu_Callback);

adaptationCheckBox = uicontrol(tab1,...
    'Style', 'checkbox',...
    'Units', 'Normalized',...
    'Position', [0.8 0.75 0.05 0.15],...
    'Value', 0);

% pop-up menu to select the data channel
channelMenu = uicontrol(tab1,...
    'Style', 'popupmenu',...
    'Units', 'Normalized',...
    'Position', [0.6 0.8 0.3 0.15],...
    'Value', 1,...
    'String', 'No channel',...
    'Callback', @channelPopUpMenu_Callback);

text1_1 = uicontrol(tab1,...
    'Style', 'text',...
    'String', 'Adaptation Stimulus',...
    'Units', 'Normalized',...
    'HorizontalAlignment', 'left',...
    'Position', [0.6 0.7 0.2 0.15]);

% pop-up menu to select spike units
unitMenu = uicontrol(tab1,...
    'Style', 'popupmenu',...
    'Units', 'Normalized',...
    'Position', [0.6 0.1 0.3 0.05],...
    'Value', 1,...
    'String', 'Multi-unit',...
    'Callback', @unitPopUpMenu_Callback);

% import push button to import the selected data file into the selected list box
import_button = uicontrol(tab1,...
    'Style', 'pushbutton',...
    'Units', 'Normalized',...
    'Position', [0.4 0.44 0.15 0.1],...
    'String', 'Import >>>',...
    'FontSize', 11,...
    'Callback', @importPushButton_Callback);

% Reset push button to refresh the data list box and reset the gui
refresh_button = uicontrol(tab1,...
    'Style', 'pushbutton',...
    'Units', 'Normalized',...
    'Position', [0.05 0.07 0.1 0.1],...
    'String', 'Refresh',...
    'FontSize', 11,...
    'Callback', @refreshList_Callback);

% the list box that shows all the data existed in the imported excel file
dataList = uicontrol(tab1,...
    'Style', 'list',...
    'Units', 'Normalized',...
    'Position', [0.05 0.2 0.3 0.5],...
    'Max', 2,...
    'Callback', @dataList_Callback);

% the list box that shows the selected data file from the list of all
% available data files
dataSelectedList = uicontrol(tab1,...
    'Style', 'list',...
    'Units', 'Normalized',...
    'Position', [0.6 0.2 0.3 0.5]);


%% -------------------- Set Path Tab ---------------------------------------

% The details of the fourth path, setting the directory path of data,
% stimulus files, and images
panel4_1 = uipanel(...
    'Parent', tab4,...
    'Units', 'Normalized', ...
    'Position', [0.02 0.76 0.96 0.2],...
    'Title', 'Data Directory');

% set path push button of the "Data Directory" panel
pb4_1 = uicontrol(panel4_1,...
    'Style', 'pushbutton', ...
    'String', 'Set Path',...
    'Units', 'Normalized', ...
    'Position', [0.01 0.2 0.1 0.6],...
    'Callback', @setDataPathButton_Callback);


text4_1 = uicontrol(panel4_1,...
    'Style', 'text',...
    'String', 'Not Set',...
    'Units', 'Normalized',...
    'Position', [0.11 0.2 0.88 0.6],...
    'BackgroundColor', [0.97 0.97 0.97],...
    'ForegroundColor', [0.7 0 0]);


panel4_2 = uipanel(...
    'Parent', tab4,...
    'Units', 'Normalized', ...
    'Position', [0.02 0.52 0.96 0.2],...
    'Title', 'Stimulus File Directory');


% set path push button of the "Stimulus File Directory" panel
pb4_2 = uicontrol(panel4_2,...
    'Style', 'pushbutton', ...
    'String', 'Set Path',...
    'Units', 'Normalized', ...
    'Position', [0.01 0.2 0.1 0.6],...
    'Callback', @setStimFilePathButton_Callback);
text4_2 = uicontrol(panel4_2,...
    'Style', 'text',...
    'String', 'Not Set',...
    'Units', 'Normalized',...
    'Position', [0.11 0.2 0.88 0.6],...
    'BackgroundColor', [0.97 0.97 0.97],...
    'ForegroundColor', [0.7 0 0]);

panel4_3 = uipanel(...
    'Parent', tab4,...
    'Units', 'Normalized', ...
    'Position', [0.02 0.28 0.96 0.2], ...
    'Title', 'Images (Visual Stimuli) Directory');


% set path push button of the "Images (Visual Stimuli) Directory" panel
pb4_3 = uicontrol(panel4_3,...
    'Style', 'pushbutton', ...
    'String', 'Set Path',...
    'Units', 'Normalized', ...
    'Position', [0.01 0.2 0.1 0.6],...
    'Callback', @setImagePath_Callback);
text4_3 = uicontrol(panel4_3,...
    'Style', 'text',...
    'String', 'Not Set',...
    'Units', 'Normalized',...
    'Position', [0.11 0.2 0.88 0.6],...
    'BackgroundColor', [0.97 0.97 0.97],...
    'ForegroundColor', [0.7 0 0]);


panel4_4 = uipanel(...
    'Parent', tab4,...
    'Units', 'Normalized', ...
    'Position', [0.02 0.04 0.96 0.2], ...
    'Title', 'Import Information File');

% Import push button of the "Import Information File" panel
pb4_4 = uicontrol(panel4_4,...
    'Style', 'pushbutton', ...
    'String', 'Import',...
    'Units', 'Normalized', ...
    'Position', [0.01 0.2 0.1 0.6],...
    'Callback', @getInfoFile_Callback);
text4_4 = uicontrol(panel4_4,...
    'Style', 'text',...
    'String', 'Not Set',...
    'Units', 'Normalized',...
    'Position', [0.11 0.2 0.88 0.6],...
    'BackgroundColor', [0.97 0.97 0.97],...
    'ForegroundColor', [0.7 0 0]);



%% ------------------------ Spike Triggered Analysis Tab ----------------------

pmenu3_3 = uicontrol(tab3,...
    'Style', 'popupmenu',...
    'Units', 'Normalized',...
    'Position', [.21 0.7 0.1 0.25],...
    'String', {'Fixed', 'Variable'});

text3_1 = uicontrol(tab3,...
    'Style', 'Text',...
    'Units', 'Normalized',...
    'Position', [.01 0.72 0.2 0.2],...
    'String', 'Latency (msec)');

% input latency
edit3_1 = uicontrol(tab3,...
    'Style', 'Edit',...
    'Units', 'Normalized',...
    'Position', [.05 0.45 0.1 0.2],...
    'String', '30');

% variable latency input button
pb3_3 = uicontrol(tab3,...
    'Style', 'pushbutton',...
    'Units', 'Normalized',...
    'Position', [.2 0.45 0.15 0.2],...
    'String', 'Variable Latency',...
    'Callback', @variableLatencyInput_Callback);

text3_3 = uicontrol(tab3,...
    'Style', 'Text',...
    'Units', 'Normalized',...
    'Position', [.4 0.65 0.25 0.25],...
    'String', 'Whitening',...
    'HorizontalAlignment', 'right');

% Whitening pop-up menu
pmenu3_1 = uicontrol(tab3,...
    'Style', 'popupmenu',...
    'Units', 'Normalized',...
    'Position', [.66 0.65 0.2 0.25],...
    'String', {'OFF', 'ON'},...
    'Callback', @whiteningPopUpMenu_Callback);

text3_4 = uicontrol(tab3,...
    'Style', 'Text',...
    'Units', 'Normalized',...
    'Position', [.35 0.4 0.3 0.25],...
    'String', 'Image Transformation',...
    'HorizontalAlignment', 'right');

% image transformation pop-up menu
pmenu3_2 = uicontrol(tab3,...
    'Style', 'popupmenu',...
    'Units', 'Normalized',...
    'Position', [.66 0.4 0.2 0.25],...
    'String', {'None', 'Absolute Value', 'Squared'},...
    'Callback', @imageTransformationMenu_Callback);

% compute STA push button
pb3_1 = uicontrol(tab3,...
    'Style', 'pushbutton',...
    'Units', 'Normalized',...
    'Position', [.05 0.1 0.2 0.25],...
    'String', 'Compute STA',...
    'Callback', @computeSTApushButton_Callback);

% save results push button
pb3_2 = uicontrol(tab3,...
    'Style', 'pushbutton',...
    'Units', 'Normalized',...
    'Position', [.26 0.1 0.2 0.25],...
    'String', 'Save to Disk',...
    'Callback', @saveToDisk_Callback);

text3_5 = uicontrol(tab3,...
    'Style', 'Text',...
    'Units', 'Normalized',...
    'Position', [.65 0.3 0.2 0.1],...
    'String', 'STA Significance Test',...
    'HorizontalAlignment', 'right');

text3_6 = uicontrol(tab3,...
    'Style', 'Text',...
    'Units', 'Normalized',...
    'Position', [.65 0.1 0.2 0.1],...
    'String', 'STC Significance Test',...
    'HorizontalAlignment', 'right');

% STA significance test check box
checkbox3_1 = uicontrol(tab3,...
    'Style', 'checkbox',...
    'Units', 'Normalized',...
    'Position', [.9 0.3 0.05 0.1]);

% STC significance test check box
checkbox3_2 = uicontrol(tab3,...
    'Style', 'checkbox',...
    'Units', 'Normalized',...
    'Position', [.9 0.1 0.05 0.1]);

%% ------------------ Spike Train Statistics Tab ----------------------------
text2_1 = uicontrol(tab2,...
    'Style', 'Text',...
    'Units', 'Normalized',...
    'Position', [.01 0.65 0.1 0.15],...
    'String', 'Delay');

text2_2 = uicontrol(tab2,...
    'Style', 'Text',...
    'Units', 'Normalized',...
    'Position', [.22 0.65 0.1 0.15],...
    'String', 'msec');

% input delay
edit2_1 = uicontrol(tab2,...
    'Style', 'Edit',...
    'Units', 'Normalized',...
    'Position', [.12 0.65 0.1 0.15],...
    'String', '0',...
    'Callback', @DelayEdit_Callback);


text2_3 = uicontrol(tab2,...
    'Style', 'Text',...
    'Units', 'Normalized',...
    'Position', [.01 0.25 0.1 0.15],...
    'String', 'Time bin');

text2_4 = uicontrol(tab2,...
    'Style', 'Text',...
    'Units', 'Normalized',...
    'Position', [.22 0.25 0.1 0.15],...
    'String', 'msec');

% input time bin
edit2_2 = uicontrol(tab2,...
    'Style', 'Edit',...
    'Units', 'Normalized',...
    'Position', [.12 0.25 0.1 0.15],...
    'String', '10',...
    'Callback', @StatsTimeBinEdit_Callback);

text2_5 = uicontrol(tab2,...
    'Style', 'Text',...
    'Units', 'Normalized',...
    'Position', [.55 0.55 0.1 0.2],...
    'String', 'Type:',...
    'HorizontalAlignment', 'right',...
    'FontSize', 11);

% plot type pop-up menu
pmenu2_1 = uicontrol(tab2,...
    'Style', 'popupmenu',...
    'Units', 'Normalized',...
    'Position', [.66 0.55 0.2 0.2],...
    'String', {'Histogram', 'Rasterogram', 'Spike-counts'},...
    'Callback', @statsAnalysisTypePopUpMenu_Callback);

% plot push button
pbutton2_1 = uicontrol(tab2,...
    'Style', 'pushbutton',...
    'Units', 'Normalized',...
    'Position', [.66 .3 .08 .2],...
    'String', 'Plot',...
    'Callback', @plotStatsPushButton_Callback);

pbutton2_2 = uicontrol(tab2,...
    'Style', 'pushbutton',...
    'Units', 'Normalized',...
    'Position', [.75 .3 .1 .2],...
    'String', 'Plot All',...
    'Callback', @plotAllStatsPushButton_Callback);


%% -------------------- Tuning Tab ------------------------------------------
text5_1 = uicontrol(tab5,...
    'Style', 'Text',...
    'Units', 'Normalized',...
    'Position', [.01 0.65 0.1 0.15],...
    'String', 'Delay');

text5_2 = uicontrol(tab5,...
    'Style', 'Text',...
    'Units', 'Normalized',...
    'Position', [.22 0.65 0.1 0.15],...
    'String', 'msec');

% input delay
edit5_1 = uicontrol(tab5,...
    'Style', 'Edit',...
    'Units', 'Normalized',...
    'Position', [.12 0.65 0.1 0.15],...
    'String', '0',...
    'Callback', @tuningDelayEdit_Callback);

% tuning type pop-up menu
pmenu5_1 = uicontrol(tab5,...
    'Style', 'popupmenu',...
    'Units', 'Normalized',...
    'Position', [.66 0.55 0.2 0.2],...
    'String', {'Orientation', 'Spatial Frequency', 'Temporal Frequency', 'RF Size', 'Contrast', 'Spatial Phase', 'Position'},...
    'Callback', @tuningCurveTypeMenu_Callback);

% plot tuning curve push button
pbutton5_1 = uicontrol(tab5,...
    'Style', 'pushbutton',...
    'Units', 'Normalized',...
    'Position', [.66 .3 .08 .2],...
    'String', 'Plot',...
    'Callback', @plotTuningCurve_Callback);

pbutton5_2 = uicontrol(tab5,...
    'Style', 'pushbutton',...
    'Units', 'Normalized',...
    'Position', [.75 .3 .1 .2],...
    'String', 'Plot All',...
    'Callback', @plotAllTuningCurve_Callback);


%% --------------------Contrast Reversing Gratings Tab ----------------------------------------
panel6_1 = uipanel(tab6,...
    'Units', 'Normalized',...
    'Position', [.02 0.05 0.3 0.9],...
    'Title', 'Histograms');

text6_1 = uicontrol(panel6_1,...
    'Style', 'Text',...
    'Units', 'Normalized',...
    'Position', [.01 0.75 0.3 0.15],...
    'String', 'Delay');

text6_2 = uicontrol(panel6_1,...
    'Style', 'Text',...
    'Units', 'Normalized',...
    'Position', [.72 0.75 0.2 0.15],...
    'String', 'msec');

% input delay
edit6_1 = uicontrol(panel6_1,...
    'Style', 'Edit',...
    'Units', 'Normalized',...
    'Position', [.35 0.75 0.25 0.15],...
    'String', '0',...
    'Callback', @gratingsDelayEdit_Callback);


text6_3 = uicontrol(panel6_1,...
    'Style', 'Text',...
    'Units', 'Normalized',...
    'Position', [.01 0.45 0.3 0.15],...
    'String', 'Time bin');

text6_4 = uicontrol(panel6_1,...
    'Style', 'Text',...
    'Units', 'Normalized',...
    'Position', [.72 0.45 0.2 0.15],...
    'String', 'msec');

% input time bin
edit6_2 = uicontrol(panel6_1,...
    'Style', 'Edit',...
    'Units', 'Normalized',...
    'Position', [.35 0.45 0.25 0.15],...
    'String', '50',...
    'Callback', @gratingsDelayEdit_Callback);

% plot histograms for gratings push button
pbutton6_1 = uicontrol(panel6_1,...
    'Style', 'pushbutton',...
    'Units', 'Normalized',...
    'Position', [.2 .1 .6 .25],...
    'String', 'Plot Histogram',...
    'Callback', @CRGplotHistogram_Callback);

panel6_2 = uipanel(tab6,...
    'Units', 'Normalized',...
    'Position', [.36 0.05 0.61 0.9],...
    'Title', 'PSTH Fit');

text6_5 = uicontrol(panel6_2,...
    'Style', 'Text',...
    'Units', 'Normalized',...
    'Position', [.0 0.8 0.35 0.15],...
    'String', 'Harmonics',...
    'HorizontalAlignment', 'right');

% number of harmonics pop-up menu
pmenu6_1 = uicontrol(panel6_2,...
    'Style', 'popupmenu',...
    'Units', 'Normalized',...
    'Position', [.37 0.8 0.15 0.15],...
    'String', arrayfun(@(x) sprintf('%g',x), 1:6, 'UniformOutput', 0));


text6_6 = uicontrol(panel6_2,...
    'Style', 'Text',...
    'Units', 'Normalized',...
    'Position', [.0 0.5 0.35 0.15],...
    'String', 'Inv. gain func. poly odrer', ...
    'HorizontalAlignment', 'right');

% number of polynomial's order for the inverse of gain function pop-up menu
pmenu6_2 = uicontrol(panel6_2,...
    'Style', 'popupmenu',...
    'Units', 'Normalized',...
    'Position', [.37 0.5 0.15 0.15],...
    'String', arrayfun(@(x) sprintf('%g',x), 1:5, 'UniformOutput', 0));

text6_7 = uicontrol(panel6_2,...
    'Style', 'Text',...
    'Units', 'Normalized',...
    'Position', [.0 0.2 0.35 0.15],...
    'String', 'Fundamental temp. freq.',...
    'HorizontalAlignment', 'right');

% fundamental frequency selection for the Gratings, pop-up menu
pmenu6_3 = uicontrol(panel6_2,...
    'Style', 'popupmenu',...
    'Units', 'Normalized',...
    'Position', [.37 0.2 0.15 0.15],...
    'String', {'1 Hz', '2 Hz', '3 Hz'});

% Fit & Plot push button
pbutton6_2 = uicontrol(panel6_2,...
    'Style', 'pushbutton',...
    'Units', 'Normalized',...
    'Position', [.65 .3 .3 .4],...
    'String', 'Fit & Plot',...
    'Callback', @fit_plotCRG_Callback);


%% -------------------- Generalized Quadratic Model Tab ---------------------
text7_1 = uicontrol(tab7,...
    'Style', 'Text',...
    'Units', 'Normalized',...
    'Position', [.01 0.65 0.15 0.25],...
    'String', '# Freq. Bands:');

% input latency
edit7_1 = uicontrol(tab7,...
    'Style', 'Edit',...
    'Units', 'Normalized',...
    'Position', [.17 0.73 0.1 0.2],...
    'String', '5');

% text7_2 = uicontrol(tab7,...
%     'Style', 'Text',...
%     'Units', 'Normalized',...
%     'Position', [.22 0.65 0.1 0.25],...
%     'String', 'x fs_0');

text7_3 = uicontrol(tab7,...
    'Style', 'Text',...
    'Units', 'Normalized',...
    'Position', [.01 0.35 0.15 0.25],...
    'String', 'Smoothing Factor:');

% smoothing factor setting
edit7_2 = uicontrol(tab7,...
    'Style', 'Edit',...
    'Units', 'Normalized',...
    'Position', [.17 0.43 0.1 0.2],...
    'String', '20');


text7_4 = uicontrol(tab7,...
    'Style', 'Text',...
    'Units', 'Normalized',...
    'Position', [.5 0.63 0.25 0.25],...
    'String', 'Interpolation Factor',...
    'HorizontalAlignment', 'right');

% interpolation factor
pmenu7_1 = uicontrol(tab7,...
    'Style', 'popupmenu',...
    'Units', 'Normalized',...
    'Position', [.76 0.65 0.1 0.25],...
    'String', {'None', '2', '3', '4', '5'});

text7_5 = uicontrol(tab7,...
    'Style', 'Text',...
    'Units', 'Normalized',...
    'Position', [.02 0.13 0.25 0.15],...
    'String', 'ROI',...
    'HorizontalAlignment', 'left');

% get ROI for receptive field estimation
pmenu7_2 = uicontrol(tab7,...
    'Style', 'popupmenu',...
    'Units', 'Normalized',...
    'Position', [.1 0.15 0.2 0.15],...
    'String', {'Get from STA', 'Get manually'});

% save results push button
pb7_1 = uicontrol(tab7,...
    'Style', 'pushbutton',...
    'Units', 'Normalized',...
    'Position', [.65 0.1 0.2 0.25],...
    'String', 'Save to Disk',...
    'Callback', @GQMsaveToDisk_Callback);


%% --------------------------GUI INITIALIZATION------------------------------
opts = struct;
opts = getParams(opts);

guiInitialization();


%% -----------------------Managing Callbacks---------------------------------

    function guiInitialization()
        
        if ~isempty(opts.DataPath)
            set(text4_1, 'String', opts.DataPath,...
                'HorizontalAlignment', 'left',...
                'ForegroundColor', [0 0 0.7]);
        end
        if ~isempty(opts.StimFilePath)
            set(text4_2, 'String', opts.StimFilePath,...
                'HorizontalAlignment', 'left',...
                'ForegroundColor', [0 0 0.7]);
        end
        if ~isempty(opts.ImagePath)
            set(text4_3, 'String', opts.ImagePath,...
                'HorizontalAlignment', 'left',...
                'ForegroundColor', [0 0 0.7]);
        end
        set(dataMenu, 'Value', 1);
        set(pmenu6_1, 'Value', 6); % setting the number of harmonics for CRG to 6
        set(pmenu6_2, 'Value', 2); % setting the polynomial's order for the inverse of gain function to 2
        set(checkbox3_1, 'Value', opts.SignificanceTestSTA);
        set(checkbox3_2, 'Value', opts.SignificanceTestSTC);
        set(pmenu7_1, 'Value', 3); % setting the interpolation factor in GQM to 3 for visualization
        set(pmenu7_2, 'Value', 1); % setting the ROI option to getting from STA
        set(hfig, 'Visible', 'on');
        set(pmenu3_3, 'Value', 1); % set the latency option to fixed
        
        opts.STA_VarLatency = [];
        
    end


    % callback to the first push button in "Set Path" for data directory
    function setDataPathButton_Callback(hObject, eventdata)
        path_data = uigetdir('', 'Select Data Directory');
        if path_data
            set(text4_1, 'String', path_data,...
                'HorizontalAlignment', 'left',...
                'ForegroundColor', [0 0 0.7]);
            opts.DataPath = path_data;
        end
    end

    % callback to set stimulus path push button in "Set Path"
    function setStimFilePathButton_Callback(hObject, eventdata)
        path_stimfile = uigetdir('', 'Select Stimulus Files Directory');
        if  path_stimfile
            set(text4_2, 'String',  path_stimfile,...
                'HorizontalAlignment', 'left',...
                'ForegroundColor', [0 0 0.7]);
            %opts.StimFilePath = path;
            opts.StimFilePath =  path_stimfile;
        end
    end

    % callback to set image path push button in "Set Path"
    function setImagePath_Callback(hObject, eventdata)
        path_image = uigetdir('', 'Select Stimulus Files Directory');
        if path_image
            set(text4_3, 'String', path_image,...
                'HorizontalAlignment', 'left',...
                'ForegroundColor', [0 0 0.7]);
            opts.ImagePath = path_image;
        end
    end

    % callback to get information file push button in "Set Path"
    function getInfoFile_Callback(hObject, eventdata)
        [InfoName, InfoPath] = uigetfile(fullfile(opts.StimTableFilePath, '*.xlsx'), 'Select Information File');
        if ~(InfoName)
            return
        end
        opts.InfoName = InfoName;
        opts.InfoPath = InfoPath;
        
        set(text4_4, 'String', fullfile(InfoPath, InfoName),...
            'HorizontalAlignment', 'left',...
            'ForegroundColor', [0 0 0.7]);
        [~,~, raw] = xlsread(fullfile(InfoPath, InfoName));
        headers = {'DataName', 'StimFile', 'SpikeSorted'};
        %                      headers = {'DataName', 'StimFile', 'SpikeSorted', 'Track', 'Depth', 'Recording', 'Comment'};
        raw(1, :) = [];
        opts.DataTable = cell2table(raw(:, 1:3), 'VariableNames', headers);
        
        set(dataList, 'String', opts.DataTable.DataName, 'Value', []);
    end

    % callback to refresh_button, in "Load Data" tab
    function refreshList_Callback(hObject, eventdata)
        [~,~, raw] = xlsread(fullfile(opts.InfoPath, opts.InfoName));
        headers = {'DataName', 'StimFile', 'SpikeSorted'};
        %               headers = {'DataName', 'StimFile', 'SpikeSorted', 'Track', 'Depth', 'Recording', 'Comment'};
        raw(1, :) = [];
        opts.DataTable = cell2table(raw(:, 1:3), 'VariableNames', headers);
        set(dataList, 'String', opts.DataTable.DataName, 'Value', []);
    end


    % callback to select data type pop-up menu in "Load Data" tab
    function datatypePopUpMenu_Callback(hObject, eventdata)
        opts.DataTypeValue = hObject.Value;
        opts.DataType = hObject.String{hObject.Value};
    end

    % callback to import push button in "Load Data" tab
    function importPushButton_Callback(hObject, eventdata)
        BLACKROCK_NEV_FILE   = 1;
        SPIKE_TIMES_FILE     = 2;
        KLUSTA_KWIK_FILE     = 3;
        CELL_INFO_FILE       = 4;
        
        opts.STA_VarLatency = [];
        
        % clearing the old data
        opts.Files = [];
        opts.nUnits = [];
        switch dataMenu.Value
            case BLACKROCK_NEV_FILE
                set(dataSelectedList, 'String', opts.SelectedData);
                for iFile = 1 : opts.nDataFiles
                    pathNEV = fullfile(opts.DataPath, [opts.SelectedData{iFile}, '.nev']);
                    opts.Files(iFile).NEV = openNEV(pathNEV, 'read', 'nosave');
                    opts.Files(iFile).StimInfo = load(fullfile(opts.StimFilePath, opts.DataTable.StimFile{opts.SelectedDataValue(iFile)}));
                    %                                    opts.Files(iFile).StimTime = opts.Files(iFile).StimInfo.stim_times;
                    if adaptationCheckBox.Value
                        opts.Files(iFile).StimTime = get_adaptation_stim_times(opts.Files(iFile).NEV, opts.Files(iFile).StimInfo, opts.ImagePath_adaptation);
                        temp_var = matfile(fullfile(opts.ImagePath_adaptation, opts.Files(iFile).StimInfo.stimFile));
                        opts.Files(iFile).StimInfo.dt = temp_var.WGN_dt; % replacing the correct presentation time for WGN chunks
                        opts.Files(iFile).StimInfo.seq = 1 : size(temp_var.WGN, 3); % correcting for the sequence of presentation for WGN chunks
                    else
                        opts.Files(iFile).StimTime = getStimTimes(opts.Files(iFile).NEV, opts.Files(iFile).StimInfo);
                    end
                end
                Str = {'Select Channel'};
                for iChannel = 1 : opts.NEV.nChannels
                    Str = [Str; sprintf('Channel %d', iChannel)];
                end
                set(channelMenu, 'String', Str, 'Value', 1);
                set(unitMenu, 'String', 'Multi-unit', 'Value', 1);
                
            case SPIKE_TIMES_FILE
                set(dataSelectedList, 'String', opts.SelectedData);
                %                             electrodes = {};
                clustersID = [];
                for iFile = 1 : opts.nDataFiles
                    %                                    opts.Files(iFile).DataSorted = import(fullfile(opts.SpikePath, opts.DataTable.SpikeSorted(opts.SelectedDataValue(iFile))));
                    pathNEV = fullfile(opts.DataPath, [opts.SelectedData{iFile}, '.nev']);
                    opts.Files(iFile).NEV = openNEV(pathNEV, 'read', 'nosave');
                    opts.Files(iFile).StimInfo = load(fullfile(opts.StimFilePath, opts.DataTable.StimFile{opts.SelectedDataValue(iFile)}));
                    opts.Files(iFile).DataSorted = importdata(fullfile(opts.SpikePath, [opts.DataTable.SpikeSorted{opts.SelectedDataValue(iFile)} '.mat']));
                    if adaptationCheckBox.Value
                        opts.Files(iFile).StimTime = get_adaptation_stim_times(opts.Files(iFile).NEV, opts.Files(iFile).StimInfo, opts.ImagePath_adaptation);
                        temp_var = matfile(fullfile(opts.ImagePath_adaptation, opts.Files(iFile).StimInfo.stimFile));
                        opts.Files(iFile).StimInfo.dt = temp_var.WGN_dt; % replacing the correct presentation time for WGN chunks
                        opts.Files(iFile).StimInfo.seq = 1 : size(temp_var.WGN, 3); % correcting for the sequence of presentation for WGN chunks
                    else
                        opts.Files(iFile).StimTime = getStimTimes(opts.Files(iFile).NEV, opts.Files(iFile).StimInfo);
                    end
                    clustersID = union(clustersID, unique(opts.Files(iFile).DataSorted(:,2)));
                    
                end
                Str = {'Select Cluster ID'};
                clustersID = num2cell(clustersID);
                clustersID = cellfun(@num2str, clustersID, 'UniformOutput', 0);
                Str = [Str; clustersID];
                set(channelMenu, 'String', Str, 'Value', 1);
                set(unitMenu, 'enable', 'off');
                
                
            case KLUSTA_KWIK_FILE
                set(dataSelectedList, 'String', opts.SelectedData);
                for iFile = 1 : opts.nDataFiles
                    pathNEV = fullfile(opts.DataPath, [opts.SelectedData{iFile}, '.nev']);
                    opts.Files(iFile).NEV = openNEV(pathNEV, 'read', 'nosave');
                    opts.Files(iFile).StimInfo = load(fullfile(opts.StimFilePath, opts.DataTable.StimFile{opts.SelectedDataValue(iFile)}));
                    opts.Files(iFile).StimTime = getStimTimes(opts.Files(iFile).NEV, opts.Files(iFile).StimInfo);
                    opts.pathKwikFile = fullfile(opts.SpikePath , opts.SelectedData{iFile}, [lower(opts.SelectedData{iFile}) , '.kwik']);
                    clusters = hdf5read(opts.pathKwikFile, '/channel_groups/0/spikes/clusters/main');
                    clustersID = unique(clusters);
                end
                Str = {'Select Cluster ID'};
                Str = [Str; clustersID];
                set(channelMenu, 'String', Str, 'Value', 1);
                set(unitMenu, 'enable', 'off');
                
            case CELL_INFO_FILE
                [~,~, raw] = xlsread(opts.cellInfoTable);
                headers = raw(1, :);
                raw(1, :) = [];
                opts.CellTable = cell2table(raw(:, 1:length(headers)), 'VariableNames', headers);
                for iFile = 1 : opts.nDataFiles
                    %                                    opts.Files(iFile).DataSorted = import(fullfile(opts.SpikePath, opts.DataTable.SpikeSorted(opts.SelectedDataValue(iFile))));
                    pathNEV = fullfile(opts.DataPath, [opts.SelectedData{iFile}, '.nev']);
                    opts.Files(iFile).NEV = openNEV(pathNEV, 'read', 'nosave');
                    opts.Files(iFile).StimInfo = load(fullfile(opts.StimFilePath, opts.DataTable.StimFile{opts.SelectedDataValue(iFile)}));
                    opts.Files(iFile).DataSorted = importdata(fullfile(opts.SpikePath, [opts.DataTable.SpikeSorted{opts.SelectedDataValue(iFile)} '.mat']));
                    if adaptationCheckBox.Value
                        opts.Files(iFile).StimTime = get_adaptation_stim_times(opts.Files(iFile).NEV, opts.Files(iFile).StimInfo, opts.ImagePath_adaptation);
                        temp_var = matfile(fullfile(opts.ImagePath_adaptation, opts.Files(iFile).StimInfo.stimFile));
                        opts.Files(iFile).StimInfo.dt = temp_var.WGN_dt; % replacing the correct presentation time for WGN chunks
                        opts.Files(iFile).StimInfo.seq = 1 : size(temp_var.WGN, 3); % correcting for the sequence of presentation for WGN chunks
                    else
                        opts.Files(iFile).StimTime = getStimTimes(opts.Files(iFile).NEV, opts.Files(iFile).StimInfo);
                    end
                    CellsID = opts.CellTable.CellID;
                end
                Str = {'Select Cell ID'};
                Str = [Str; CellsID];
                set(channelMenu, 'String', Str, 'Value', 1);
                set(unitMenu, 'enable', 'off');
                set(dataSelectedList, 'String', opts.SelectedData);
                
        end
    end

    % callback to the complete list of the data in "Load Data" tab
    function dataList_Callback(hObject, eventdata)
        opts.SelectedDataValue      = hObject.Value;
        opts.SelectedData           = hObject.String(hObject.Value);
        opts.nDataFiles             = length(hObject.Value);
    end

    % callback to the select channel pop-up menu in "Load Data" tab
    function channelPopUpMenu_Callback(hObject, eventdata)
        opts.SelectedChannel        = hObject.Value-1;
        BLACKROCK_NEV_FILE   = 1;
        SPIKE_TIMES_FILE     = 2;
        KLUSTA_KWIK_FILE     = 3;
        CELL_INFO_FILE       = 4;
        
        switch dataMenu.Value
            case BLACKROCK_NEV_FILE
                opts.SelectedEletrode       = opts.NEV.Channel2ElectrodeMap(hObject.Value-1);
                if hObject.Value==1
                    return
                end
                for iFile = 1 : opts.nDataFiles
                    SpikesIdx = find(opts.Files(iFile).NEV.Data.Spikes.Electrode == opts.SelectedEletrode );
                    SpikeTime = double(opts.Files(iFile).NEV.Data.Spikes.TimeStamp(SpikesIdx)) / opts.NEV.Fs;
                    SpikeUnit = double(opts.Files(iFile).NEV.Data.Spikes.Unit(SpikesIdx));
                    opts.nUnits(iFile) = opts.Files(iFile).NEV.ElectrodesInfo(opts.SelectedChannel).Units;
                    opts.Files(iFile).DataSorted = horzcat(SpikeUnit(:), SpikeTime(:));
                    opts.Files(iFile).SpikeTime = SpikeTime; % initialize the spike time vector with the multi units
                end
                units = {'Multi-unit'};
                if max(opts.nUnits)
                    for iUnit = 0 : max(opts.nUnits)
                        units = [units; sprintf('Unit %d', iUnit)];
                    end
                end
                set(unitMenu, 'String', units)
            case SPIKE_TIMES_FILE
                opts.SelectedCluster       = hObject.String{hObject.Value};
                if hObject.Value==1
                    return
                else
                    clusterID = str2num(hObject.String{hObject.Value});
                end
                for iFile = 1 : opts.nDataFiles
                    opts.Files(iFile).SpikeTime = opts.Files(iFile).DataSorted(opts.Files(iFile).DataSorted(:, 2) == clusterID, 1);
                end
                
                
            case KLUSTA_KWIK_FILE
                opts.SelectedCluster       = hObject.String{hObject.Value};
                if hObject.Value==1
                    return
                else
                    clusterID = str2num(hObject.String{hObject.Value});
                end
                for iFile = 1 : opts.nDataFiles
                    spikes = hdf5read(opts.pathKwikFile, '/channel_groups/0/spikes/time_samples');
                    clusters = hdf5read(opts.pathKwikFile, '/channel_groups/0/spikes/clusters/main');
                    opts.Files(iFile).SpikeTime = double(spikes(clusters == clusterID))/opts.NEV.Fs;
                end
                
            case CELL_INFO_FILE
                opts.SelectedCellID = hObject.String{hObject.Value};
                if hObject.Value==1
                    return
                end
                try
                    clusterID = opts.CellTable.ClusterIDs{hObject.Value-1};
                catch
                    clusterID = opts.CellTable.ClusterIDs(hObject.Value-1);
                end
                if ~isa(clusterID, 'double')
                    clusterID = strsplit(clusterID, ',');
                    clusterID = cellfun(@str2num, clusterID);
                end
                for iFile = 1 : opts.nDataFiles
                    spikeIdx = sum(bsxfun(@eq, opts.Files(iFile).DataSorted(:, 2), clusterID), 2);
                    spikeIdx = logical(spikeIdx);
                    opts.Files(iFile).SpikeTime = opts.Files(iFile).DataSorted(spikeIdx, 1);
                end
        end
    end

    % callback to the select unit pop-up menu in "Load Data" tab
    function unitPopUpMenu_Callback(hObject, eventdata)
        opts.SelectedUnit = hObject.Value-2;
        if opts.SelectedUnit >= 0     % a specific unit other than multi-unit is selected
            for iFile = 1 : opts.nDataFiles
                opts.Files(iFile).SpikeTime = opts.Files(iFile).DataSorted( opts.Files(iFile).DataSorted==opts.SelectedUnit , 2);
            end
        else % multi-unit case
            for iFile = 1 : opts.nDataFiles
                opts.Files(iFile).SpikeTime = opts.Files(iFile).DataSorted(: , 2);
            end
        end
    end


    % callback to pmenu3_1, whitening pop-up menu in tab 3
    function whiteningPopUpMenu_Callback(hObject, eventdata)
        opts.WhiteningTypeValue = hObject.Value;
    end

    % callback to pmenu3_2, image transformation pop-up menu in tab3
    function imageTransformationMenu_Callback(hObject, eventdata)
        opts.ImageTransformationValue = hObject.Value;
    end

    % callback to edit2_1, edit text box for delay input in tab2
    function DelayEdit_Callback(hObject, eventdata)
        opts.StatsDelay = str2double(hObject.String);
    end

    % callback to edit2_2, edit text box for time bin input in tab2
    function StatsTimeBinEdit_Callback(hObject, eventdata)
        opts.StatsTimeBin = str2double(hObject.String);
    end

    % callback to pmenu2_1, plot type top-up menu in the "Spike Train Statistics"
    function statsAnalysisTypePopUpMenu_Callback(hObject, eventdata)
        opts.StatsAnalysisTypeValue = hObject.Value;
    end

    % callback to pbutton2_1, plot push button in the "Spike Train Statistics"
    function plotStatsPushButton_Callback(hObject, eventdata)
        if channelMenu.Value == 1
            msgbox({'No channel has been selected!', 'Select a channel and try again.'},'Error', 'warn');
            return;
        end
        BLACKROCK_NEV_FILE   = 1;
        SPIKE_TIMES_FILE     = 2;
        KLUSTA_KWIK_FILE     = 3;
        CELL_INFO_FILE       = 4;
        
        HISTOGRAM_PLOT       = 1;
        RASTEROGRAM_PLOT     = 2;
        SPIKE_COUNTS_PLOT    = 3;
        plotType = get(pmenu2_1, 'Value'); % get plot type from the top-up menu menu
        binSize = str2double(edit2_2.String)/1000; % get bin size in msec, converts to sec
        delay = str2double(edit2_1.String)/1000;  % converts to sec
        spikeHist = [];
        count = 1;
        switch plotType
            case HISTOGRAM_PLOT
                for iFile = 1 : opts.nDataFiles
                    [nTrials, nStimulus] = size(opts.Files(iFile).StimInfo.seq);
                    if isfield(opts.Files(iFile).StimInfo, 'stimSettings')
                        DT(iFile) = str2double(opts.Files(iFile).StimInfo.stimSettings.vars.preStimDelay) + ...
                            str2double(opts.Files(iFile).StimInfo.stimSettings.vars.stimDuration) + ...
                            str2double(opts.Files(iFile).StimInfo.stimSettings.vars.postStimDelay);
                    else
                        DT(iFile) = sum(opts.Files(iFile).StimInfo.dt(:));
                    end
                    spikeTime = opts.Files(iFile).SpikeTime;
                    stimulusTime = opts.Files(iFile).StimTime;
                    edges = 0:binSize:DT(iFile);
                    centers = edges(1:end-1) + diff(edges)/2;
                    timeExtract = @(x) spikeTime(spikeTime - x > 0 & spikeTime - x <= DT(iFile)) - x;
                    %                                    spikeHist = zeros(nTrials * nStimulus, length(centers));
                    for iTrials = 1 : nTrials
                        for iStim = 1 : nStimulus
                            %                                               stimulusTime((iTrials-1)*nStimulus + iStim)
                            spikeHist(count, :) = histcounts(timeExtract(stimulusTime((iTrials-1)*nStimulus + iStim) + delay), edges);
                            count = count + 1;
                        end
                    end
                end
                figure('name', 'Post-Stimulus Time Histogram');
                bar(centers, mean(spikeHist, 1)/binSize, 'hist', 'c');
                xlim([0 DT(1)])
                xlabel('time [sec]', 'fontsize', 12)
                ylabel('Spike/sec', 'fontsize', 14)
                if nTrials > 1
                    hold on;
                    errorbar(centers, mean(spikeHist, 1)/binSize, zeros(size(centers)), std(spikeHist, 1)/sqrt(nTrials*nStimulus)/binSize, '.r')
                end
                switch dataMenu.Value
                    case KLUSTA_KWIK_FILE
                        title(['cluster ID #', opts.SelectedCluster])
                end
                
            case RASTEROGRAM_PLOT
                %                             for iFile = 1 : opts.nDataFiles,
                %                                    [nTrials, nStimulus] = size(opts.Files(iFile).StimInfo.seq);
                %                                    if isfield(opts.Files(iFile).StimInfo, 'stimSettings'),
                %                                           DT(iFile) = str2double(opts.Files(iFile).StimInfo.stimSettings.vars.preStimDelay) + ...
                %                                                  str2double(opts.Files(iFile).StimInfo.stimSettings.vars.stimDuration) + ...
                %                                                  str2double(opts.Files(iFile).StimInfo.stimSettings.vars.postStimDelay);
                %                                    else
                %                                           DT(iFile) = sum(opts.Files(iFile).StimInfo.dt(:));
                %                                    end
                %                                    spikeTime = opts.Files(iFile).SpikeTime;
                %                                    stimulusTime = opts.Files(iFile).StimTime;
                %                                    for iTrials = 1 : nTrials,
                %                                           x = spikeTime(spikeTime > stimulusTime((iTrials-1)*nStimulus+1) & )
                %                                    end
                %                             end
                
            case SPIKE_COUNTS_PLOT
                if opts.nDataFiles > 1
                    msgbox({'This module has not designed for multiple files!', 'Select a data file and try again.'},'Error', 'warn');
                    return;
                else
                    seq = opts.Files.StimInfo.seq;
                    [nTrials, nStimulus] = size(seq);
                    if isfield(opts.Files.StimInfo, 'stimSettings')
                        DT = str2double(opts.Files.StimInfo.stimSettings.vars.preStimDelay) + ...
                            str2double(opts.Files.StimInfo.stimSettings.vars.stimDuration) + ...
                            str2double(opts.Files.StimInfo.stimSettings.vars.postStimDelay);
                    else
                        DT = sum(opts.Files.StimInfo.dt(:));
                    end
                    spikeTime = opts.Files.SpikeTime;
                    stimulusTime = opts.Files.StimTime;
                    [~, idx] = sort(seq, 2);
                    Response = AccSpk(spikeTime, stimulusTime, numel(seq), DT, delay);
                    Response = reshape(Response, size(seq));
                    response = zeros(size(seq));
                    for iTrials = 1 : nTrials
                        response(iTrials, :) = Response(iTrials, idx(iTrials, :));
                    end
                    meanSpk = mean(response);
                    [meanSpk, idx_mn] = sort(meanSpk, 'descend');
                    seSpk = std(response)/sqrt(nTrials);
                    seSpk = seSpk(idx_mn);
                    figure('name', 'Spike-count per Stimulus');
                    shadedErrorBar([], meanSpk, seSpk, {'.r','markerfacecolor','r'}, 1)
                    title('Spike-count mean & variance across images')
                    ylabel('spikes')
                    xlabel('image indices')
                    
                    
                end
                
                
        end
        
    end

    % callback to pb3_1, compute STA push button in tab3
    function computeSTApushButton_Callback(hObject, eventdata)
        BLACKROCK_NEV_FILE   = 1;
        SPIKE_TIMES_FILE     = 2;
        KLUSTA_KWIK_FILE     = 3;
        CELL_INFO_FILE       = 4;
        whitening_OFF        = 1;
        whitening_ON         = 2;
        
        if channelMenu.Value == 1
            msgbox({'No channel has been selected!', 'Select a channel and try again.'},'Error', 'warn');
            return;
        end
        
        whitening_flag = get(pmenu3_1, 'Value');
        Cx = 0;
        data_list = get(dataSelectedList,'String');
        
        if pmenu3_3.Value == 1
            Latency = str2double(get(edit3_1, 'String')) * 1e-3 * ones(length(data_list),1);
        elseif (pmenu3_3.Value == 2) && isempty(opts.STA_VarLatency)
            msgbox({'No variable latency has been set!'},'Error', 'warn');
            return
        else
            Latency = cell2mat(opts.STA_VarLatency) * 1e-3;
        end
        opts.LatencySTA = Latency;
        
        
        sta           = 0;
        STA_bootstrap = 0;
        nSpikes       = 0;
        h = waitbar(0, 'Please wait...', 'name', 'Spike-Triggered Average');
        for iFile = 1 : length(opts.Files)
            waitbar((iFile-1)/length(opts.Files), h, ['processing ' strrep(data_list{iFile}, '_', ' ') '...'])
            Response = AccSpk(opts.Files(iFile).SpikeTime,...
                opts.Files(iFile).StimTime,...
                numel(opts.Files(iFile).StimInfo.seq),...
                opts.Files(iFile).StimInfo.dt,...
                opts.LatencySTA(iFile));
            %             Response = AccSpk(opts.Files(iFile).SpikeTime,...
            %                 opts.Files(iFile).StimTime,...
            %                 numel(opts.Files(iFile).StimInfo.seq),...
            %                 .010,...
            %                 opts.LatencySTA(iFile));
            
            if isempty(Response)
                warning('There is no spike for the selected unit in data %s. Skipping this file!\n', dataSelectedList.String{iFile});
                continue
            end
            
            if adaptationCheckBox.Value
                temp_var = matfile(fullfile(opts.ImagePath_adaptation, opts.Files(iFile).StimInfo.stimFile));
                images = temp_var.WGN;
            else
                load(fullfile(opts.ImagePath, opts.Files(iFile).StimInfo.stimFile), 'images');
            end
            images = images - 0.5;
            %%%%%%%%%%%%%%%%%%%%%%%%%%
            %                         images = imresize(images, 1/2, 'box'); % downsampling the images, should be commented normally
            %%%%%%%%%%%%%%%%%%%%%%%%%
            imgSize = size(images);
            opts.OriginalSTAsize = imgSize([1 2]);
            opts.StimSzDeg = opts.Files(iFile).StimInfo.stimSize(1);
            images = reshape(images, [], length(images));
            images = images(:, opts.Files(iFile).StimInfo.seq);
            
            % applying the image transformation
            IMAGE_ABS      = 2;
            IMAGE_SQUARED  = 3;
            image_transformation = get(pmenu3_2, 'Value');
            switch image_transformation
                case IMAGE_ABS
                    images = abs(images);
                    %                              images = images - mean(images(:));
                    images = bsxfun(@minus, images, mean(images, 2));
                case IMAGE_SQUARED
                    images = images.^2;
                    images = bsxfun(@minus, images, mean(images, 2));
            end
            
            Cx = Cx + images * images'/ size(images, 2);
            
            sta = sta + images * Response';
            %             sta = sta + images * max(response_ - Response, 0)';
            
            % compute the confidence interval
            if checkbox3_1.Value
                for k = 1 : opts.nBootstrap
                    response_ = circshift(Response, [0, randi(length(Response))] );
                    sta_bootstrap(:, k) = images * response_';
                end
                STA_bootstrap = STA_bootstrap + sta_bootstrap;
            end
            
            nSpikes = nSpikes + sum(Response);
            waitbar(iFile/length(opts.Files), h, ['processing ' strrep(data_list{iFile}, '_', ' ') '...'])
        end
        close(h)
        opts.StimDim = sqrt(size(images, 1));
        
        
        if whitening_flag == whitening_ON
            [V, D] = eig(Cx);
            [d, idx] = sort(diag(D), 'descend');
            V = V(:, idx);
            cutoff = 0.4 * length(d);
            d = d.^(-1/2);
            d(ceil(cutoff):end) = 0;
            whitening_matrix = V * diag(d) * V';
            STA = whitening_matrix * sta / nSpikes;
            opts.Whitening_Matrix = whitening_matrix;
        else
            STA = sta / nSpikes;
            opts.Whitening_Matrix = [];
        end
        
        STA = reshape(STA, sqrt(size(images, 1)), []);
        opts.STA = STA;
        opts.STAforSave = [];
        opts.ROIposition = [];
        
        
        
        
        STAfig = figure(...
            'Units','Normalized',...
            'Visible','off',...
            'name', 'Spike-Triggered Analysis',...
            'Position', [0.35 0.35 0.35 0.5]);
        
        crop_pushbutton = uicontrol(STAfig,...
            'Style', 'pushbutton', ...
            'String', 'Select ROI',...
            'Units', 'Normalized', ...
            'Position', [0.01 0.01 0.15 0.1],...
            'Callback', @cropSTA_callback);
        
        computeSTC_pushbutton = uicontrol(STAfig,...
            'Style', 'pushbutton', ...
            'String', 'compute STC',...
            'Units', 'Normalized', ...
            'Position', [0.25 0.01 0.15 0.1],...
            'Callback', @computeSTC_callback);
        
        computeGQM_pushbutton = uicontrol(STAfig,...
            'Style', 'pushbutton', ...
            'String', 'compute GQM',...
            'Units', 'Normalized', ...
            'Position', [0.45 0.01 0.15 0.1],...
            'Callback', @computeGQM_callback);
        
        computeGQM_pushbutton = uicontrol(STAfig,...
            'Style', 'pushbutton', ...
            'String', 'Import ROI',...
            'Units', 'Normalized', ...
            'Position', [0.75 0.01 0.15 0.1],...
            'Callback', @ImportROI_callback);
        
        hSTA = axes('Parent', STAfig,...
            'Units','Normalized',...
            'Position', [0.05 0.2 0.9 0.7]);
        
        maxi = max(abs(STA(:)));
        if image_transformation > 1
            imshow(opts.STA,[], 'InitialMagnification', 'fit')
            colormap(gray)
        else
            imshow(opts.STA, [-maxi, maxi], 'InitialMagnification', 'fit')
            colormap(hSTA, scm(256))
        end
        colorbar
        switch dataMenu.Value
            case BLACKROCK_NEV_FILE
                title(['Spike-Triggered Average, Channel #', num2str(opts.SelectedChannel)])
            case SPIKE_TIMES_FILE
                title(['cluster ID #', opts.SelectedCluster])
            case KLUSTA_KWIK_FILE
                title(['cluster ID #', opts.SelectedCluster])
            case CELL_INFO_FILE
                title(['Cell ID #', opts.SelectedCellID])
        end
        axis(hSTA, 'image');
        STAfig.Visible = 'on';
        opts.STAfig = STAfig;
        
        
        if checkbox3_1.Value
            % compute the p-value map for STA
            STA_bootstrap = STA_bootstrap/nSpikes;
            sta_mean = mean(STA_bootstrap, 2);
            sta_sd = std(STA_bootstrap, 1, 2);
            z_values = (sta_mean - STA(:))./sta_sd;
            p_values = 1 - ( normcdf(abs(z_values)) - normcdf(-abs(z_values)) );
            P_value_mask = (p_values <= .05);
            Prop = 100*mean(bsxfun(@ge, sta_bootstrap, abs(STA(:))), 2);
            Prop_mask = (Prop <= 5);
            
            ax = figure('name', 'p-value Map');
            imshow(reshape(P_value_mask, opts.StimDim, []), [0 1], 'InitialMagnification','fit');
            colorbar; axis image; title('p-value < 5% Map'); colormap(ax, 'gray')
        end
        
    end

    % callback to crop_pushbutton in STA figure
    function cropSTA_callback(hObject, eventdata)
        BLACKROCK_NEV_FILE   = 1;
        SPIKE_TIMES_FILE     = 2;
        KLUSTA_KWIK_FILE     = 3;
        CELL_INFO_FILE       = 4;
        h = imrect;
        pos = wait(h);
        pos = int16(pos);
        opts.ROIposition = pos;
        fprintf('STA region of interest was exported:\n');
        disp(int16(opts.ROIposition))
        figure('Name', 'Cropped STA')
        sta = opts.STA(pos(2):pos(2)+pos(4), pos(1):pos(1)+pos(3));
        imagesc(sta, [-max(abs(sta(:))) max(abs(sta(:)))])
        colormap(scm(256))
        colorbar
        switch dataMenu.Value
            case BLACKROCK_NEV_FILE
                title(['Spike-Triggered Average, Channel #', num2str(opts.SelectedChannel)])
            case SPIKE_TIMES_FILE
                title(['cluster ID #', opts.SelectedCluster])
            case KLUSTA_KWIK_FILE
                title(['cluster ID #', opts.SelectedCluster])
            case CELL_INFO_FILE
                title(['Cell ID #', opts.SelectedCellID])
        end
        axis image;
        opts.STAforSave = sta;
        opts.STCeigenvaluesSeq = [];
        opts.ExcitatorySubunits = [];
        opts.SuppressiveSubunits = [];
        assignin('base', 'sta_cropped_position', pos)
        pos = double(pos);
        Px_per_Deg = opts.Files(1).StimInfo.srcSz./opts.Files(1).StimInfo.stimSize;
        mux = (pos(1) + pos(3)/2 - opts.Files(1).StimInfo.srcSz(1)/2) / Px_per_Deg(1);
        muy = (pos(2) + pos(4)/2 - opts.Files(1).StimInfo.srcSz(2)/2) / Px_per_Deg(2);
        
        RFsize = double(pos(3:4))./Px_per_Deg;
        fprintf('RF size: [width , height] = [%.02f , %.02f] Deg. \n', RFsize(1), RFsize(2))
        fprintf('RF position (off centre): [width , height] = [%.02f , %.02f] Deg. \n', mux, -muy)
    end


    function ImportROI_callback(hObject, eventdata)
        BLACKROCK_NEV_FILE   = 1;
        SPIKE_TIMES_FILE     = 2;
        KLUSTA_KWIK_FILE     = 3;
        CELL_INFO_FILE       = 4;
        
        temp = evalin('base', 'who');
        temp = [{'--> Cancel Selection <--'}; temp];
        fig3 = figure('Visible', 'on', 'Units', 'Normalized',...
            'Position', [.6 .6 .15 .35]); clf;
        VarList = uicontrol(fig3,...,
            'Style', 'listbox',...
            'Units', 'Normalized',...
            'Position', [.15 .1 .7 .88],...
            'String', temp, 'FontSize', 13);
        h = uicontrol(fig3, 'Units', 'Normalized', 'Position',[.35 .01 .3 .06],'String', 'Apply & Exit',...
            'Callback', 'uiresume(gcbf)');
        set(fig3, 'Visible', 'on', 'MenuBar', 'none', 'ToolBar', 'none', ...
            'Name', 'Select ROI variable');
        uiwait(gcf);
        
        if VarList.Value == 1
            close(fig3)
            return
        end
        
        pos = evalin('base', VarList.String{VarList.Value});
        close(fig3)
        if ~prod(size(pos)==[1 4])
            msgbox({'The imported ROI is invalid!','A valid ROI must be a row vector containing four integer elements.'},'Error', 'warn');
            return
        end
        pos = int16(pos);
        opts.ROIposition = pos;
        fprintf('STA region of interest was imported:\n');
        rectangle(opts.STAfig.CurrentAxes, 'Position', pos)
        disp(int16(opts.ROIposition))
        figure('Name', 'Cropped STA')
        sta = opts.STA(pos(2):pos(2)+pos(4), pos(1):pos(1)+pos(3));
        imagesc(sta, [-max(abs(sta(:))) max(abs(sta(:)))])
        colormap(scm(256))
        colorbar
        switch dataMenu.Value
            case BLACKROCK_NEV_FILE
                title(['Spike-Triggered Average, Channel #', num2str(opts.SelectedChannel)])
            case SPIKE_TIMES_FILE
                title(['cluster ID #', opts.SelectedCluster])
            case KLUSTA_KWIK_FILE
                title(['cluster ID #', opts.SelectedCluster])
            case CELL_INFO_FILE
                title(['Cell ID #', opts.SelectedCellID])
        end
        axis image;
        opts.STAforSave = sta;
        opts.STCeigenvaluesSeq = [];
        opts.ExcitatorySubunits = [];
        opts.SuppressiveSubunits = [];
        assignin('base', 'sta_cropped_position', pos)
        pos = double(pos);
        Px_per_Deg = opts.Files(1).StimInfo.srcSz./opts.Files(1).StimInfo.stimSize;
        mux = (pos(1) + pos(3)/2 - opts.Files(1).StimInfo.srcSz(1)/2) / Px_per_Deg(1);
        muy = (pos(2) + pos(4)/2 - opts.Files(1).StimInfo.srcSz(2)/2) / Px_per_Deg(2);
        
        RFsize = double(pos(3:4))./Px_per_Deg;
        fprintf('RF size: [width , height] = [%.02f , %.02f] Deg. \n', RFsize(1), RFsize(2))
        fprintf('RF position (off centre): [width , height] = [%.02f , %.02f] Deg. \n', mux, -muy)
    end

    % callback to compute STC push button in STA figure
    function computeSTC_callback(hObject, eventdata)
        whitening_flag = get(pmenu3_1, 'Value');
        whitening_ON = 2;
        try
            pos = int16(opts.ROIposition);
            STA = opts.STA(pos(2):pos(2)+pos(4), pos(1):pos(1)+pos(3));
            cropState = true;
        catch
            warning('Region of interest for cropping STA does not exist')
            STA = opts.STA;
            cropState = false;
        end
        STA = STA(:);
        
        data_list = get(dataSelectedList,'String');
        nSpikes       = 0;
        Response = [];
        Images = [];
        h = waitbar(0, 'Please wait...', 'name', 'Spike-Triggered Covariance');
        for iFile = 1 : length(opts.Files)
            waitbar((iFile-1)/length(opts.Files), h, ['processing ' strrep(data_list{iFile}, '_', ' ') '...'])
            response = single(AccSpk(opts.Files(iFile).SpikeTime,...
                opts.Files(iFile).StimTime,...
                numel(opts.Files(iFile).StimInfo.seq),...
                opts.Files(iFile).StimInfo.dt,...
                opts.LatencySTA(iFile)));
            Response = [Response; response(:)];
            nSpikes = nSpikes + sum(response);
            
            if adaptationCheckBox.Value
                temp_var = matfile(fullfile(opts.ImagePath_adaptation, opts.Files(iFile).StimInfo.stimFile));
                images = temp_var.WGN;
            else
                load(fullfile(opts.ImagePath, opts.Files(iFile).StimInfo.stimFile), 'images');
            end
            images = images - 0.5;
            %%%%%%%%%%%%%%%%%%%%%%%%%%
            %                         images = imresize(images, 1/2, 'box'); % downsampling the images, should be commented normally
            %%%%%%%%%%%%%%%%%%%%%%%%%
            
            % perform whitening
            if whitening_flag == whitening_ON
                images = reshape(images, [], length(images));
                images = opts.Whitening_Matrix * images;
                images = reshape(images, opts.OriginalSTAsize(1), opts.OriginalSTAsize(2), []);
            end
            
            
            
            if cropState
                images = images(pos(2):pos(2)+pos(4), pos(1):pos(1)+pos(3), :);
                imageSize = size(images);
            end
            images = reshape(images, [], length(images));
            images = images(:, opts.Files(iFile).StimInfo.seq);
            Images = cat(2, Images, images);
            waitbar(iFile/length(opts.Files), h, ['processing ' strrep(data_list{iFile}, '_', ' ') '...'])
        end
        close(h)
        
        % project out STA from image ensemble
        X = Images - STA * (STA' * Images)/sum(STA.^2);
        Alpha = repmat(Response', size(Images, 1), 1);
        STC = (Alpha .* X) * X' / length(Images);
        
        
        % compute the confidence interval
        if checkbox3_2.Value
            h = waitbar(0, 'Please wait...');
            set(h, 'name', 'Eigenvalue Significance Test');
            for k = 1 : opts.nBootstrap
                response_ = circshift(Response', [0, randi(length(Response))] );
                sta_ = Images * response_'/sum(response_);
                X_ = Images - sta_ * (sta_' * Images)/sum(sta_.^2);
                Alpha_ = repmat(response_, size(Images, 1), 1);
                stc_ = (Alpha_ .* X_) * X_'/length(response_);
                [E_, D_] = eig(stc_);
                [dummy_(k, :), order_] = sort(diag(D_), 'descend');
                waitbar(k/opts.nBootstrap)
            end
            close(h)
            dummy_ = dummy_(:, 1:end-1);
            delta_ = -diff(dummy_, 1, 2);
        end
        
        [E, D]               = eig(STC);
        [eigenvalues, order] = sort(diag(D), 'descend');
        eigenvectors         = E(:, order);
        eigenvalues          = eigenvalues(1: end-1);
        eigenvectors         = eigenvectors(:, 1:end-1);
        opts.STCeigenvaluesSeq = eigenvalues;
        
        
        figure('name', 'STC-Eigenvalue Visualization',...
            'Units', 'Normalized', ...
            'OuterPosition', [0 0 .5 1]);
        subplot(3,2,1:2); plot(eigenvalues, '.k', 'markersize', 10); xlabel('Rank'); ylabel('Eigenvalue')
        if checkbox3_2.Value
            hold on; shadedErrorBar([], mean(dummy_), 5*std(dummy_), '--r', 1)
        end
        title('The whole sequence of eigenvalues')
        subplot(3,2,3); plot(eigenvalues(1:10), '.b', 'markersize', 15); xlabel('Rank'); ylabel('Eigenvalue')
        if checkbox3_2.Value
            hold on; shadedErrorBar([], mean(dummy_(:, 1:10)), 5*std(dummy_(:, 1:10)), '--r', 1)
        end
        title('The first 10 eigenvalues')
        subplot(3,2,4); plot(length(eigenvalues)-9:length(eigenvalues), eigenvalues(end-9:end), '.b', 'markersize', 15);
        if checkbox3_2.Value
            hold on; shadedErrorBar(length(eigenvalues)-9:length(eigenvalues), mean(dummy_(:, end-9:end)), 5*std(dummy_(:, end-9:end)), '--r', 1)
        end
        xlabel('Rank'); ylabel('Eigenvalue'); title('The last 10 eigenvalues')
        subplot(3,2,5:6); plot(-diff(eigenvalues), '.b', 'markersize', 15)
        if checkbox3_2.Value
            hold on; shadedErrorBar([], mean(delta_), 5*std(delta_), '--r', 1)
        end
        xlabel('Rank'); ylabel('\Delta Eigenvalue');
        
        
        figure('name', 'STC-First 4 Filters', ...
            'Units', 'Normalized', ...
            'OuterPosition', [0.5 0.5 0.4 .5])
        for i = 1 : 4
            subplot(2, 2, i);
            maxi = max(abs(eigenvectors(:,i)));
            imshow(reshape(eigenvectors(:,i), imageSize(1), imageSize(2)), [-maxi maxi], 'initialmagnification', 'fit')
            colormap(gca, scm(256)); colorbar
            title(['u_', num2str(i)])
            opts.ExcitatorySubunits(:,:, i) = reshape(eigenvectors(:,i), imageSize(1), imageSize(2));
        end
        
        
        figure('name', 'STC-Last 4 Filters', ...
            'Units', 'Normalized', ...
            'OuterPosition', [0.5 0 0.4 .5])
        for i = 0 : 3
            subplot(2, 2, i+1);
            maxi = max(abs(eigenvectors(:, end-i)));
            imshow(reshape(eigenvectors(:, end-i), imageSize(1), imageSize(2)), [-maxi maxi], 'initialmagnification', 'fit')
            colormap(gca, scm(256)); colorbar
            title(sprintf('u_{%d}', size(eigenvectors, 2)-i) )
            opts.SuppressiveSubunits(:,:, i+1) = reshape(eigenvectors(:, end-i), imageSize(1), imageSize(2));
        end
        
    end

    % the callback to pb3_2, save to disk the STA/STC results push button
    function saveToDisk_Callback(hObject, eventdata)
        BLACKROCK_NEV_FILE   = 1;
        SPIKE_TIMES_FILE     = 2;
        KLUSTA_KWIK_FILE     = 3;
        CELL_INFO_FILE       = 4;
        results.STA = opts.STAforSave;
        results.ROI = opts.ROIposition;
        results.stimSzPx = opts.OriginalSTAsize;
        results.eigValues = opts.STCeigenvaluesSeq;
        results.ExcUnits = opts.ExcitatorySubunits;
        results.SupUnits = opts.SuppressiveSubunits;
        results.Recordings = opts.SelectedData;
        results.stimSzDeg = opts.StimSzDeg;
        results.Latency = opts.LatencySTA;
        if isfield(opts, 'STA_savePath')
            savePath = opts.STA_savePath;
        else
            savePath = opts.InfoPath;
        end
        switch dataMenu.Value
            case BLACKROCK_NEV_FILE
                saveName = fullfile(savePath, ['results-Chan_' num2str(opts.SelectedChannel) '.mat']);
                results.Channel = opts.SelectedChannel;
            case SPIKE_TIMES_FILE
                saveName = fullfile(savePath, ['ClusterID_', opts.SelectedCluster(~isspace(opts.SelectedCluster)), '.mat']);
                results.ClusterID = opts.SelectedCluster;
            case KLUSTA_KWIK_FILE
                saveName = fullfile(savePath, ['ClusterID_', opts.SelectedCluster(~isspace(opts.SelectedCluster)), '.mat']);
                results.ClusterID = opts.SelectedCluster;
            case CELL_INFO_FILE
                saveName = fullfile(savePath, ['gui_CellID_', opts.SelectedCellID(~isspace(opts.SelectedCellID)), '.mat']);
                results.CellID = opts.SelectedCellID;
        end
        
        [filename, pathname] = uiputfile('*.mat', 'Save spike-triggered analysis results as', saveName);
        if ~filename
            return
        else
            opts.STA_savePath = pathname;
        end
        
        save(fullfile(pathname, filename), '-struct', 'results', '-v7.3');
        fprintf('Result was saved to disk as %s.\n', filename)
        
    end


    function computeGQM_callback(hObject, eventdata)
        BLACKROCK_NEV_FILE   = 1;
        SPIKE_TIMES_FILE     = 2;
        KLUSTA_KWIK_FILE     = 3;
        CELL_INFO_FILE       = 4;
        try
            ROI = int16(opts.ROIposition);
            M = ROI(4)+1; N = ROI(3)+1;
        catch
            msgbox({'Region of interest for RF estimation does not exist!', 'Select a Region and try again.'},'Error', 'warn');
            return;
        end
        
        % get interpolation factor for visualization
        opts.GQM_interpolationFactor = get(pmenu7_1, 'Value');
        opts.GQM.lambda_d2x = str2double(get(edit7_2, 'String')); % smoothing factor for GQM regularization
        Nf = uint8(str2double(get(edit7_1, 'String'))); % number of frequency bands
        opts.GQM.data_list = get(dataSelectedList,'String');
        
        srcSz = opts.Files(1).StimInfo.srcSz(1); % the size of stimulus in pixels
        x1 = ROI(2); x2 = ROI(2)+ROI(4);
        y1 = ROI(1); y2 = ROI(1)+ROI(3);
        
        if M ~= N
            
            edges = [x2 y2]-[x1 y1];
            centre = [x1 y1] + edges/2;
            Edge = double(max(edges));

            radius = (Edge-1)/2;
            x1 = centre(1) - radius; x2 = centre(1) + radius;
            y1 = centre(2) - radius; y2 = centre(2) + radius;
            % check if the new ROI is valid
            if y1 < 1
                y2 = y2 - y1 + 1;
                y1 = y1 - y1 + 1;
            elseif y2 > srcSz
                y1 = y1 - (y2 - srcSz);
                y2 = y2 - (y2 - srcSz);
            end
            if x1 < 1
                x2 = x2 - x1 + 1;
                x1 = x1 - x1 + 1;
            elseif x2 > srcSz
                x1 = x1 - (x2 - srcSz);
                x2 = x2 - (x2 - srcSz);
            end
            ROI = [y1 x1 y2-y1 x2-x1];
        else
            Edge = x2-x1;
        end
        
        % create the Fourier basis functions to reduce the dimensionality
        params.patchSizeDeg = opts.Files(1).StimInfo.stimSize(1);
        image_resize_factor = 3;
        params.patchSizePx = srcSz * image_resize_factor; % the number of pixels in the Basis functions
        params.fs0_cyc_deg = srcSz / params.patchSizeDeg / double(Edge);  % base fundamental frequency in cycles per deg
        params.Nf = double(Nf);  % number of frequency steps in scale
        
        [Basis_original, ~] = genFourierBasis(params);
        Basis_ = reshape(Basis_original, params.patchSizePx, params.patchSizePx, []);
        BasisNum = size(Basis_, 3);
        
        tmp = image_resize_factor;
        MM = tmp*(x2 - x1 + 1);
        NN = tmp*(y2 - y1 + 1);
        Basis = Basis_((tmp*x1-(tmp-1):tmp*x2), (tmp*y1-(tmp-1):tmp*y2), :);
        Basis = reshape(Basis, [], size(Basis, 3));
        
        Response      = [];
        Xstim         = [];
        nSpikes       = 0;
        h = waitbar(0, 'Please wait...', 'name', 'RF estimation via GQM');
        for iFile = 1 : length(opts.Files)
            waitbar((iFile-1)/length(opts.Files), h, ['processing ' strrep(opts.GQM.data_list{iFile}, '_', ' ') '...'])
            response = single(AccSpk(opts.Files(iFile).SpikeTime,...
                opts.Files(iFile).StimTime,...
                numel(opts.Files(iFile).StimInfo.seq),...
                opts.Files(iFile).StimInfo.dt,...
                opts.LatencySTA(iFile)));
            Response = [Response; response(:)];
            nSpikes = nSpikes + sum(response);
            
            if isempty(Response)
                warning('There is no spike for the selected unit in data %s. Skipping this file!\n', dataSelectedList.String{iFile});
                continue
            end
            
            if adaptationCheckBox.Value
                temp_var = matfile(fullfile(opts.ImagePath_adaptation, opts.Files(iFile).StimInfo.stimFile));
                images = temp_var.WGN;
            else
                load(fullfile(opts.ImagePath, opts.Files(iFile).StimInfo.stimFile), 'images');
            end
            images = images - 0.5;
            %%%%%%%%%%%%%%%%%%%%%%%%%%
            %                         images = imresize(images, 1/2, 'box'); % downsampling the images, should be commented normally
            %%%%%%%%%%%%%%%%%%%%%%%%%

            images = images(x1:x2 , y1:y2, opts.Files(iFile).StimInfo.seq);
            images = imresize(images, image_resize_factor, 'box');
            images = reshape(images, [], size(images, 3));
            Xstim = [Xstim; double(images'*Basis)];
        end
        close(h)
        nLags = 1; % number of time lags for estimating stimulus filters
        up_samp_fac = 1; % temporal up-sampling factor applied to stimulus
        tent_basis_spacing = 3; % represent stimulus filters using tent-bases with this spacing (in up-sampled time units)
        
        
        silent = 0; % set to 1 if you want to suppress the optimization display
        mod_signs = [1 1 1 -1]; % both excitatory (although doesnt matter for linear)
        NL_types = {'lin', 'quad', 'quad', 'quad'};
%         lambda_d2x = 20;
        params_stim = NIMcreate_stim_params([nLags  BasisNum], opts.Files(iFile).StimInfo.dt(1), up_samp_fac );
        silent = 0; % set to 1 if you want to suppress the optimization display
        spk_NL_display = 0;
               
        % Initialize model and fit stimulus filters
        quad0 = NIMinitialize_modelGamma( params_stim, mod_signs, NL_types);
        Knorm = false;
        quad0 = NIMfit_filtersGamma( quad0, double(Response(:)), Xstim, [], 1:length(mod_signs), Knorm, silent, []);
        
        % Fit spiking NL params
        % Note that in this case re-estimating the spiking NL shape doesnt improve things
        % although this is not always the case.
        spk_NL_display = 0; % turn on display to get a before-and-after picture of the spk NL
        quad0 = NIMfit_logexp_spkNLGamma( quad0, double(Response(:)), Xstim, [], spk_NL_display );
        quad0 = NIMfit_filtersGamma( quad0, double(Response(:)), Xstim, [], 1:length(mod_signs), Knorm, silent, []);
        
        opts.GQM.quad0 = quad0;
        X = [quad0.mods(2:end).filtK];
        C = X*diag(mod_signs(2:end))*X';
        [V,D] = eigs(C,length(quad0.mods)-1);
        d = diag(D);
        [d, idx] = sort(d, 'descend');
        V_ = V(:, idx);
        V_ = [quad0.mods(1).filtK V_];
        opts.GQM.eigVal = d;
        opts.GQM.eigVec = V_;
        opts.GQM.ROI = ROI;
        opts.GQM.FourierBasis.Basis = Basis;
        opts.GQM.FourierBasis.params = params;
        opts.GQM.Latency = opts.LatencySTA;
        
        % visualizing filters
        plotwidth = 29.7;plotheight = 21;leftmargin = 2.5;rightmargin = 2.5;bottommargin = 2;topmargin = 6.5;
        nbx = length(mod_signs);nby = 1;spacex = 1.5;spacey = 2.5;
        positions = subplot_pos(plotwidth,plotheight,leftmargin,rightmargin,bottommargin,topmargin,nbx,nby,spacex,spacey);
        positions = positions(:, nby:-1:1);
        hfig = figure('name', 'Recovered RFs',...
            'Units', 'Normalized', ...
            'OuterPosition', [0.1836    0.3556    0.5520    0.4181],...
            'PaperOrientation', 'portrait',...
            'Visible', 'on');
        TextLabel = {'Linear', '1^{st} Exc. Nonlinear', '2^{nd} Exc. Nonlinear', '1^{st} Supp. Nonlinear'};
        col = {'k', 'r', 'r', 'b'};
        for k = 1 : length(quad0.mods)
            ax = axes('Parent', hfig,...
                'Units', 'Normalized', ...
                'Position', positions{k});
            imagesc(reshape(Basis*V_(:,k), MM, NN), max(abs(Basis*V_(:,k)))*[-1 1])
            ax.XTickLabel = {};
            ax.YTickLabel = {};
            colormap(ax, scm(256)); axis(ax, 'image');
            title(TextLabel{k},'FontName', 'Arial',...
                'FontWeight', 'normal',...
                'FontSize', 14,...
                'Color', col{k});
            if k > 1
                ylabel(['\lambda = ', sprintf('%.3f', d(k-1))], ...
                    'FontWeight', 'normal',...
                    'FontSize', 12);
            end
        end
        ax = axes('Parent', hfig,...
            'Units', 'Normalized', ...
            'Position', [0.05 0.76 0.5 0.05],...
            'Visible', 'off');
        switch dataMenu.Value
            case BLACKROCK_NEV_FILE
                description = text('Position', [0.1 0.4],...
                    'String', sprintf('Channel %d / N(spikes) = %d , fs_0 = %0.03f cpd , N_f = %i',...
                    opts.SelectedChannel, nSpikes, params.fs0_cyc_deg, Nf), 'FontName', 'Arial');
            case SPIKE_TIMES_FILE
                description = text('Position', [0.1 0.4],...
                    'String', sprintf('cluster ID %s  \nN(spikes) = %d , fs_0 = %0.03f cpd , N_f = %i',...
                    opts.SelectedCluster, nSpikes, params.fs0_cyc_deg, Nf), 'FontName', 'Arial');
            case KLUSTA_KWIK_FILE
                description = text('Position', [0.1 0.4],...
                    'String', sprintf('cluster ID %s  \nN(spikes) = %d , fs_0 = %0.03f cpd , N_f = %i',...
                    opts.SelectedCluster, nSpikes, params.fs0_cyc_deg, Nf), 'FontName', 'Arial');
            case CELL_INFO_FILE
                description = text('Position', [0.1 0.4],...
                    'String', sprintf('Cell ID %s \nN(spikes) = %d , fs_0 = %0.03f cpd , N_f = %i',...
                    opts.SelectedCellID, nSpikes, params.fs0_cyc_deg, Nf), 'FontName', 'Arial');
        end
        description.FontSize = 16;
        description.Color = [0 0 0.8];
        drawnow
        
    end

    % the callback to pb7_1, save to disk the GQM results push button
    function GQMsaveToDisk_Callback(hObject, eventdata)
        BLACKROCK_NEV_FILE   = 1;
        SPIKE_TIMES_FILE     = 2;
        KLUSTA_KWIK_FILE     = 3;
        CELL_INFO_FILE       = 4;
        opts.GQM.stimSzDeg = opts.StimSzDeg;
        if isfield(opts, 'GQM_savePath')
            savePath = opts.GQM_savePath;
        else
            savePath = opts.InfoPath;
        end
        
        switch dataMenu.Value
            case BLACKROCK_NEV_FILE
                saveName = fullfile(savePath, sprintf('GQM-gui_Chan_%i.mat', opts.SelectedChannel) );
                results.Channel = opts.SelectedChannel;
            case SPIKE_TIMES_FILE
                saveName = fullfile(savePath, sprintf('GQM-gui_ClusterID_%i.mat', str2double(opts.SelectedCluster)) );
                results.ClusterID = opts.SelectedCluster;
            case KLUSTA_KWIK_FILE
                saveName = fullfile(savePath, sprintf('GQM-gui_ClusterID_%i.mat', str2double(opts.SelectedCluster)) );
                results.ClusterID = opts.SelectedCluster;
            case CELL_INFO_FILE
                saveName = fullfile(savePath, sprintf('GQM-gui_CellID_%i.mat', str2double(opts.SelectedCellID)));
                results.CellID = opts.SelectedCellID;
        end
        [filename, pathname] = uiputfile('*.mat', 'Save GQM analysis results as', saveName);
        if ~filename
            return
        else
            opts.GQM_savePath = pathname;
        end
        results = opts.GQM;
        save(fullfile(pathname, filename), '-struct', 'results', '-v7.3');
        fprintf('Result was saved to disk as %s.\n', filename)
        
    end

    % the callback to edit5_1, input delay for tuning curves, in
    % "Tuning" tab
    function tuningDelayEdit_Callback(hObject, eventdata)
        opts.TuningDelay = str2double(hObject.String)/1000;     % convert to sec
    end

    % callback to pmenu5_1, pop-up menu to select tuning curve type in
    % "Tuning" tab
    function tuningCurveTypeMenu_Callback(hObject, eventdata)
        opts.TuningTypeValue = hObject.Value;
    end

    % callback to pbutton5_1, push button to plot tuning curve in
    % "Tuning" tab
    function plotTuningCurve_Callback(hObject, eventdata)
        ORIENTATION   = 1;
        SPATIAL_FREQ  = 2;
        TEMPORAL_FREQ = 3;
        RF_SIZE       = 4;
        CONTRAST      = 5;
        SPATIAL_PHASE = 6;
        POSITION      = 7;
        
        tuningType = get(pmenu5_1, 'Value');
        tuningDelay = str2double(edit5_1.String)/1000;    % convert to sec
        
        Spk = {};
        Response = [];
        count = 1;
        for iFile = 1 : length(opts.Files)
            DT = str2double(opts.Files(iFile).StimInfo.stimSettings.vars.stimDuration);
            offset = str2double(opts.Files(iFile).StimInfo.stimSettings.vars.preStimDelay);
            postStimTime = str2double(opts.Files(iFile).StimInfo.stimSettings.vars.postStimDelay);
            sequence = opts.Files(iFile).StimInfo.seq;
            nTrials = opts.Files(iFile).StimInfo.stimSettings.numTrials;
            nStim = size(opts.Files(iFile).StimInfo.stimSettings.conds, 2);
            spikeTime = opts.Files(iFile).SpikeTime;
            stimTime = opts.Files(iFile).StimTime;
            response = AccSpk(spikeTime, stimTime, nStim*nTrials, [DT postStimTime], offset + tuningDelay);
            Response_ = zeros(nTrials, nStim);
            if ( min(sequence(1,:)) == 0 )
                sequence = sequence + 1;
            end
            
            for iTrial = 1 : nTrials
                for iStim = 1 : nStim
                    Response_( iTrial , sequence(iTrial, iStim) ) = response(count);
                    Spk{iTrial, sequence(iTrial, iStim)} = spikeTime( (spikeTime > stimTime(count)-0.05) & (spikeTime < stimTime(count)+offset+DT+postStimTime)) - stimTime(count);
                    count = count + 1;
                end
            end
            Response = [Response; Response_];
        end
        
        meanResponse = mean(Response)/DT;
        stdResponse = std(Response)/DT/sqrt(size(Response, 1));
        
        xVariables = extractfield(opts.Files(1).StimInfo.stimSettings.conds, 'description');
        if (tuningType ~= POSITION)
            for iVariable = 1 : length(xVariables)
                variables(iVariable, :) = str2double(regexp(cell2mat(xVariables(iVariable)), '[\d.]+', 'match'));
            end
            xValues = variables(:, 1);
            xValues(end) = [];
        end
        meanResponse(end) = [];
        stdResponse(end) = [];
        
        diameter = str2double(opts.Files(iFile).StimInfo.stimSettings.vars.diameter);
        
        switch tuningType
            case ORIENTATION
                fORI = figure('name', 'Orientation Tuning', 'Visible', 'off');
                plot(xValues, meanResponse, '--o', 'color', [.7 .7 .7], 'markersize', 10, 'MarkerFaceColor', [.7 .7 .7])
                hold on;
                errorbar(xValues, meanResponse, stdResponse)
                title('Orientation Tuning Curve')
                xlabel('Degree')
                ylabel('Spikes/sec')
                xlim([0.0, 360.0]);
                ylim([0, max(1,max(meanResponse)*1.5)])
                xtix = xValues;
                xlab = cell(size(xtix));
                ii = find(mod(xtix,90.0) == 0);
                xlab(ii) = arrayfun(@(x) sprintf('%i',x), xtix(ii), 'UniformOutput', 0);
                set(gca,'XTick',xtix);
                set(gca,'XTickLabel',xlab);
                fRasters = figure('name', 'Rasterogram', ...
                    'Visible', 'off',...
                    'Units', 'Normalized',...
                    'Position', [0.01 0.05 0.98 0.87]);
                for iStim = 1 : nStim-1
                    subplot(4, 4, iStim);
                    for iTrial = 1 : nTrials
                        xData = Spk{iTrial, iStim};
                        xData = reshape(xData, 1, []);
                        xData = repmat(xData, [2, 1]);
                        yData = repmat([iTrial; iTrial+1], [1, length(xData)]);
                        plot(xData, yData, 'b')
                        hold on;
                    end
                    plot(repmat([0 offset DT+offset], [2, 1]), repmat([1; nTrials+1], [1, 3]), '-.r')
                    set(gca, 'YLim', [1 nTrials+1])
                    set(gca, 'XLim', [-0.05 DT+offset+postStimTime])
                    %                                    set(gca, 'YTick', 1.5:4:nTrials+.5)
                    %                                    set(gca, 'YTickLabel', 1:4:nTrials)
                    set(gca, 'XTick', unique([0 offset DT+offset DT+offset+postStimTime]))
                    xlabel('Sec')
                    ylabel('Trial')
                    title(xVariables{iStim})
                end
                set(fRasters, 'Visible', 'on')
                set(fORI, 'Visible', 'on')
                
                
                
            case SPATIAL_FREQ
                fSPF = figure('name', 'Spatial Frequency Tuning', 'Visible', 'off');
                plot(log(xValues), meanResponse, '--o', 'color', [.7 .7 .7], 'markersize', 10, 'MarkerFaceColor', [.7 .7 .7])
                hold on;
                errorbar(log(xValues), meanResponse, stdResponse)
                title('Spatial Frequency Tuning Curve')
                xlabel('Spatial Frequency [cyc./deg.]')
                ylabel('Spikes/sec')
                xlim([log(xValues(1))*1.1, log(xValues(end))*1.2]);
                ylim([0 max(meanResponse)*1.5])
                xtix = log(xValues);
                xlab = cell(size(xtix));
                xlab = arrayfun(@(x) sprintf('%g',x), xValues, 'UniformOutput', 0);
                set(gca,'XTick',xtix);
                set(gca,'XTickLabel',xlab);
                fRasters = figure('name', 'Rasterogram', ...
                    'Visible', 'off',...
                    'Units', 'Normalized',...
                    'Position', [0.01 0.05 0.98 0.87]);
                for iStim = 1 : nStim-1
                    subplot(3, 4, iStim);
                    for iTrial = 1 : nTrials
                        xData = Spk{iTrial, iStim};
                        xData = repmat(xData, [2, 1]);
                        yData = repmat([iTrial; iTrial+1], [1, length(xData)]);
                        plot(xData, yData, 'b')
                        hold on;
                    end
                    plot(repmat([0 offset DT+offset], [2, 1]), repmat([1; nTrials+1], [1, 3]), '-.r')
                    set(gca, 'YLim', [1 nTrials+1])
                    set(gca, 'XLim', [-0.5 2])
                    set(gca, 'YTick', 1.5:4:nTrials+.5)
                    set(gca, 'YTickLabel', 1:4:nTrials)
                    set(gca, 'XTick', [0 offset DT+offset DT+offset+postStimTime])
                    xlabel('Sec')
                    ylabel('Trial')
                    title(xVariables{iStim})
                end
                set(fRasters, 'Visible', 'on')
                set(fSPF, 'Visible', 'on')
                
            case TEMPORAL_FREQ
                fTF = figure('name', 'Temporal Frequency Tuning', 'Visible', 'off');
                plot(log(xValues), meanResponse, '--o', 'color', [.7 .7 .7], 'markersize', 10, 'MarkerFaceColor', [.7 .7 .7])
                hold on;
                errorbar(log(xValues), meanResponse, stdResponse)
                title('Temporal Frequency Tuning Curve')
                xlabel('Temp. Freq. [Hz]')
                ylabel('Spikes/sec')
                xlim([log(xValues(1))*1.1, log(xValues(end))*1.2]);
                ylim([0 max(meanResponse)*1.5])
                xtix = log(xValues);
                xlab = arrayfun(@(x) sprintf('%g',x), xValues, 'UniformOutput', 0);
                set(gca,'XTick',xtix);
                set(gca,'XTickLabel',xlab);
                fRasters = figure('name', 'Rasterogram', ...
                    'Visible', 'off',...
                    'Units', 'Normalized',...
                    'Position', [0.01 0.05 0.98 0.87]);
                for iStim = 1 : nStim-1
                    subplot(3, 3, iStim);
                    for iTrial = 1 : nTrials
                        xData = Spk{iTrial, iStim};
                        xData = repmat(xData, [2, 1]);
                        yData = repmat([iTrial; iTrial+1], [1, length(xData)]);
                        plot(xData, yData, 'b')
                        hold on;
                    end
                    plot(repmat([0 offset DT+offset], [2, 1]), repmat([1; nTrials+1], [1, 3]), '-.r')
                    set(gca, 'YLim', [1 nTrials+1])
                    set(gca, 'XLim', [-0.5 2])
                    set(gca, 'YTick', 1.5:4:nTrials+.5)
                    set(gca, 'YTickLabel', 1:4:nTrials)
                    set(gca, 'XTick', [0 offset DT+offset DT+offset+postStimTime])
                    xlabel('Sec')
                    ylabel('Trial')
                    title(xVariables{iStim})
                end
                set(fRasters, 'Visible', 'on')
                set(fTF, 'Visible', 'on')
                
            case RF_SIZE
                fRFsize = figure('name', 'RF Size Tuning', 'Visible', 'off');
                plot(log(xValues), meanResponse, '--o', 'color', [.7 .7 .7], 'markersize', 10, 'MarkerFaceColor', [.7 .7 .7])
                hold on;
                errorbar(log(xValues), meanResponse, stdResponse)
                title('RF Size Tuning Curve')
                xlabel('Size [degree]')
                ylabel('Spikes/sec')
                xlim([log(xValues(1))*1.1, log(xValues(end))*1.2]);
                ylim([0 max(meanResponse)*1.5])
                xtix = log(xValues);
                xlab = arrayfun(@(x) sprintf('%g',x), xValues*diameter, 'UniformOutput', 0);
                set(gca,'XTick',xtix);
                set(gca,'XTickLabel',xlab);
                fRasters = figure('name', 'Rasterogram', ...
                    'Visible', 'off',...
                    'Units', 'Normalized',...
                    'Position', [0.01 0.05 0.98 0.87]);
                for iStim = 1 : nStim-1
                    subplot(3, 3, iStim);
                    for iTrial = 1 : nTrials
                        xData = Spk{iTrial, iStim};
                        xData = repmat(xData, [2, 1]);
                        yData = repmat([iTrial; iTrial+1], [1, length(xData)]);
                        plot(xData, yData, 'b')
                        hold on;
                    end
                    plot(repmat([0 offset DT+offset], [2, 1]), repmat([1; nTrials+1], [1, 3]), '-.r')
                    set(gca, 'YLim', [1 nTrials+1])
                    set(gca, 'XLim', [-0.5 2])
                    set(gca, 'YTick', 1.5:4:nTrials+.5)
                    set(gca, 'YTickLabel', 1:4:nTrials)
                    set(gca, 'XTick', [0 offset DT+offset DT+offset+postStimTime])
                    xlabel('Sec')
                    ylabel('Trial')
                    title(xVariables{iStim})
                end
                set(fRasters, 'Visible', 'on')
                set(fRFsize, 'Visible', 'on')
                
            case CONTRAST
                fContrast = figure('name', 'Contrast Tuning', 'Visible', 'off');
                plot(log(xValues), meanResponse, '--o', 'color', [.7 .7 .7], 'markersize', 10, 'MarkerFaceColor', [.7 .7 .7])
                hold on;
                errorbar(log(xValues), meanResponse, stdResponse)
                title('Contrast Tuning Curve')
                xlabel('% Contrast')
                ylabel('Spikes/sec')
                xlim([log(xValues(1))*1.1, log(xValues(end))*1.2]);
                ylim([0 max(meanResponse)*1.5])
                xtix = log(xValues);
                xlab = arrayfun(@(x) sprintf('%g',x), xValues, 'UniformOutput', 0);
                set(gca,'XTick',xtix);
                set(gca,'XTickLabel',xlab);
                fRasters = figure('name', 'Rasterogram', ...
                    'Visible', 'off',...
                    'Units', 'Normalized',...
                    'Position', [0.01 0.05 0.98 0.87]);
                for iStim = 1 : nStim-1
                    subplot(3, 4, iStim);
                    for iTrial = 1 : nTrials
                        xData = Spk{iTrial, iStim};
                        xData = repmat(xData, [2, 1]);
                        yData = repmat([iTrial; iTrial+1], [1, length(xData)]);
                        plot(xData, yData, 'b')
                        hold on;
                    end
                    plot(repmat([0 offset DT+offset], [2, 1]), repmat([1; nTrials+1], [1, 3]), '-.r')
                    set(gca, 'YLim', [1 nTrials+1])
                    set(gca, 'XLim', [-0.5 2])
                    set(gca, 'YTick', 1.5:4:nTrials+.5)
                    set(gca, 'YTickLabel', 1:4:nTrials)
                    set(gca, 'XTick', [0 offset DT+offset DT+offset+postStimTime])
                    xlabel('Sec')
                    ylabel('Trial')
                    title(xVariables{iStim})
                end
                set(fRasters, 'Visible', 'on')
                set(fContrast, 'Visible', 'on')
                
            case SPATIAL_PHASE
                fSPhase = figure('name', 'Spatial Phase Tuning', 'Visible', 'off');
                plot(log(xValues), meanResponse, '--o', 'color', [.7 .7 .7], 'markersize', 10, 'MarkerFaceColor', [.7 .7 .7])
                hold on;
                errorbar(log(xValues), meanResponse, stdResponse)
                title('Spatial Phase Tuning Curve')
                xlabel('Phase [degree]')
                ylabel('Spikes/sec')
                xlim([0.0, 360.0]);
                ylim([0 max(meanResponse)*1.5])
                xtix = log(xValues);
                xlab = cell(size(xtix));
                ii = find(mod(xtix,90.0) == 0);
                xlab(ii) = arrayfun(@(x) sprintf('%i',x), xtix(ii), 'UniformOutput', 0);
                set(gca,'XTick',xtix);
                set(gca,'XTickLabel',xlab);
                fRasters = figure('name', 'Rasterogram', ...
                    'Visible', 'off',...
                    'Units', 'Normalized',...
                    'Position', [0.01 0.05 0.98 0.87]);
                for iStim = 1 : nStim-1
                    subplot(2, 4, iStim);
                    for iTrial = 1 : nTrials
                        xData = Spk{iTrial, iStim};
                        xData = repmat(xData, [2, 1]);
                        yData = repmat([iTrial; iTrial+1], [1, length(xData)]);
                        plot(xData, yData, 'b')
                        hold on;
                    end
                    plot(repmat([0 offset DT+offset], [2, 1]), repmat([1; nTrials+1], [1, 3]), '-.r')
                    set(gca, 'YLim', [1 nTrials+1])
                    set(gca, 'XLim', [-0.5 2])
                    set(gca, 'YTick', 1.5:4:nTrials+.5)
                    set(gca, 'YTickLabel', 1:4:nTrials)
                    set(gca, 'XTick', [0 offset DT+offset DT+offset+postStimTime])
                    xlabel('Sec')
                    ylabel('Trial')
                    title(xVariables{iStim})
                end
                set(fRasters, 'Visible', 'on')
                set(fSPhase, 'Visible', 'on')
                
            case POSITION
                fPOS = figure('name', 'RF Position Tuning', 'Visible', 'off');
                plot(1:length(meanResponse), meanResponse, '--o', 'color', [.7 .7 .7], 'markersize', 10, 'MarkerFaceColor', [.7 .7 .7])
                hold on;
                errorbar(1:length(meanResponse), meanResponse, stdResponse)
                title('RF Position Tuning Curve')
                xlabel('Location')
                ylabel('Spikes/sec')
                ylim([0 max(meanResponse)*1.5])
                xtix = 1:length(meanResponse);
                set(gca,'XTick',xtix);
                set(gca,'XTickLabel',xVariables(1:end-1));
                fRasters = figure('name', 'Rasterogram', ...
                    'Visible', 'off',...
                    'Units', 'Normalized',...
                    'Position', [0.01 0.05 0.98 0.87]);
                for iStim = 1 : nStim-1
                    subplot(3, 3, iStim);
                    for iTrial = 1 : nTrials
                        xData = Spk{iTrial, iStim};
                        xData = repmat(xData, [2, 1]);
                        yData = repmat([iTrial; iTrial+1], [1, length(xData)]);
                        plot(xData, yData, 'b')
                        hold on;
                    end
                    plot(repmat([0 offset DT+offset], [2, 1]), repmat([1; nTrials+1], [1, 3]), '-.r')
                    set(gca, 'YLim', [1 nTrials+1])
                    set(gca, 'XLim', [-0.5 2])
                    set(gca, 'YTick', 1.5:4:nTrials+.5)
                    set(gca, 'YTickLabel', 1:4:nTrials)
                    set(gca, 'XTick', [0 offset DT+offset DT+offset+postStimTime])
                    xlabel('Sec')
                    ylabel('Trial')
                    title(xVariables{iStim})
                end
                set(fRasters, 'Visible', 'on')
                set(fPOS, 'Visible', 'on')
        end
    end


    function variableLatencyInput_Callback(hObject, eventdata)
        fig2 = figure('Visible', 'off', 'Units', 'Normalized',...
            'Position', [.6 .6 .15 .35]); clf;
        if isempty(opts.STA_VarLatency)
            dataT = {};
            dataT(:,1) = opts.SelectedData;
            dataT(:,2) = {30};
        else
            dataT = {};
            dataT(:,1) = opts.SelectedData;
            dataT(:,2) = opts.STA_VarLatency;
        end
        LatencyTable = uitable(fig2, 'Data', dataT, 'Units', 'Normalized', 'Position', [.15 .1 .7 .88],...
            'ColumnEditable', true);
        LatencyTable.ColumnName = {'DataFiles', 'Latency (msec)'};
        h = uicontrol(fig2, 'Units', 'Normalized', 'Position',[.35 .01 .3 .06],'String', 'Apply & Exit',...
            'Callback', 'uiresume(gcbf)');
        set(fig2, 'Visible', 'on', 'MenuBar', 'none', 'ToolBar', 'none', ...
            'Name', 'Variable Latency Setting');
        
        uiwait(gcf);
        opts.STA_VarLatency = LatencyTable.Data(:,2);
        close(fig2);
    end


    function plotAllStatsPushButton_Callback(hObject, eventdata)
        positions = opts.plotAllChannelsPositions;
        
        HISTOGRAM_PLOT       = 1;
        RASTEROGRAM_PLOT     = 2;
        SPIKE_COUNTS_PLOT    = 3;
        plotType = get(pmenu2_1, 'Value'); % get plot type from the top-up menu menu
        
        switch plotType
            case HISTOGRAM_PLOT
                hfig = figure('name', 'Post-Stimulus Time Histogram',...
                    'Units', 'Normalized',...
                    'Position', [0 0.04 1 0.88]);
                waitBarBox = waitbar(0, 'Please wait...', 'name', 'PSTH for All Channels');
                for iChannel = 1 : opts.NEV.nChannels
                    binSize = str2double(edit2_2.String)/1000; % get bin size in msec, converts to sec
                    delay = str2double(edit2_1.String)/1000;  % converts to sec
                    spikeHist = [];
                    count = 1;
                    for iFile = 1 : opts.nDataFiles
                        [nTrials, nStimulus] = size(opts.Files(iFile).StimInfo.seq);
                        if isfield(opts.Files(iFile).StimInfo, 'stimSettings')
                            DT(iFile) = str2double(opts.Files(iFile).StimInfo.stimSettings.vars.preStimDelay) + ...
                                str2double(opts.Files(iFile).StimInfo.stimSettings.vars.stimDuration) + ...
                                str2double(opts.Files(iFile).StimInfo.stimSettings.vars.postStimDelay);
                            %                               DT(iFile) = 0.5;
                        else
                            DT(iFile) = sum(opts.Files(iFile).StimInfo.dt(:));
                            %                               DT(iFile) = 0.5;
                        end
                        SpikesIdx = find(opts.Files(iFile).NEV.Data.Spikes.Electrode == iChannel );
                        spikeTime = double(opts.Files(iFile).NEV.Data.Spikes.TimeStamp(SpikesIdx)) / opts.NEV.Fs;
                        stimulusTime = opts.Files(iFile).StimTime;
                        edges = 0:binSize:DT(iFile);
                        centers = edges(1:end-1) + diff(edges)/2;
                        timeExtract = @(x) spikeTime(spikeTime - x > 0 & spikeTime - x <= DT(iFile)) - x;
                        %                         spikeHist = zeros(nTrials * nStimulus, length(centers));
                        for iTrials = 1 : nTrials
                            for iStim = 1 : nStimulus
                                spikeHist(count, :) = histcounts(timeExtract(stimulusTime((iTrials-1)*nStimulus + iStim) + delay), edges);
                                count = count + 1;
                            end
                        end
                    end
                    %if iChannel > 30,%Yan edited
                    %index = iChannel - 30; %Yan edited
                    %else%Yan edited
                    index = iChannel;
                    %end%Yan edited
                    %%Yan edited
                    %if iChannel == 31,
                    if iChannel == 17
                        hfig = figure('name', 'Post-Stimulus Time Histogram',...
                            'Units', 'Normalized',...
                            'Position', [0 0.04 1 0.88]);
                    end
                    if iChannel > 16
                        index = index-16;
                    end
                    %%
                    ax = axes('Parent', hfig,...
                        'Units', 'Normalized', ...
                        'Position', positions{index});
                    figure(hfig);
                    bar(centers, mean(spikeHist, 1)/binSize, 'hist', 'c');
                    xlim([0 DT(1)])
                    xlabel('time [sec]', 'fontsize', 12)
                    ylabel('Spike/sec', 'fontsize', 14)
                    title(['Channel', num2str(iChannel)])
                    if nTrials > 1
                        hold on;
                        errorbar(centers, mean(spikeHist, 1)/binSize, zeros(size(centers)), std(spikeHist, 1)/sqrt(nTrials*nStimulus)/binSize, '.r')
                    end
                    waitbar(iChannel/60)
                end
                close(waitBarBox)
        end
    end


    function plotAllTuningCurve_Callback(hObject, eventdata)
        ORIENTATION   = 1;
        SPATIAL_FREQ  = 2;
        TEMPORAL_FREQ = 3;
        RF_SIZE       = 4;
        CONTRAST      = 5;
        SPATIAL_PHASE = 6;
        POSITION      = 7;
        positions = opts.plotAllChannelsPositions;
        
        tuningType = get(pmenu5_1, 'Value');
        tuningDelay = str2double(edit5_1.String)/1000;    % convert to sec
        
        waitBarBox = waitbar(0, 'Please wait...', 'name', 'Tuning for All Channels');
        for iChannel = 1 : opts.NEV.nChannels
            Spk = {};
            Response = [];
            for iFile = 1 : length(opts.Files)
                DT = str2double(opts.Files(iFile).StimInfo.stimSettings.vars.stimDuration);
                offset = str2double(opts.Files(iFile).StimInfo.stimSettings.vars.preStimDelay);
                postStimTime = str2double(opts.Files(iFile).StimInfo.stimSettings.vars.postStimDelay);
                sequence = opts.Files(iFile).StimInfo.seq;
                nTrials = opts.Files(iFile).StimInfo.stimSettings.numTrials;
                nStim = size(opts.Files(iFile).StimInfo.stimSettings.conds, 2);
                SpikesIdx = find(opts.Files(iFile).NEV.Data.Spikes.Electrode == iChannel );
                spikeTime = double(opts.Files(iFile).NEV.Data.Spikes.TimeStamp(SpikesIdx)) / opts.NEV.Fs;
                stimTime = opts.Files(iFile).StimTime;
                response = AccSpk(spikeTime, stimTime, nStim*nTrials, [DT postStimTime], offset + tuningDelay);
                
                Response_ = zeros(nTrials, nStim);
                if ( min(sequence(1,:)) == 0 )
                    sequence = sequence + 1;
                end
                count = 1;
                for iTrial = 1 : nTrials
                    for iStim = 1 : nStim
                        Response_( iTrial , sequence(iTrial, iStim) ) = response(count);
                        Spk{iTrial, sequence(iTrial, iStim)} = spikeTime( (spikeTime > stimTime(count)-0.5) & (spikeTime < stimTime(count)+offset+DT+postStimTime)) - stimTime(count);
                        count = count + 1;
                    end
                end
                Response = [Response; Response_];
            end
            
            meanResponse = mean(Response)/DT;
            stdResponse = std(Response)/DT/sqrt(size(Response, 1));
            meanResponse(end) = [];
            stdResponse(end) = [];
            
            
            xVariables = extractfield(opts.Files(1).StimInfo.stimSettings.conds, 'description');
            if (tuningType ~= POSITION)
                for iVariable = 1 : length(xVariables)
                    variables(iVariable, :) = str2double(regexp(cell2mat(xVariables(iVariable)), '[\d.]+', 'match'));
                end
                xValues = variables(:, 1);
                xValues(end) = [];
            end
            
            
            diameter = str2double(opts.Files(iFile).StimInfo.stimSettings.vars.diameter);
            
            if iChannel > 16
                index = iChannel - 16;
            else
                index = iChannel;
            end
            
            switch tuningType
                case ORIENTATION
                    if mod(iChannel, 16)==1
                        fORI = figure('name', 'Orientation Tuning',...
                            'Units', 'Normalized',...
                            'OuterPosition', [0 0.04 1 0.96]);
                        %                                 fRasters = figure('name', 'Rasterogram', ...
                        %                                           'Units', 'Normalized',...
                        %                                           'Position', [0.01 0.05 0.98 0.87]);
                    end
                    figure(fORI);
                    ax1 = axes('Parent', fORI,...
                        'Units', 'Normalized', ...
                        'Position', positions{index});
                    
                    plot(ax1, xValues, meanResponse, '--o', 'color', [.7 .7 .7], 'markersize', 10, 'MarkerFaceColor', [.7 .7 .7])
                    
                    hold on;
                    errorbar(xValues, meanResponse, stdResponse)
                    title(['Channel', num2str(iChannel)])
                    xlabel('Degree')
                    ylabel('Spikes/sec')
                    xlim([0.0, 360.0]);
                    if max(meanResponse)
                        ylim([0, max(meanResponse)*1.5])
                    else
                        ylim([0, 30])
                    end
                    xtix = xValues;
                    xlab = cell(size(xtix));
                    ii = find(mod(xtix,90.0) == 0);
                    xlab(ii) = arrayfun(@(x) sprintf('%i',x), xtix(ii), 'UniformOutput', 0);
                    set(ax1,'XTick',xtix);
                    set(ax1,'XTickLabel',xlab);
                    %-----------------for Michael--------------------
                    % this piece is added to plot rasters for one
                    % condition only (0.0 deg)
                    %
                    %                             figure(fRasters);
                    %                           ax2 = axes('Parent', fRasters,...
                    %                               'Units', 'Normalized', ...
                    %                               'Position', positions{index});
                    %                           for iTrial = 1 : nTrials,
                    %                               xData = Spk{iTrial, 1};
                    %                               xData = repmat(xData, [2, 1]);
                    %                               yData = repmat([iTrial; iTrial+1], [1, length(xData)]);
                    %                               plot(ax2, xData, yData, 'b')
                    %                               hold on;
                    %                           end
                    %                           plot(ax2, repmat([0 offset DT+offset], [2, 1]), repmat([1; nTrials+1], [1, 3]), '-.r')
                    %                           set(ax2, 'YLim', [1 nTrials+1])
                    %                           set(ax2, 'XLim', [-0.5 2])
                    %                           set(ax2, 'YTick', 1.5:4:nTrials+.5)
                    %                           set(ax2, 'YTickLabel', 1:4:nTrials)
                    %                           set(ax2, 'XTick', [0 offset DT+offset DT+offset+postStimTime])
                    %                           xlabel('Sec')
                    %                           ylabel('Trial')
                    %                           title(['Channel', num2str(iChannel)])
                    
                    %--------------------------------------------------
                    
                    
                    
                case SPATIAL_FREQ
                    if mod(iChannel, 16)==1
                        fSF = figure('name', 'Spatial Frequency Tuning',...
                            'Units', 'Normalized',...
                            'Position', [0 0.04 1 0.88]);
                    end
                    ax = axes('Parent', fSF,...
                        'Units', 'Normalized', ...
                        'Position', positions{index});
                    plot(log(xValues), meanResponse, '--o', 'color', [.7 .7 .7], 'markersize', 10, 'MarkerFaceColor', [.7 .7 .7])
                    hold on;
                    errorbar(log(xValues), meanResponse, stdResponse)
                    title(['Channel', num2str(iChannel)])
                    xlabel('Spatial Frequency [cyc./deg.]')
                    ylabel('Spikes/sec')
                    xlim([log(xValues(1))*1.1, log(xValues(end))*1.2]);
                    %                           xlim([-5.5 0])
                    if max(meanResponse)
                        ylim([0, max(meanResponse)*1.5])
                    else
                        ylim([0, 30])
                    end
                    xtix = log(xValues);
                    xlab = cell(size(xtix));
                    xlab = arrayfun(@(x) sprintf('%g',x), xValues, 'UniformOutput', 0);
                    set(gca,'XTick',xtix);
                    set(gca,'XTickLabel',xlab);
                    
                    
                case TEMPORAL_FREQ
                    if mod(iChannel, 16)==1
                        fTF = figure('name', 'Temporal Frequency Tuning',...
                            'Units', 'Normalized',...
                            'Position', [0 0.04 1 0.88]);
                    end
                    ax = axes('Parent', fTF,...
                        'Units', 'Normalized', ...
                        'Position', positions{index});
                    plot(log(xValues), meanResponse, '--o', 'color', [.7 .7 .7], 'markersize', 10, 'MarkerFaceColor', [.7 .7 .7])
                    hold on;
                    errorbar(log(xValues), meanResponse, stdResponse)
                    title(['Channel', num2str(iChannel)])
                    xlabel('Temp. Freq. [Hz]')
                    ylabel('Spikes/sec')
                    xlim([log(xValues(1))*1.1, log(xValues(end))*1.2]);
                    if max(meanResponse)
                        ylim([0, max(meanResponse)*1.5])
                    else
                        ylim([0, 30])
                    end
                    xtix = log(xValues);
                    xlab = arrayfun(@(x) sprintf('%g',x), xValues, 'UniformOutput', 0);
                    set(gca,'XTick',xtix);
                    set(gca,'XTickLabel',xlab);
                    
                    
                case RF_SIZE
                    if mod(iChannel, 16)==1
                        fRFsize = figure('name', 'RF Size Tuning',...
                            'Units', 'Normalized',...
                            'Position', [0 0.04 1 0.88]);
                    end
                    ax = axes('Parent', fRFsize,...
                        'Units', 'Normalized', ...
                        'Position', positions{index});
                    plot(log(xValues), meanResponse, '--o', 'color', [.7 .7 .7], 'markersize', 10, 'MarkerFaceColor', [.7 .7 .7])
                    hold on;
                    errorbar(log(xValues), meanResponse, stdResponse)
                    title(['Channel', num2str(iChannel)])
                    xlabel('Size [degree]')
                    ylabel('Spikes/sec')
                    xlim([log(xValues(1))*1.1, log(xValues(end))*1.2]);
                    if max(meanResponse)
                        ylim([0, max(meanResponse)*1.5])
                    else
                        ylim([0, 30])
                    end
                    xtix = log(xValues);
                    xlab = arrayfun(@(x) sprintf('%g',x), xValues*diameter, 'UniformOutput', 0);
                    set(gca,'XTick',xtix);
                    set(gca,'XTickLabel',xlab);
                    
                    
                case CONTRAST
                    if mod(iChannel, 16)==1
                        fContrast = figure('name', 'Contrast Tuning',...
                            'Units', 'Normalized',...
                            'Position', [0 0.04 1 0.88]);
                    end
                    ax = axes('Parent', fContrast,...
                        'Units', 'Normalized', ...
                        'Position', positions{index});
                    plot(log(xValues), meanResponse, '--o', 'color', [.7 .7 .7], 'markersize', 10, 'MarkerFaceColor', [.7 .7 .7])
                    hold on;
                    errorbar(log(xValues), meanResponse, stdResponse)
                    title(['Channel', num2str(iChannel)])
                    xlabel('% Contrast')
                    ylabel('Spikes/sec')
                    xlim([log(xValues(1))*1.1, log(xValues(end))*1.2]);
                    if max(meanResponse)
                        ylim([0, max(meanResponse)*1.5])
                    else
                        ylim([0, 30])
                    end
                    xtix = log(xValues);
                    xlab = arrayfun(@(x) sprintf('%g',x), xValues, 'UniformOutput', 0);
                    set(gca,'XTick',xtix);
                    set(gca,'XTickLabel',xlab);
                    
                    
                case SPATIAL_PHASE
                    if mod(iChannel, 16)==1
                        fSPhase = figure('name', 'Spatial Phase Tuning',...
                            'Units', 'Normalized',...
                            'Position', [0 0.04 1 0.88]);
                    end
                    ax = axes('Parent', fSPhase,...
                        'Units', 'Normalized', ...
                        'Position', positions{index});
                    plot(log(xValues), meanResponse, '--o', 'color', [.7 .7 .7], 'markersize', 10, 'MarkerFaceColor', [.7 .7 .7])
                    hold on;
                    errorbar(log(xValues), meanResponse, stdResponse)
                    title(['Channel', num2str(iChannel)])
                    xlabel('Phase [degree]')
                    ylabel('Spikes/sec')
                    xlim([0.0, 360.0]);
                    if max(meanResponse)
                        ylim([0, max(meanResponse)*1.5])
                    else
                        ylim([0, 30])
                    end
                    xtix = log(xValues);
                    xlab = cell(size(xtix));
                    ii = find(mod(xtix,90.0) == 0);
                    xlab(ii) = arrayfun(@(x) sprintf('%i',x), xtix(ii), 'UniformOutput', 0);
                    set(gca,'XTick',xtix);
                    set(gca,'XTickLabel',xlab);
                    
                    
                case POSITION
                    if mod(iChannel, 16)==1
                        fPOS = figure('name', 'RF Position Tuning',...
                            'Units', 'Normalized',...
                            'Position', [0 0.04 1 0.88]);
                    end
                    ax = axes('Parent', fPOS,...
                        'Units', 'Normalized', ...
                        'Position', positions{index});
                    plot(1:length(meanResponse), meanResponse, '--o', 'color', [.7 .7 .7], 'markersize', 10, 'MarkerFaceColor', [.7 .7 .7])
                    hold on;
                    errorbar(1:length(meanResponse), meanResponse, stdResponse)
                    title(['Channel', num2str(iChannel)])
                    xlabel('Location')
                    ylabel('Spikes/sec')
                    if max(meanResponse)
                        ylim([0, max(meanResponse)*1.5])
                    else
                        ylim([0, 30])
                    end
                    xtix = 1:length(meanResponse);
                    set(gca,'XTick',xtix);
                    set(gca,'XTickLabel',xVariables(1:end-1));
                    set(gca, 'XTickLabelRotation', 45);
            end
            waitbar(iChannel/60)
            
        end
        close(waitBarBox)
    end


    function CRGplotHistogram_Callback(hObject, eventdata)
        iFile = 1;
        positions = opts.plotAllChannelsPositions;
        binSize = str2double(edit6_2.String)/1000; % get bin size in msec, converts to sec
        delay = str2double(edit6_1.String)/1000;  % converts to sec
        load(fullfile(opts.ImagePath, opts.Files(iFile).StimInfo.stimFile), 'mov'); % loading the images specification of the gratings
        spikeTime = opts.Files(iFile).SpikeTime; % spike times
        triggerTimes = opts.Files(iFile).StimTime; % trigger times
        
        % getting the gratings timings by grouping the frames
        index = 1 : mov.Frames_perStim : length(triggerTimes);
        stimTime = triggerTimes(index);
        
        % generating edges for PSTH
        edges = 0 : binSize : mov.StimDuration_s;
        centers = edges(1:end-1) + diff(edges)/2; % center of the bins
        
        % the function to extract the timing of the spikes with respect to each stumulus
        timeExtract = @(x) spikeTime(spikeTime - x > 0 & spikeTime - x <= mov.StimDuration_s) - x;
        
        spikeHist = zeros(mov.BasisNum, length(centers)); % the matrix of pooled spikes
        for iStim = 1 : mov.TotalStim % loop over gratings to get histograms
            spikeHist(mov.seq(iStim), :) = spikeHist(mov.seq(iStim), :) + histcounts(timeExtract(stimTime(iStim)+delay), edges);
        end
        gratingsHist = spikeHist/mov.Reps/binSize;
        maxRate = max(gratingsHist(:));
        
        
        % plotting the histograms for all the basis functions
        index = 1;
        waitBarBox = waitbar(0, 'Please wait...', 'name', 'PSTH for Gratings');
        for iBasis = 1 : mov.BasisNum
            if mod(iBasis, 16)==1
                fig = figure('name', 'Gratings PSTH',...
                    'Units', 'Normalized',...
                    'Position', [0 0.04 1 0.88]);
            end
            ax = axes('Parent', fig,...
                'Units', 'Normalized', ...
                'Position', positions{index});
            
            index = index + 1;
            if index > 16
                index = index - 16;
            end
            barGraph = bar(centers, gratingsHist(iBasis, :), 'hist');
            barGraph.EdgeColor = [.8 0 0];
            barGraph.FaceColor = 0.8*ones(1,3);
            xlim([0 mov.StimDuration_s])
            ylim([0 maxRate+2])
            xlabel('sec', 'fontsize', 12)
            if mod(iBasis, 6)==1
                ylabel('Spike/sec', 'fontsize', 14)
            end
            title(['basis #', num2str(iBasis)])
            waitbar(iBasis/mov.BasisNum)
        end
        close(waitBarBox)
    end


    function fit_plotCRG_Callback(hObject, eventdata)
        plotwidth = 29.7;
        plotheight = 21;
        leftmargin = 1;
        rightmargin = 0.5;
        bottommargin = 1;
        topmargin = 2.5;
        nbx = 6;
        nby = 4;
        spacex = 0.8;
        spacey = 1.5;
        positions = subplot_pos(plotwidth,plotheight,leftmargin,rightmargin,bottommargin,topmargin,nbx,nby,spacex,spacey);
        positions = positions(:, 4:-1:1);
        
        dataContent = get(dataSelectedList, 'String');
        channelContent = get(channelMenu, 'String');
        iFile = 1;
        %         positions = opts.plotAllChannelsPositions;
        binSize = str2double(edit6_2.String)/1000; % get bin size in msec, converts to sec
        delay = str2double(edit6_1.String)/1000;  % converts to sec
        ft0 = get(pmenu6_3, 'Value');
        K = get(pmenu6_1, 'Value'); % number of coefficients
        L = get(pmenu6_2, 'Value'); % order of polynomial function for inverse gain function
        load(fullfile(opts.ImagePath, opts.Files(iFile).StimInfo.stimFile), 'mov'); % loading the images specification of the gratings
        spikeTime = opts.Files(iFile).SpikeTime; % spike times
        triggerTimes = opts.Files(iFile).StimTime; % trigger times
        
        % getting the gratings timings by grouping the frames
        index = 1 : mov.Frames_perStim : length(triggerTimes);
        stimTime = triggerTimes(index);
        
        % generating edges for PSTH
        edges = 0 : binSize : mov.StimDuration_s;
        centers = edges(1:end-1) + diff(edges)/2; % center of the bins
        
        % the function to extract the timing of the spikes with respect to each stumulus
        timeExtract = @(x) spikeTime(spikeTime - x > 0 & spikeTime - x <= mov.StimDuration_s) - x;
        
        spikeHist = zeros(mov.BasisNum, length(centers)); % the matrix of pooled spikes
        for iStim = 1 : mov.TotalStim % loop over gratings to get histograms
            spikeHist(mov.seq(iStim), :) = spikeHist(mov.seq(iStim), :) + histcounts(timeExtract(stimTime(iStim)+delay), edges);
        end
        gratingsHist = spikeHist/mov.Reps/binSize;
        maxRate = max(gratingsHist(:));
        
        % Fitting process
        [r, q, Rmax, ifit, d] = TrigPolyFitBlock(gratingsHist, centers, ft0, K, L);
        
        % Plotting the histogram for all the basis functions
        index = 1;
        vmax=0;
        vmin=0;
        Nonlinearity_fig = figure('Name', 'Estimated Static Nonlinearity'); clf;
        for iBasis = 1 : mov.BasisNum
            if mod(iBasis, 24)==1
                fig = figure('name', 'PSTH-Contrast Reversing Gratings',...
                    'Units', 'Normalized',...
                    'OuterPosition', [0 0 1 1]);
                
                ax = axes('Parent', fig,...
                    'Units', 'Normalized', ...
                    'Position', [0.05 0.93 0.5 0.05],...
                    'Visible', 'off');
                description = text('Position', [0.1 0.4], 'String', sprintf('Fitted Histograms, %s, %s', dataContent{1}, channelContent{channelMenu.Value}));
                description.FontSize = 24;
                %                 description.FontName = 'Californian FB';
                description.Color = [0 0 0.8];
            end
            figure(fig)
            ax = axes('Parent', fig,...
                'Units', 'Normalized', ...
                'Position', positions{index});
            
            index = index + 1;
            if index > 24
                index = index - 24;
            end
            Rdata = gratingsHist(iBasis, :);
            plot(centers, Rdata, 'bx-');
            %[R,v,R0,v0]=TrigPolyCalc(r(iBasis,:),q(iBasis,:),centers,mov.ft0_Hz);
            [R, v, R0, v0] = TrigPolyCalc( r(iBasis,:) , q(iBasis,:), centers, ft0 );
            vdata = invGain( Rdata/Rmax, q(iBasis,:) );
            vmax = max(vmax, max(vdata(:)) );
            vmin = min(vmin, min(v(:)) );
            hold on
            if ifit(iBasis)
                plot(centers,Rmax*R,'k');
            else
                plot(centers,Rmax*R,'r');
            end
            %barGraph.EdgeColor = [.8 0 0];
            %    barGraph.FaceColor = 0.8*ones(1,3);
            xlim([0 mov.StimDuration_s])
            %xlabel('sec', 'fontsize', 12)
            if mod(iBasis, 6)==1
                ylabel('Spike/sec', 'fontsize', 14)
            end
            title(['#', num2str(iBasis),', \theta = ' num2str(round(mov.Basis.theta(iBasis))), ', f_s = ', num2str(mov.Basis.fsp(iBasis),'%6.2f')])
            ylim([0 1.1*maxRate]);
            
            figure(Nonlinearity_fig)
            plot(v0, R0, 'b')
            hold on
            plot(v, R, 'bo')
            plot(v, Rdata/Rmax, 'kx')
            axis tight
        end
        
        %-----------------------------------------------
        % Plotting the generator potential
        index = 1;
        for iBasis = 1 : mov.BasisNum
            if mod(iBasis, 24)==1
                fig = figure('name', 'Generator Potential',...
                    'Units', 'Normalized',...
                    'OuterPosition', [0 0 1 1]);
                
                ax = axes('Parent', fig,...
                    'Units', 'Normalized', ...
                    'Position', [0.05 0.93 0.5 0.05],...
                    'Visible', 'off');
                description = text('Position', [0.1 0.4], 'String', sprintf('Generator Potentials, %s, %s', dataContent{1}, channelContent{channelMenu.Value}));
                description.FontSize = 24;
                %                 description.FontName = 'Californian FB';
                description.Color = [0 0 0.8];
            end
            figure(fig)
            ax = axes('Parent', fig,...
                'Units', 'Normalized', ...
                'Position', positions{index});
            
            index = index + 1;
            if index > 24
                index = index - 24;
            end
            % barGraph = bar(centers, gratingsHist(iBasis, :), 'hist');
            Rdata=gratingsHist(iBasis, :);
            vdata=invGain(Rdata/Rmax,q(iBasis,:));
            plot(centers, vdata, 'bx-');
            hold on
            ind=find(vdata==0);
            plot(centers(ind), vdata(ind), 'rx');
            %[R,v,R0,v0]=TrigPolyCalc(r(iBasis,:),q(iBasis,:),centers,mov.ft0_Hz);
            [R,v,R0,v0]=TrigPolyCalc(r(iBasis,:),q(iBasis,:),centers,ft0);
            %hold on
            
            if ifit(iBasis)
                plot(centers,v,'g');
            else
                plot(centers,v,'r');
            end
            
            dmax=invGain(d(iBasis),q(iBasis,:));
            plot(centers,dmax*ones(1,length(centers)),'c');
            plot(centers,-dmax*ones(1,length(centers)),'c');
            %barGraph.EdgeColor = [.8 0 0];
            %    barGraph.FaceColor = 0.8*ones(1,3);
            xlim([0 mov.StimDuration_s])
            %xlabel('sec', 'fontsize', 12)
            if mod(iBasis, 6)==1
                ylabel('gen pot', 'fontsize', 14)
            end
            title(['#', num2str(iBasis),' \theta=' num2str(round(mov.Basis.theta(iBasis))), ' fs=', num2str(mov.Basis.fsp(iBasis),'%6.2f')])
            ylim([vmin vmax]);
            %xlim([0 1.1]);
        end
        
        %-----------------------------------------------------------------
        %------- Fourier Space representation-----------------------------
        nofit=[];
        for iBasis = 1 : mov.BasisNum
            r_fr(mov.Basis.ifsy(iBasis) ,mov.Basis.ifsx(iBasis),:)=r(iBasis,:);
            if ~ifit(iBasis)
                nofit=[nofit,[mov.Basis.fsx(iBasis) +1i*mov.Basis.fsy(iBasis)]];
            end
        end
        
        
        rmax=max(abs(r(:)));
        mycmap = importdata('MyColormaps2.mat');
        
        figL=4;
        for ifr=1:(K+1)
            subpltN=mod(ifr-1,figL)+1;
            if subpltN==1
                figure('Units', 'Normalized',...
                    'OuterPosition', [0 0 1 1])
            end
            subplot(2,figL,subpltN)
            imagesc(mov.Basis.Fxy,mov.Basis.Fsx,real(r_fr(:,:,ifr)));
            colormap(mycmap)
            caxis([-rmax, rmax])
            hold on
            plot(0,0,'k.')
            
            axis square
            set(gca,'YDir','normal')
            %colorbar
            xlabel('fsx [cyc/deg]');
            ylabel('fsy [cyc/deg]');
            if subpltN==1
                title({[channelContent{channelMenu.Value}  ', fs0=' num2str(mov.fs0_cyc_deg) 'cyc/deg, ft0=' num2str(mov.ft0_Hz) 'Hz'],...
                    ['ft=' num2str((K+1-ifr)*ft0) 'Hz' ]});
            else
                title(['ft=' num2str((K+1-ifr)*ft0) 'Hz']);
            end
            plot(nofit,'k*')
            
            subplot(2,figL,figL+subpltN)
            imagesc(mov.Basis.Fxy,mov.Basis.Fsx,imag(r_fr(:,:,ifr)));
            colormap(mycmap)
            caxis([-rmax, rmax])
            hold on
            plot(0,0,'k.')
            axis square
            set(gca,'YDir','normal')
            %colorbar
            xlabel('fsx [cyc/deg]');
            ylabel('fsy [cyc/deg]');
            title(['ft=' num2str((K+1-ifr)*ft0) 'Hz']);
            %plot(nofit(1,:),nofit(2,:),'k*')
            plot(nofit,'k*')
        end
        
        %------------------------------------------------------------------
        
        ichnl=K+1-mov.ft0_Hz/ft0;
        
        alims=[mov.Basis.y(1) mov.Basis.x(end) mov.Basis.y(1) mov.Basis.y(end)]...
            /(round(mov.Basis.displ.H_deg*mov.fs0_cyc_deg));
        
        ialims=ceil(length(mov.Basis.y)/2*(1-1/(mov.Basis.displ.H_deg*mov.fs0_cyc_deg))):...
            floor(length(mov.Basis.y)/2*(1+1/(mov.Basis.displ.H_deg*mov.fs0_cyc_deg)));
        h1=reshape((r(:,ichnl)')*mov.Basis.dualbasis,length(mov.Basis.y),length(mov.Basis.x));
        h1max=max(abs(h1(:)));
        h1t=h1(ialims,ialims);
        [h1t, ih1t]=max(abs(h1t(:)));
        iyhtl=mod(ih1t,length(ialims));
        ixhtl=floor(ih1t/length(ialims));
        xmax=mov.Basis.x(ialims(ixhtl));
        ymax=mov.Basis.x(ialims(iyhtl));
        
        figure('Name', 'Reconstructed Linear Sub-unit')
        
        %ichnl=2;
        %subplot(1,2,1)
        
        
        % imagesc(mov.Basis.y,mov.Basis.x,abs(h1))
        % colormap(mycmap)
        % caxis([-h1max, h1max])
        % axis square
        
        %h1r=reshape(real(r(:,ichnl)')*mov.Basis.dualbasis,270,270);
        %h1max=max(abs(h1r(:)));
        subplot(1,2,1)
        imagesc(mov.Basis.y,mov.Basis.x,real(h1))
        colormap(mycmap)
        caxis([-h1max, h1max])
        axis square
        axis([xmax xmax ymax ymax]+alims)
        title({[channelContent{channelMenu.Value} ', fs0=' num2str(mov.fs0_cyc_deg) 'cyc/deg, ft0=' num2str(mov.ft0_Hz) 'Hz'],...
            'h1: cos phase'} )
        xlabel('x [deg]')
        ylabel('y [deg]')
        hold on
        plot(xmax,ymax,'k*')
        
        subplot(1,2,2)
        %h1i=reshape(imag(r(:,ichnl)')*mov.Basis.dualbasis,270,270);
        %h1max=max(abs(h1i(:)));
        imagesc(mov.Basis.y,mov.Basis.x,imag(h1))
        colormap(mycmap)
        caxis([-h1max, h1max])
        axis square
        axis([xmax xmax ymax ymax]+alims)
        title('h1: sin phase')
        hold on
        plot(xmax,ymax,'k*')
        
        
    end

%% -----------------------------Nested Functions-----------------------------
    % built-in function to pool spikes out of spike train
    function y = AccSpk(sp_timing, st_timing, st_nr, DT, delay)
        if length(find(DT)) == 1
            edges = st_timing + delay;
            [y, ~] = histcounts(sp_timing, edges);
        else
            Onset = st_timing(1:st_nr) + delay; % time the stimulus appears on the screen
            Offset = Onset + DT(1); % time the stimulus disappears
            
            % routine to detect any abnormality in the triggered due to
            % distortion or noise on the trigger line
            diff_aux = diff(st_timing(1:st_nr));
            idx = find(diff_aux < DT(1));
            if ~isempty(idx)
                Offset(idx) = Onset(idx) + diff_aux(idx) * 0.8;
            end
            
            edges = [Onset; Offset];
            edges = edges(:);
            
            [y_, ~] = histcounts(sp_timing, edges);
            y = y_(2 * (1:st_nr) - 1);
        end
    end


    function stimTimes = getStimTimes(NEV, stimInfo)
        % determining the type of recording system using NEV data
        % Blackrock recording system
        if contains(NEV.MetaTags.Application, 'File Dialog', 'IgnoreCase', true)
            % gets the events on the (digital) trigger line and outputs correct timing of the stimulus presentation
            TimesTriggerDigital = NEV.Data.SerialDigitalIO.TimeStampSec; % digital trigger events correspond to the rising edge of the trigger pulse which indicate the presentation onset.
            dTriggerTimes = diff(TimesTriggerDigital);
            if isfield(stimInfo, 'stimSettings')
                %         DT = str2double(stimInfo.stimSettings.vars.preStimDelay) + ...
                %             str2double(stimInfo.stimSettings.vars.stimDuration) + ...
                %             str2double(stimInfo.stimSettings.vars.postStimDelay);
                %
                %         corruptedTriggers = find(dTriggerTimes < 0.95*DT(1) | dTriggerTimes > 1.05*DT(1));
                %         if ismember(1, corruptedTriggers),
                %             TimesTriggerDigital(corruptedTriggers(1)) = [];
                %             dTriggerTimes = diff(TimesTriggerDigital);
                %             corruptedTriggers = find(dTriggerTimes < 0.95*DT(1) | dTriggerTimes > 1.05*DT(1));
                %         end
                %         while ~isempty(corruptedTriggers),
                %             TimesTriggerDigital(corruptedTriggers(1)+1) = [];
                %             dTriggerTimes = diff(TimesTriggerDigital);
                %             corruptedTriggers = find(dTriggerTimes < 0.95*DT(1));
                %         end
            else
                DT = sum(stimInfo.dt(:));
                corruptedTriggers = find(dTriggerTimes < 0.95*DT(1) | dTriggerTimes > 1.05*DT(1));
                if ismember(1, corruptedTriggers)
                    TimesTriggerDigital(corruptedTriggers(1)) = [];
                    dTriggerTimes = diff(TimesTriggerDigital);
                    corruptedTriggers = find(dTriggerTimes < 0.95*DT(1) | dTriggerTimes > 1.05*DT(1));
                end
                while ~isempty(corruptedTriggers)
                    TimesTriggerDigital(corruptedTriggers(1)+1) = [];
                    dTriggerTimes = diff(TimesTriggerDigital);
                    corruptedTriggers = find(dTriggerTimes < 0.95*DT(1) | dTriggerTimes > 1.05*DT(1));
                end
            end
            stimTimes = TimesTriggerDigital;
            
            % Ripple recording system
        elseif contains(NEV.MetaTags.Application, 'trellis', 'IgnoreCase', true)
            % gets the events on the (digital) trigger line and outputs correct timing of the stimulus presentation
            TimesTriggerDigital = NEV.Data.SerialDigitalIO.TimeStampSec; % digital trigger events correspond to any bit change on the trigger line. They indicate the rising (stim presentation) and falling edges of the trigger signal.
            % presenation times correspond to odd numbered events
            Onset = TimesTriggerDigital(1:2:end);
            Offset = TimesTriggerDigital(2:2:end);
            try
                pulse_width = Offset - Onset;
            catch
                error('Trigger signal was not set to low at the end of stimulus presentation!')
            end
            stimTimes = Onset;
            normal_pulse_width = mode(pulse_width); % width of a normal trigger pulse
            % detect any abnormal pulse based on its duration
            corruptedTriggers = find(pulse_width < 0.95*normal_pulse_width | pulse_width > 1.05*normal_pulse_width);
            stimTimes(corruptedTriggers) = [];
            
            % otherwise give an error
        else
            error('The recording system cannot be identified using from NEV file!')
        end
    end


    function varargout = shadedErrorBar(x,y,errBar,lineProps,transparent)
        % Error checking
        error(nargchk(3,5,nargin))
        %Process y using function handles if needed to make the error bar
        %dynamically
        if iscell(errBar)
            fun1=errBar{1};
            fun2=errBar{2};
            errBar=fun2(y);
            y=fun1(y);
        else
            y=y(:)';
        end
        
        if isempty(x)
            x=1:length(y);
        else
            x=x(:)';
        end
        
        
        %Make upper and lower error bars if only one was specified
        if length(errBar)==length(errBar(:))
            errBar=repmat(errBar(:)',2,1);
        else
            s=size(errBar);
            f=find(s==2);
            if isempty(f), error('errBar has the wrong size'), end
            if f==2, errBar=errBar'; end
        end
        
        if length(x) ~= length(errBar)
            error('length(x) must equal length(errBar)')
        end
        
        %Set default options
        defaultProps={'-k'};
        if nargin<4, lineProps=defaultProps; end
        if isempty(lineProps), lineProps=defaultProps; end
        if ~iscell(lineProps), lineProps={lineProps}; end
        
        if nargin<5, transparent=0; end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Plot to get the parameters of the line
        H.mainLine=plot(x,y,lineProps{:});
        
        
        % Work out the color of the shaded region and associated lines
        % Using alpha requires the render to be openGL and so you can't
        % save a vector image. On the other hand, you need alpha if you're
        % overlaying lines. There we have the option of choosing alpha or a
        % de-saturated solid colour for the patch surface .
        
        col=get(H.mainLine,'color');
        edgeColor=col+(1-col)*0.55;
        patchSaturation=0.15; %How de-saturated or transparent to make patch
        if transparent
            faceAlpha=patchSaturation;
            patchColor=col;
            set(gcf,'renderer','openGL')
        else
            faceAlpha=1;
            patchColor=col+(1-col)*(1-patchSaturation);
            set(gcf,'renderer','painters')
        end
        
        
        %Calculate the error bars
        uE=y+errBar(1,:);
        lE=y-errBar(2,:);
        
        
        %Add the patch error bar
        holdStatus=ishold;
        if ~holdStatus, hold on,  end
        
        
        %Make the patch
        yP=[lE,fliplr(uE)];
        xP=[x,fliplr(x)];
        
        %remove nans otherwise patch won't work
        xP(isnan(yP))=[];
        yP(isnan(yP))=[];
        
        
        H.patch=patch(xP,yP,1,'facecolor',patchColor,...
            'edgecolor','none',...
            'facealpha',faceAlpha);
        
        
        %Make pretty edges around the patch.
        H.edge(1)=plot(x,lE,'-','color',edgeColor);
        H.edge(2)=plot(x,uE,'-','color',edgeColor);
        
        %Now replace the line (this avoids having to bugger about with z coordinates)
        delete(H.mainLine)
        H.mainLine=plot(x,y,lineProps{:});
        
        
        if ~holdStatus, hold off, end
        
        
        if nargout==1
            varargout{1}=H;
        end
        
    end


end