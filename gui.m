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

function gui_OpeningFcn(hObject, eventdata, handles, varargin)
    handles.output = hObject;
    
    guidata(hObject, handles);
    hMod = comm.OFDMModulator;
    handles.hModVar = hMod;
    handles.dcnullVar = 0;
    handles.pilotVar = 0;
    handles.cplengthVar = 16;
    handles.fftlengthVar = 64;
    handles.numsymbolsVar = 1;
    handles.numguardbandVar = [6;5];
    handles.numantennasVar = 1;
    handles.pilotcarrierVar = [12; 26; 40; 54];
    handles.windowlengthVar = 1;
    handles.windowingVar = 0;
    guidata(hObject,handles)

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
        disp('No data loaded')
    else
        filename=strcat(pathname,filename);
        dataIn = readmatrix(filename);
        handles.dataIn=dataIn;
        guidata(hObject,handles)
        msgbox('Data loaded');
    end

function createofdmmodbutton_Callback(hObject, eventdata, handles)
    if isnan(handles.numsymbolsVar) || isnan(handles.cplengthVar) || isnan(handles.fftlengthVar)
        msgbox('Empty fileds will be set as default values');
    end
    
    hMod = handles.hModVar;
    showResourceMapping(hMod);
%     dataIn=handles.dataIn;
%     disp(dataIn)
