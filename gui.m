function varargout = gui(varargin)
    % Begin initialization code - DO NOT EDIT
    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
                       'gui_Singleton',  gui_Singleton, ...
                       'gui_OpeningFcn', @gui_OpeningFcn, ...
                       'gui_OutputFcn',  @gui_OutputFcn, ...
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
    hMod = comm.OFDMModulator;
    handles.hModVar = hMod;
    handles.dcnullVar = 0;
    handles.pilotVar = 0;
    handles.cplengthVar = 16;
    set(handles.cplength, 'String', num2str(handles.cplengthVar));
    handles.fftlengthVar = 64;
    set(handles.fftlength, 'String', num2str(handles.fftlengthVar));
    handles.numsymbolsVar = 1;
    set(handles.numsymbols, 'String', num2str(handles.numsymbolsVar));
    handles.numguardbandVar = [6;5];
    set(handles.numguardband, 'String', arrayToString(handles.numguardbandVar));
    handles.numantennasVar = 1;
    set(handles.numantennas, 'String', num2str(handles.numantennasVar));
    handles.pilotcarrierVar = [12; 26; 40; 54];
    set(handles.pilotcarrier, 'String', arrayToString(handles.pilotcarrierVar));
    handles.windowlengthVar = 1;
    set(handles.windowlength, 'String', num2str(handles.windowlengthVar));
    handles.windowingVar = 0;
    guidata(hObject,handles)

function gui_OpeningFcn(hObject, eventdata, handles, varargin)
    handles.output = hObject;
    init(hObject, handles);
    
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
    varargout{1} = handles.output;

function dcnull_Callback(hObject, eventdata, handles)
    dcnull = get(handles.dcnull,'Value');
    handles.dcnullVar=dcnull;
    handles.hModVar.InsertDCNull = dcnull;
    guidata(hObject,handles)

function pilot_Callback(hObject, eventdata, handles)
    pilot = get(handles.pilot,'Value');
    handles.pilotVar=pilot;
    handles.hModVar.PilotInputPort = pilot;
    guidata(hObject,handles)

function cplength_Callback(hObject, eventdata, handles)
    cplength = str2double(get(handles.cplength,'String'));
    if ~isnan(cplength)
        handles.cplengthVar=cplength;
    end
    handles.hModVar.CyclicPrefixLength = cplength;
    guidata(hObject,handles)

function cplength_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

function fftlength_Callback(hObject, eventdata, handles)
    fftlength = str2double(get(handles.fftlength,'String'));
    if ~isnan(fftlength)
        handles.fftlengthVar=fftlength;
    end
    handles.hModVar.FFTLength = fftlength;
    guidata(hObject,handles)

function fftlength_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

function numsymbols_Callback(hObject, eventdata, handles)
    numsymbols = str2double(get(handles.numsymbols,'String'));
    if ~isnan(numsymbols)
        handles.numsymbolsVar = numsymbols;
    end
    handles.hModVar.NumSymbols = numsymbols;
    guidata(hObject,handles)

function numsymbols_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

function numguardband_Callback(hObject, eventdata, handles)
    numguardbandString = get(handles.numguardband, 'String');
    numguardbandColumn = [];
    if ~isnan(numguardbandString)
        numguardbandColumn = textToColumnParser(numguardbandString);
        handles.numguardbandVar=numguardbandColumn;
    end
    handles.hModVar.NumGuardBandCarriers = numguardbandColumn;
    guidata(hObject,handles)

function numguardband_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

function numantennas_Callback(hObject, eventdata, handles)
    numantennas = str2double(get(handles.numantennas,'String'));
    if ~isnan(numantennas)
        handles.numantennasVar=numantennas;
    end
    handles.hModVar.NumTransmitAntennas = numantennas;
    guidata(hObject,handles)

function numantennas_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

function windowing_Callback(hObject, eventdata, handles)
    windowing = get(handles.windowing,'Value');
    handles.windowingVar=windowing;
    handles.hModVar.Windowing = windowing;
    guidata(hObject,handles)

function pilotcarrier_Callback(hObject, eventdata, handles)
    pilotcarrierString = get(handles.pilotcarrier,'String');
    pilotcarrierColumn = [];
    if ~isnan(pilotcarrierString)
        pilotcarrierColumn = textToColumnParser(pilotcarrierString);
        handles.pilotcarrierVar=pilotcarrierColumn;
    end
    handles.hModVar.PilotCarrierIndices = pilotcarrierColumn;
    guidata(hObject,handles)

function pilotcarrier_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

function windowlength_Callback(hObject, eventdata, handles)
    windowlength = str2double(get(handles.windowlength,'String'));
    if ~isnan(windowlength)
        handles.windowlengthVar=windowlength;
    end
    handles.hModVar.WindowLength = windowlength;
    guidata(hObject,handles)

function windowlength_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

function ofdmpropbutton_Callback(hObject, eventdata, handles)
    hMod = handles.hModVar;
    disp(hMod)

function loadbutton_Callback(hObject, eventdata, handles)
    [filename, pathname] = uigetfile('*', 'Pick file with modulated data');
    if isequal(filename,0) || isequal(pathname,0)
        disp('No data loaded');
    else
        filename=strcat(pathname,filename);
        dataIn = readmatrix(filename);
        dataIn(end,:) = [];
        handles.dataIn=dataIn;
        guidata(hObject,handles)
        msgbox('Data loaded from txt file');
    end

function createofdmmodbutton_Callback(hObject, eventdata, handles)
    if isnan(handles.numsymbolsVar) || isnan(handles.cplengthVar) || isnan(handles.fftlengthVar)
        msgbox('Empty fileds will be set as default values');
    end
    
    hMod = handles.hModVar;
    showResourceMapping(hMod);

    dataIn=handles.dataIn;
    info(hMod)
    maxDataSize = info(hMod).DataInputSize(1);
    dataIn = dataIn(1:maxDataSize,:);
    if hMod.PilotInputPort == true
        maxPilotSizeX = info(hMod).PilotInputSize(1);
        maxPilotSizeY = info(hMod).PilotInputSize(2);
        pilotIn = complex(rand(maxPilotSizeX));
        pilotIn = pilotIn(1:maxPilotSizeX,1:maxPilotSizeY);
        writematrix(pilotIn,'pilotIn.txt');
        dataOut = hMod(dataIn, pilotIn);
    else
        dataOut = hMod(dataIn);
    end
    
    handles.dataOut=dataOut;
    guidata(hObject,handles);
    msgbox('Data modulated successfully! You can write result to file');

function writebutton_Callback(hObject, eventdata, handles)
   if ~isfield(handles, 'dataOut')
       msgbox('Please load data and create OFDM mod');
       return;
   end
   dataOut = handles.dataOut;
   writematrix(dataOut,'dataOut.txt');
   msgbox('Data written to file dataOut.txt');

function infobutton_Callback(hObject, eventdata, handles)
    msgbox(['To modulate the signal please load signal symbols from file.' ...
        newline 'Then you can see resource grid and process the signal.' ...
        newline 'Write signal to txt file to pass it to the channel.' ...
        newline 'All fields have default values. After editing please do not leave any field empty.']);
