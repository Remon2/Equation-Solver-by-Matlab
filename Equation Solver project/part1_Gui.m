function varargout = part1_Gui(varargin)
% PART1_GUI MATLAB code for part1_Gui.fig
%      PART1_GUI, by itself, creates a new PART1_GUI or raises the existing
%      singleton*.
%
%      H = PART1_GUI returns the handle to a new PART1_GUI or the handle to
%      the existing singleton*.
%
%      PART1_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PART1_GUI.M with the given input arguments.
%
%      PART1_GUI('Property','Value',...) creates a new PART1_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before part1_Gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to part1_Gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help part1_Gui

% Last Modified by GUIDE v2.5 24-Jun-2014 16:38:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
%global method;


gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @part1_Gui_OpeningFcn, ...
                   'gui_OutputFcn',  @part1_Gui_OutputFcn, ...
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


% --- Executes just before part1_Gui is made visible.
function part1_Gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to part1_Gui (see VARARGIN)

% Choose default command line output for part1_Gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes part1_Gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = part1_Gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function equationText_Callback(hObject, eventdata, handles)
% hObject    handle to equationText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of equationText as text
%        str2double(get(hObject,'String')) returns contents of equationText as a double


% --- Executes during object creation, after setting all properties.
function equationText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to equationText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in solveButton.
function solveButton_Callback(hObject, eventdata, handles)
% hObject    handle to solveButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global method;
equation=get(handles.equationText,'String');
input=replaceByValue(equation,'1');
value=evaluateByValue(input);
if strcmp(value,'Empty Function!!!')==1;
     errordlg('Please Enter The Equation!','Error');
     return;
elseif strcmp(value,'Error')==1
     errordlg('Invalid Input Equation!','Error');
     return;
end
low=get(handles.lower,'String');
low = str2double(low);
upp=get(handles.upper,'String');
upp = str2double(upp);
eps=get(handles.epsilon,'String');
eps = str2double(eps);

if isDouble(get(handles.lower,'String'))==0
    errordlg('Lower must be a number','Error');
    return;
end
if isDouble(get(handles.upper,'String'))==0
    errordlg('Upper must be a number','Error');
    return;
end
%if  str2double(get(handles.lower,'String'))>str2double(get(handles.upper,'String'))
%    errordlg('Lower must be less than Upper','Error');
%    return;
%end
if isDouble(get(handles.epsilon,'String'))==0
    errordlg('Epsilon must be a number','Error');
    return;
end

iterationsNumber=get(handles.iter,'String');
if isPositiveInteger(iterationsNumber)==0
     errordlg('Number of iterations must be positive integer!','Error');
    return;
end
iterations=str2num(iterationsNumber);
if strcmp(method,'Bisection')==1
    set(handles.testtext, 'String', 'bisection');
    [array,xr,t,error,pres] = Bisection(equation,iterations,low,upp,eps);
    set(handles.t_Error,'String',error);
    set(handles.Th_error,'String','Theoretical Error');
    set(handles.text8,'String',t);
    set(handles.proo,'String',pres);
     set(handles.text13,'String','Lower');
    set(handles.text16,'String','Upper');
    set(handles.solution,'String',xr);
     for i=1:length(array)
        handles.names(i)=array(i);
    end
    set(handles.listbox1,'String',handles.names);
elseif strcmp(method,'Falseposition')==1
    set(handles.testtext, 'String', 'falseposition');
    %assuming x0=low temporarily
    [array,root,t,pres]= FalseMethod(equation,iterations , eps,low,upp);
    set(handles.text8,'String',t);
    set(handles.solution,'String',root);
    set(handles.proo,'String',pres);
        set(handles.t_Error,'String','');
    set(handles.Th_error,'String','');
    set(handles.text13,'String','Lower');
    set(handles.text16,'String','Upper');
     for i=1:length(array)
        handles.names(i)=array(i);
    end
    set(handles.listbox1,'String',handles.names);
elseif strcmp(method,'Fixedpoint')==1
    set(handles.testtext, 'String', 'fixedpoint');
    [array,xr,t,pres] = Fixed_Point(equation,iterations,eps,low);
    set(handles.text8,'String',t);
    set(handles.solution,'String',xr);
    set(handles.proo,'String',pres);
           set(handles.t_Error,'String','');
    set(handles.Th_error,'String','');
    set(handles.text13,'String','Xo');
    set(handles.text16,'String','');
    for i=1:length(array)
        handles.names(i)=array(i);
    end
    set(handles.listbox1,'String',handles.names);
elseif strcmp(method,'NewtonRaphson')==1
    set(handles.testtext, 'String', 'newtonRaphson');
    %assuming x0=low temporarily
    [array,root,t,pres]=Newton_Raphson(equation,iterations, low, eps);
    set(handles.text8,'String',t);
    set(handles.solution,'String',root);
    set(handles.proo,'String',pres);
           set(handles.t_Error,'String','');
    set(handles.Th_error,'String','');
    set(handles.text13,'String','Xo');
    set(handles.text16,'String','');
    for i=1:length(array)
        handles.names(i)=array(i);
    end
    set(handles.listbox1,'String',handles.names);
elseif strcmp(method,'Secant')==1
    set(handles.testtext, 'String', 'Secant');
    %assuming x0=low temporarily
    [array,root,t,pres]=Secant(equation,iterations, eps,low,upp);
    set(handles.text8,'String',t);
    set(handles.solution,'String',root);
    set(handles.proo,'String',pres);
           set(handles.t_Error,'String','');
    set(handles.Th_error,'String','');
    set(handles.text13,'String','Lower');
    set(handles.text16,'String','Upper');
    for i=1:length(array)
        handles.names(i)=array(i);
    end
    set(handles.listbox1,'String',handles.names);
elseif strcmp(method,'NewtonRaphsonM1')==1
    set(handles.testtext, 'String', 'NewtonRaphsonM1');
    [array,root,t,pres]=Newton_Raphson_Modified1(equation,iterations,low,upp,eps);
    set(handles.text8,'String',t);
    set(handles.solution,'String',root);
    set(handles.proo,'String',pres);
           set(handles.t_Error,'String','');
    set(handles.Th_error,'String','');
    set(handles.text13,'String','Xo');
    set(handles.text16,'String','M');
    for i=1:length(array)
        handles.names(i)=array(i);
    end
    set(handles.listbox1,'String',handles.names);
elseif strcmp(method,'NewtonRaphsonM2')==1
    set(handles.testtext, 'String', 'NewtonRaphsonM2');
     [array,root,t,pres]=Newton_Raphson_Modified2(equation,iterations,low,eps);
    set(handles.text8,'String',t);
    set(handles.solution,'String',root);
    set(handles.proo,'String',pres);
           set(handles.t_Error,'String','');
    set(handles.Th_error,'String','');
    set(handles.text13,'String','Xo');
    set(handles.text16,'String','');
     for i=1:length(array)
        handles.names(i)=array(i);
    end
    set(handles.listbox1,'String',handles.names);
end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on popupmenu1 and none of its controls.
function popupmenu1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function epsilon_Callback(hObject, eventdata, handles)
% hObject    handle to epsilon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of epsilon as text
%        str2double(get(hObject,'String')) returns contents of epsilon as a double


% --- Executes during object creation, after setting all properties.
function epsilon_CreateFcn(hObject, eventdata, handles)
% hObject    handle to epsilon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uigetfile({'*.txt'},'Choose a file');
if ne(pathname,0)
    if ne(filename,0)
        full_PathName=strcat(pathname,filename);
        data=fileread(full_PathName);
        set(handles.equationText,'String',data);
    end
end


% --- Executes when selected object is changed in uipanel2.
function uipanel2_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel2 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
global method;
switch get(eventdata.NewValue,'Tag') % Get Tag of selected object.
    case 'Bisection'
        set(handles.testtext, 'String', 'Bisection');
        set(handles.text13, 'String', 'Lower');
        set(handles.text16, 'String', 'Upper');
        method='Bisection';
    case 'Falseposition'
        set(handles.testtext, 'String', 'Falseposition');
        set(handles.text13, 'String', 'Lower');
        set(handles.text16, 'String', 'Upper');
        method='Falseposition';
     case 'Fixedpoint'
        set(handles.testtext, 'String', 'Fixedpoint');
        set(handles.text13, 'String', 'X0');
        set(handles.text16, 'String', '');
        method='Fixedpoint';
     case 'NewtonRaphson'
        set(handles.testtext, 'String', 'NewtonRaphson');
        set(handles.text13, 'String', 'X0');
        set(handles.text16, 'String', '');
        method='NewtonRaphson';
    case 'Secant'
        set(handles.testtext, 'String', 'Secant');
        set(handles.text13, 'String', 'Lower');
        set(handles.text16, 'String', 'Upper');
        method='Secant';
    case 'NewtonRaphsonM1'
         set(handles.testtext, 'String', 'NewtonRaphsonM1');
         set(handles.text13, 'String', 'X0');
        set(handles.text16, 'String', 'M');
        method='NewtonRaphsonM1';
    case 'NewtonRaphsonM2'
        set(handles.testtext, 'String', 'NewtonRaphsonM2');
        set(handles.text13, 'String', 'X0');
        set(handles.text16, 'String', '');
        method='NewtonRaphsonM2';
end



function lower_Callback(hObject, eventdata, handles)
% hObject    handle to lower (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lower as text
%        str2double(get(hObject,'String')) returns contents of lower as a double


% --- Executes during object creation, after setting all properties.
function lower_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lower (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function upper_Callback(hObject, eventdata, handles)
% hObject    handle to upper (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of upper as text
%        str2double(get(hObject,'String')) returns contents of upper as a double


% --- Executes during object creation, after setting all properties.
function upper_CreateFcn(hObject, eventdata, handles)
% hObject    handle to upper (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function iteration_Callback(hObject, eventdata, handles)
% hObject    handle to iteration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of iteration as text
%        str2double(get(hObject,'String')) returns contents of iteration as a double


% --- Executes during object creation, after setting all properties.
function iteration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to iteration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function iter_Callback(hObject, eventdata, handles)
% hObject    handle to iter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of iter as text
%        str2double(get(hObject,'String')) returns contents of iter as a double


% --- Executes during object creation, after setting all properties.
function iter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to iter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
result();



% --- Executes during object creation, after setting all properties.
function proo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to proo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object deletion, before destroying properties.
function proo_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to proo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
