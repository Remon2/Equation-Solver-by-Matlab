function varargout = part_two(varargin)
%PART_TWO M-file for part_two.fig
%      PART_TWO, by itself, creates a new PART_TWO or raises the existing
%      singleton*.
%
%      H = PART_TWO returns the handle to a new PART_TWO or the handle to
%      the existing singleton*.
%
%      PART_TWO('Property','Value',...) creates a new PART_TWO using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to part_two_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      PART_TWO('CALLBACK') and PART_TWO('CALLBACK',hObject,...) call the
%      local function named CALLBACK in PART_TWO.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help part_two

% Last Modified by GUIDE v2.5 24-Jun-2014 05:24:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @part_two_OpeningFcn, ...
                   'gui_OutputFcn',  @part_two_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before part_two is made visible.
function part_two_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for part_two
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes part_two wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = part_two_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



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


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global num_equation
global ito
global AU
global AI
global BI
set(handles.pushbutton3 , 'Enable','on');
set(handles.text10 , 'String','');
x = get(handles.edit2, 'String');
if ~isempty(x)

coo = parsing(x,',');
if numel(coo) < num_equation
    set(handles.text10 , 'String','less #coefficient, please enter it again');
    set(handles.edit2,'String','');
    set(handles.edit3,'String','');
    return;
end
%tf = ischar(coo(1));
%disp(num_equation);
%disp(coo(1));
if ito < num_equation
    for i = 1:num_equation+1
       if i <= num_equation
        %disp(num_equation);
        cr = coo{i};
        h = Validate(cr);
         if h ~= 1
          %error in coefficent
          set(handles.text10 , 'String','Error in coefficient, please enter it again');
          return;
         else
          d = str2double(cr);
          AU(ito+1,i) = d;
          AI(ito+1,i) = d;
         end 
      end
    %sure that coefficient is valid
    if i == num_equation+1 
        x1 = get(handles.edit3, 'String');
        if isempty(x1)
            x1 = '0';
        end
        h1 = Validate(x1);
        if h1 == 0
            set(handles.text10 , 'String','Error in result of equation, please enter it again');
        else 
          AU(ito+1,i)= str2double(x1);
          BI(ito+1,1)= str2double(x1);
              ito = ito +1;
        end
    end
    end
  
set(handles.edit2 , 'String','');
set(handles.edit3 , 'String','');
else
    set(handles.text10 , 'String','Skip the number of equations'); 
end
end

disp(AU);


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global f

global AU
global AI
global BI
global num_equation

global AU_f
global AI_f
global BI_f
global num_equation_f
if f == 1
  au = AU_f;
  ai = AI_f;
  bi = BI_f;
  no = num_equation_f;
else
  au = AU;
  ai = AI;
  bi = BI;
  no = num_equation;
end    

   contents = get(handles.popupmenu1,'String'); 
choice = contents{get(handles.popupmenu1,'Value')};
%choice = get(handles.popupmenu1, 'Value');
  set(handles.text12,'String','');
        if no == 1
             x = au(1,1);
            % xd = str2double(x);
             y = au(1,2);
             %yd = str2double(y);
             resd = y / x;
            
            set(handles.listbox1,'String',resd);
            return;
        else
            
            tic
            if  strcmp(choice,'Gaussian_Elimination') == 1
               X=  GaussElimination(au);
               disp('e');
            elseif strcmp(choice,'Gaussian_Jordan') == 1
               X=  GaussJordan(au);
                 disp('j');
            elseif strcmp(choice,'LU_Decomposition') == 1
               X = LUDecomposition(au);
                 disp('l');
            elseif strcmp(choice,'Gaussian_Elimination (Partial Pivoting)') == 1
               X = PartialPivoting(au);
                 disp('Gpp');
            elseif strcmp(choice,'Gaussian_Jordan(Pivoting)') == 1
               X = Jordan_pivoting(au);
                 disp('JP');
            elseif strcmp(choice,'LU_Decomposition(Partial Pivoting)') == 1
               X = LUPartialPivoting(au);
                 disp('LUP');
            else
               X = LUPartialPivoting(au);
                 disp('LUpp');
            end
            %for l=1:num_equation
               %set(handles.listbox1 , 'String',X(l));  
             nam = cell(1,length(X));
             u=1;
           for i=1:length(X)
               if strcmp(X,'This system has no solutions!!')== 1
                   nam{1} =  X;
               else
                 ui = num2str(u)
                % uu = ;
                 nam{i}= horzcat('x', ui , ' = ', num2str(X(i)));
                 u = u+1;
               end
           end
        
           for t=1:length(nam)
             handles.names(t)= nam(t);
           end
           
            set(handles.listbox1,'String',handles.names);
           t= toc;
            set(handles.text12,'String',t);
        end
        set(handles.pushbutton5 , 'Enable','on');
        set(handles.pushbutton1 , 'Enable','on');
        set(handles.pushbutton2 , 'Enable','on');
        set(handles.pushbutton4 , 'Enable','on');


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(~, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global num_equation
global ito
global AU
global AI
global BI
global f 
set(handles.pushbutton2 , 'Enable','on');
set(handles.edit2 , 'String','');
set(handles.edit3 , 'String','');
set(handles.text10 , 'String','');
set(handles.text12 , 'String','');
set(handles.pushbutton4 ,'Enable','off');
set(handles.pushbutton5 ,'Enable','off');
set(handles.text12,'String','');

num = get(handles.edit1, 'String');
o = Validate(num);
if o ~= 1
    set(handles.text10 , 'String','Error in number of equation, please enter it again');
    return;
else
    num_equation = str2double(num);
end
f =0;
ito = 0;
AU = zeros(num_equation , num_equation+1);
AI = zeros(num_equation , num_equation);
BI = zeros(num_equation , 1);


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
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


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit2 , 'String','');
set(handles.edit3 , 'String','');
set(handles.text10 , 'String','');
set(handles.text12 , 'String','');
    set(handles.pushbutton1 , 'Enable','off');
    set(handles.pushbutton2 , 'Enable','off');
    

global num_equation_f
global co
global nqu
global ito_f
global AU_f
global AI_f
global BI_f
global f 
f =1;
set(handles.pushbutton5 , 'Enable','on');
set(handles.pushbutton3 , 'Enable','on');
[filename,pathname]=uigetfile({'*.txt'},'Choose a file');
if ne(pathname,0)
    if ne(filename,0)
        full_PathName = strcat(pathname,filename);
        all = fileread(full_PathName);% change
        co = parsing(all,'\n');
    end
end

set(handles.text12,'String','');
 cii = co{1};
% disp(cii);
o = Validate(cii);
%cii(1)
%cii(2)
k = str2num(cii);

if k < 1
   set(handles.text10 , 'String','Error in number of equation!!');
    return; 
end
if o ~= 1
    set(handles.text10 , 'String','Error in number of equation!!');
    return;
else
    set(handles.edit1,'String',cii);
    num_equation_f = str2double(cii);
   
    if length(co) - 1 < 2 * num_equation_f 
        set(handles.text10 , 'String','Not enough Equations!!');
        set(handles.pushbutton5 , 'Enable','off');
        set(handles.pushbutton3 , 'Enable','off');
        set(handles.pushbutton1 , 'Enable','on');
        return;
    end
end
nqu =0;
ito_f = 1;
AU_f = zeros(num_equation_f , num_equation_f+1);
AI_f = zeros(num_equation_f , num_equation_f);
BI_f = zeros(num_equation_f , 1);



% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global num_equation_f
global co
global nqu
global ito_f
global AU_f
global AI_f
global BI_f

if ito_f < length(co)
   ito_f = ito_f+1;
   cn = co{ito_f};
    set(handles.edit2 , 'String' , cn);
   ito_f = ito_f+1;
   cn = co{ito_f};
    set(handles.edit3 , 'String' , cn);
else
    set(handles.text10,'String','no more equations');
    set(handles.pushbutton5 , 'Enable','off');
end

%set(handles.text10 , 'String','');
x = get(handles.edit2, 'String');

if ~isempty(x)

coo = parsing(x,',');
if numel(coo) < num_equation_f
    set(handles.text10 , 'String','less #coefficient, please enter it again');
  %  set(handles.edit2,'String','');
  %  set(handles.edit3,'String','');
    return;
end
%tf = ischar(coo(1));
%disp(num_equation);
%disp(coo(1));
if nqu < num_equation_f
    for i = 1:num_equation_f+1
       if i <= num_equation_f
        disp(num_equation_f);
        cr = coo{i};
        h = Validate(cr);
         if h ~= 1
          %error in coefficent
          set(handles.text10 , 'String','Error in coefficient, please enter it again');
          return;
         else
          d = str2double(cr);
          AU_f(nqu+1,i) = d;
          AI_f(nqu+1,i) = d;
         end 
      end
    %sure that coefficient is valid
    if i == num_equation_f+1 
        x1 = get(handles.edit3, 'String');
        if isempty(x1)
            x1 = '0';
        end
        h1 = Validate(x1);
        if h1 == 0
            set(handles.text10 , 'String','Error in result of equation, please enter it again');
        else 
          AU_f(nqu+1,i)= str2double(x1);
          BI_f(nqu+1,1)= str2double(x1);
              nqu = nqu +1;
        end
    end
    end
  
%set(handles.edit2 , 'String','');
%set(handles.edit3 , 'String','');
 
end
end

disp(AU_f);
