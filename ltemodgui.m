function varargout = ltemodgui(varargin)
% Begin initialization code - DO NOT EDIT
    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
                       'gui_Singleton',  gui_Singleton, ...
                       'gui_OpeningFcn', @ltemodgui_OpeningFcn, ...
                       'gui_OutputFcn',  @ltemodgui_OutputFcn, ...
                       'gui_LayoutFcn',  [] , ...
                       'gui_Callback',   []);
    if nargin && ischar(varargin{1})
        gui_State.gui_Callback = str2func(varargin{1});
    end
    
    if nargout
        [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
    else
        gui_mainfcn(gui_State, varargin{:});
    end
% End initialization code - DO NOT EDIT

function init(hObject, handles)
    handles.modulationVar = 'QPSK';
    handles.multiplierVar = 2;
    handles.cyclicprefixnormalVar = true;
    enb.CyclicPrefix = 'Normal';
    enb.DuplexMode = 'FDD';
    set(handles.normalCyclicPrefix, 'Value', handles.cyclicprefixnormalVar);
    enb.NDLRB = 6;
    set(handles.ndlrb, 'String', num2str(enb.NDLRB));
    enb.CellRefP = 1;
    set(handles.cellrefp, 'String', num2str(enb.CellRefP));
    enb.NCellID = 0;
    set(handles.ncellid, 'String', num2str(enb.NCellID));
    enb.Windowing = 0;
    set(handles.windowing, 'String', num2str(enb.Windowing));
    handles.enb = enb;
    guidata(hObject,handles)

function num = parseModToNum(hObject, handles, mod)
    num = 0;
    if strcmp(mod,'QPSK')
        num = 1;
    elseif strcmp(mod,'16QAM')
        num = 2;
    elseif strcmp(mod,'64QAM')
        num = 3;
    elseif strcmp(mod,'256QAM')
        num = 4;
    end
    set(handles.modulation, 'Value', num);
    handles.modulationVar = mod;
    disp('Click')
    disp(handles.modulationVar)
    guidata(hObject,handles)

function writeWavePropToStruct(info)
    writestruct(info, "dataToChannel.xml")

function setModAndMultip(hObject, handles, modulation)
    if modulation == 1 %QPSK
        handles.multiplierVar = 2;
        handles.modulationVar = 'QPSK';
    elseif modulation == 2 %16QAM
        handles.multiplierVar = 4;
        handles.modulationVar = '16QAM';
    elseif modulation == 3 %64QAM
        handles.multiplierVar = 6;
        handles.modulationVar = '64QAM';
    elseif modulation == 4 %256QAM
        handles.multiplierVar = 8;
        handles.modulationVar = '256QAM';
    end
    guidata(hObject,handles);

function ltemodgui_OpeningFcn(hObject, eventdata, handles, varargin)
    handles.output = hObject;
    init(hObject, handles);

function varargout = ltemodgui_OutputFcn(hObject, eventdata, handles) 
    varargout{1} = handles.output;

function infobutton_Callback(hObject, eventdata, handles)
    msgbox(['To modulate the signal please load signal symbols from file.' ...
        newline 'Then you can see modulator properties and process the signal.' ...
        newline 'Write signal to txt file to pass it to the channel.' ...
        newline 'All fields have default values. After editing please do not leave any field empty.']);

function ndlrb_Callback(hObject, eventdata, handles)
    ndlrb = str2double(get(handles.ndlrb,'String'));
    if ~isnan(ndlrb)
        handles.enb.NDLRB = ndlrb;
    end
    guidata(hObject,handles)

function ndlrb_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

function cellrefp_Callback(hObject, eventdata, handles)
    cellrefp = str2double(get(handles.cellrefp,'String'));
    if ~isnan(cellrefp)
        handles.enb.CellRefP = cellrefp;
    end
    guidata(hObject,handles)

function cellrefp_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

function ncellid_Callback(hObject, eventdata, handles)
    ncellid = str2double(get(handles.ncellid,'String'));
    if ~isnan(ncellid)
        handles.enb.NCellID = ncellid;
    end
    guidata(hObject,handles)
    
function ncellid_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

function windowing_Callback(hObject, eventdata, handles)
    windowing = str2double(get(handles.windowing,'String'));
    if ~isnan(windowing)
        handles.enb.Windowing = windowing;
    end
    guidata(hObject,handles)

function windowing_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

function modulation_Callback(hObject, eventdata, handles)
    modulation = get(handles.modulation,'Value');
    setModAndMultip(hObject, handles, modulation);

function modulation_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

function normalCyclicPrefix_Callback(hObject, eventdata, handles)
    normalCyclicPrefix = get(handles.normalCyclicPrefix,'Value');
    handles.cyclicprefixnormalVar=normalCyclicPrefix;
    if handles.cyclicprefixnormalVar == true
        handles.enb.CyclicPrefix = 'Normal';
        disp('Normal')
    else
        handles.enb.CyclicPrefix = 'Extended';
        disp('Extended')
    end
    guidata(hObject,handles)

function loadbutton_Callback(hObject, eventdata, handles)
    [filename, pathname] = uigetfile('*', 'Pick file with modulated data');
    if isequal(filename,0) || isequal(pathname,0)
        disp('No data loaded');
    else
        filename=strcat(pathname,filename);
        [dataIn, modulationTxt] = readOfdmDataIn(filename);
        handles.dataIn=dataIn;
        setModAndMultip(hObject, handles, parseModToNum(hObject, handles, modulationTxt));
        guidata(hObject,handles)
        msgbox('Data loaded from txt file');
    end

function ofdmmodbutton_Callback(hObject, eventdata, handles)
    if isnan(handles.enb.NDLRB) || isnan(handles.enb.CellRefP)
        msgbox('Empty fileds will be set as default values');
    end
    enb = handles.enb;
    gridsize = lteDLResourceGridSize(enb);
    dataIn = handles.dataIn;
    modulation = handles.modulationVar;
    multiplier = handles.multiplierVar;
    symmod = lteSymbolModulate(randi([0,1],prod(gridsize)*multiplier,1), modulation);
    dataIn = dataIn(1:size(symmod),:);
    regrid = reshape(dataIn, gridsize);
    [dataOut, info] = lteOFDMModulate(enb,regrid);
    size(dataOut)

    handles.dataOut=dataOut;
    handles.info = info;
    guidata(hObject,handles);
    msgbox('Data modulated successfully! You can write result to file');

function writebutton_Callback(hObject, eventdata, handles)
   if ~isfield(handles, 'dataOut')
       msgbox('Please load data and create OFDM mod');
       return;
   end
   dataOut = handles.dataOut;
   info = handles.info;
   writematrix(dataOut,'dataOutOfdm.txt');
   writeWavePropToStruct(info)
   msgbox('Data written to file dataOutOfdm.txt');


function showbutton_Callback(hObject, eventdata, handles)
    modulationText = "Modulation is " + handles.modulationVar;
    NDLRBText = "Enb NDLRB is " + handles.enb.NDLRB;
    CellRefPText = "Enb CellRefP is " + handles.enb.CellRefP;
    NCellIDText = "Enb NCellID is " + handles.enb.NCellID;
    CyclicPrefixText = "Enb CyclicPrefix is " + handles.enb.CyclicPrefix;
    WindowingText = "Enb Windowing is " + handles.enb.Windowing;
    DuplexModeText = "Enb DuplexMode is " + handles.enb.DuplexMode;
        msgbox([modulationText ...
        newline NDLRBText ...
        newline CellRefPText ...
        newline NCellIDText ...
        newline CyclicPrefixText ...
        newline WindowingText ...
        newline DuplexModeText]);
