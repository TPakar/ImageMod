function varargout = ImageMod(varargin)
% Copyright (C) 2020 Tomppa Pakarinen, pakarinentomppa@gmail.com


% This program is free software: you can redistribute it and/or modify it 
% under the terms of the GNU General Public License as published by the  
% Free Software Foundation, either version 3 of the License, or (at your 
% option) any later version.
%
% This program is distributed in the hope that it will be useful, but 
% WITHOUT ANY WARRANTY; without even the implied warranty of 
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General 
% Public License for more details.
% 
% You should have received a copy of the GNU General Public License along 
% with this program. If not, see http://www.gnu.org/licenses/


%%
% IMAGEMOD MATLAB code for ImageMod.fig
%      IMAGEMOD, by itself, creates a new IMAGEMOD or raises the existing
%      singleton*.
%
%      H = IMAGEMOD returns the handle to a new IMAGEMOD or the handle to
%      the existing singleton*.
%
%      IMAGEMOD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMAGEMOD.M with the given input arguments.
%
%      IMAGEMOD('Property','Value',...) creates a new IMAGEMOD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ImageMod_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ImageMod_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ImageMod

% Last Modified by GUIDE v2.5 14-Oct-2020 00:27:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ImageMod_OpeningFcn, ...
                   'gui_OutputFcn',  @ImageMod_OutputFcn, ...
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


% --- Executes just before ImageMod is made visible.
function ImageMod_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ImageMod (see VARARGIN)

% Choose default command line output for ImageMod
handles.output = hObject;

handles.editname = "newimage.jpg";


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ImageMod wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ImageMod_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in checkboxhistogram.
function checkboxhistogram_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxhistogram (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.histeqval = get(hObject, 'Value');
[handles.maskimage, handles.textimage, handles.gray] = createcncim(handles.file1, handles.printletter, handles.fontsize, handles.txtrot, handles.multiprint, ...
    handles.letterspacing, handles.wordspacing, handles.rowspacing, handles.threshval, handles.imadj, ...
    handles.imadjlow, handles.imadjhigh, handles.histeqval, handles.frameon, handles.circmask, handles.sharpen);

guidata(hObject, handles);
% Hint: get(hObject,'Value') returns toggle state of checkboxhistogram


% --- Executes on slider movement.
function sliderthreshold_Callback(hObject, eventdata, handles)
% hObject    handle to sliderthreshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.threshval = get(hObject,'Value');
[handles.maskimage, handles.textimage, handles.gray] = createcncim(handles.file1, handles.printletter, handles.fontsize, handles.txtrot, handles.multiprint, ...
    handles.letterspacing, handles.wordspacing, handles.rowspacing, handles.threshval, handles.imadj, ...
    handles.imadjlow, handles.imadjhigh, handles.histeqval, handles.frameon, handles.circmask, handles.sharpen);

guidata(hObject, handles);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function sliderthreshold_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderthreshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in checkboxsharpen.
function checkboxsharpen_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxsharpen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.sharpen = get(hObject,'Value');
[handles.maskimage, handles.textimage, handles.gray] = createcncim(handles.file1, handles.printletter, handles.fontsize, handles.txtrot, handles.multiprint, ...
    handles.letterspacing, handles.wordspacing, handles.rowspacing, handles.threshval, handles.imadj, ...
    handles.imadjlow, handles.imadjhigh, handles.histeqval, handles.frameon, handles.circmask, handles.sharpen);



guidata(hObject, handles);


% Hint: get(hObject,'Value') returns toggle state of checkboxsharpen


% --- Executes on slider movement.
function slideradjlow_Callback(hObject, eventdata, handles)
% hObject    handle to slideradjlow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.imadjlow = get(hObject,'Value');
% Check that the slider value wont pass the higher limit
if handles.imadjlow >= handles.imadjhigh
   if handles.imadjlow > 0.01
   handles.imadjlow = handles.imadjhigh - 0.01;
   else
       handles.imadjlow = 0;
   end
   set(handles.slideradjlow, 'Value', handles.imadjlow);
   disp("Cannot exceed the higher limit");
end

[handles.maskimage, handles.textimage, handles.gray] = createcncim(handles.file1, handles.printletter, handles.fontsize, handles.txtrot, handles.multiprint, ...
    handles.letterspacing, handles.wordspacing, handles.rowspacing, handles.threshval, handles.imadj, ...
    handles.imadjlow, handles.imadjhigh, handles.histeqval, handles.frameon, handles.circmask, handles.sharpen);

guidata(hObject, handles);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slideradjlow_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slideradjlow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slideradjhigh_Callback(hObject, eventdata, handles)
% hObject    handle to slideradjhigh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.imadjhigh = get(hObject,'Value');
if handles.imadjhigh <= handles.imadjlow
   if handles.imadjhigh < 0.99
       handles.imadjhigh = handles.imadjlow + 0.01;
   else
       handles.imadhigh = 1;
   end
   set(handles.slideradjhigh, 'Value', handles.imadjhigh);
   disp("Cannot exceed the lower limit");
end

[handles.maskimage, handles.textimage, handles.gray] = createcncim(handles.file1, handles.printletter, handles.fontsize, handles.txtrot, handles.multiprint, ...
    handles.letterspacing, handles.wordspacing, handles.rowspacing, handles.threshval, handles.imadj, ...
    handles.imadjlow, handles.imadjhigh, handles.histeqval, handles.frameon, handles.circmask, handles.sharpen);

guidata(hObject, handles);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slideradjhigh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slideradjhigh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbuttonImpoer.
function pushbuttonImpoer_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonImpoer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles.file,handles.path] = uigetfile;

handles.file1 = [handles.path '\' handles.file];
set(handles.textcurrentfile, 'String', handles.file);


% initializ

%hobjects = [handles.sliderwordspacing ; handles.sliderthreshold ; handles.sliderrowspacing ; handles.sliderletterspacing ; handles.sliderfontsize ; ...
%    handles.slideradjlow ; handles.slideradjhigh ; handles.editrot ; handles.editprintstring ; handles.checkboxsharpen ; handles.checkboxmultiprint ; ...
%    handles.checkboximadj ; handles.checkboxframe ; handles.checkboxcircular]

%[handles.wordspacing , handles.threshval , handles.rowspacing , handles.letterspacing , handles.fontsize , handles.imadjlow , handles.imadjhigh , ...
%    handles.txtrot , handles.printletter , handles.imsharp , handles.multiprint , handles.imadj , handles.frameon , handles.circular]



%if ~isfield(handles, 'histweqval')
    
    handles.histeqval = get(handles.checkboxhistogram, 'Value');
    handles.imadj = get(handles.checkboximadj, 'Value');
    handles. imadjlow = get(handles.slideradjlow, 'Value');
    handles. imadjhigh = get(handles.slideradjhigh, 'Value');
    handles.threshval = get(handles.sliderthreshold, 'Value');
    handles.txtrot = str2double(get(handles.editrot, 'String'));
    handles.printletter = get(handles.editprintstring, 'String');
    handles.fontsize = get(handles.sliderfontsize, 'Value');
    handles.multiprint = get(handles.checkboxmultiprint, 'Value');
    handles.letterspacing = get(handles.sliderletterspacing, 'Value');
    handles.wordspacing = get(handles.sliderwordspacing, 'Value');
    handles.rowspacing = get(handles.sliderrowspacing, 'Value');
    handles.frameon = get(handles.checkboxframe, 'Value');
    handles.circmask = get(handles.checkboxcircular, 'Value');
    handles.sharpen = get(handles.checkboxsharpen, 'Value');
%end
% Create the first bw image
% varargin{1} = text string: Will be printed to the image
% varargin{3} = Font size
% varargin{4} = Font rotation
% varargin{5} = boolean: if the text is printed multiple times
% varargin{6} = Spacing between letters. Can be negative
% varargin{7} = Spacing between words
% varargin{8} = Spacing between rows [0:2]
% varargin{9} = Mask image (binary). Sprites will be printed on 0's = black

[handles.maskimage, handles.textimage, handles.gray] = createcncim(handles.file1, handles.printletter, handles.fontsize, handles.txtrot, handles.multiprint, ...
    handles.letterspacing, handles.wordspacing, handles.rowspacing, handles.threshval, handles.imadj, ...
    handles.imadjlow, handles.imadjhigh, handles.histeqval, handles.frameon, handles.circmask, handles.sharpen);



guidata(hObject, handles);

% --- Executes on button press in pushbuttonSave.
function pushbuttonSave_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonSave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.savename = handles.editname;

try
    imwrite(handles.maskimage, handles.savename);
catch
   disp('Error! No image to be saved'); 
end

guidata(hObject, handles);


function editfilename_Callback(hObject, eventdata, handles)
% hObject    handle to editfilename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.editname = get(hObject, 'String');

guidata(hObject, handles);
% Hints: get(hObject,'String') returns contents of editfilename as text
%        str2double(get(hObject,'String')) returns contents of editfilename as a double


% --- Executes during object creation, after setting all properties.
function editfilename_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editfilename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkboximadj.
function checkboximadj_Callback(hObject, eventdata, handles)
% hObject    handle to checkboximadj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.imadj = get(hObject,'Value');
[handles.maskimage, handles.textimage, handles.gray] = createcncim(handles.file1, handles.printletter, handles.fontsize, handles.txtrot, handles.multiprint, ...
    handles.letterspacing, handles.wordspacing, handles.rowspacing, handles.threshval, handles.imadj, ...
    handles.imadjlow, handles.imadjhigh, handles.histeqval, handles.frameon, handles.circmask, handles.sharpen);

guidata(hObject, handles);
% Hint: get(hObject,'Value') returns toggle state of checkboximadj



function editprintstring_Callback(hObject, eventdata, handles)
% hObject    handle to editprintstring (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.printletter = get(hObject,'String');

[handles.maskimage, handles.textimage, handles.gray] = createcncim(handles.file1, handles.printletter, handles.fontsize, handles.txtrot, handles.multiprint, ...
    handles.letterspacing, handles.wordspacing, handles.rowspacing, handles.threshval, handles.imadj, ...
    handles.imadjlow, handles.imadjhigh, handles.histeqval, handles.frameon, handles.circmask, handles.sharpen);
guidata(hObject, handles);

% Hints: get(hObject,'String') returns contents of editprintstring as text
%        str2double(get(hObject,'String')) returns contents of editprintstring as a double


% --- Executes during object creation, after setting all properties.
function editprintstring_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editprintstring (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editrot_Callback(hObject, eventdata, handles)
% hObject    handle to editrot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
anglestr = get(hObject,'String');
handles.txtrot = str2double(anglestr);
[handles.maskimage, handles.textimage, handles.gray] = createcncim(handles.file1, handles.printletter, handles.fontsize, handles.txtrot, handles.multiprint, ...
    handles.letterspacing, handles.wordspacing, handles.rowspacing, handles.threshval, handles.imadj, ...
    handles.imadjlow, handles.imadjhigh, handles.histeqval, handles.frameon, handles.circmask, handles.sharpen);

guidata(hObject, handles);
% Hints: get(hObject,'String') returns contents of editrot as text
%        str2double(get(hObject,'String')) returns contents of editrot as a double


% --- Executes during object creation, after setting all properties.
function editrot_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editrot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function sliderfontsize_Callback(hObject, eventdata, handles)
% hObject    handle to sliderfontsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.fontsize = get(hObject, 'Value');
[handles.maskimage, handles.textimage, handles.gray] = createcncim(handles.file1, handles.printletter, handles.fontsize, handles.txtrot, handles.multiprint, ...
    handles.letterspacing, handles.wordspacing, handles.rowspacing, handles.threshval, handles.imadj, ...
    handles.imadjlow, handles.imadjhigh, handles.histeqval, handles.frameon, handles.circmask, handles.sharpen);

guidata(hObject, handles);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function sliderfontsize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderfontsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function sliderletterspacing_Callback(hObject, eventdata, handles)
% hObject    handle to sliderletterspacing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.letterspacing = round(get(hObject, 'Value'));
[handles.maskimage, handles.textimage, handles.gray] = createcncim(handles.file1, handles.printletter, handles.fontsize, handles.txtrot, handles.multiprint, ...
    handles.letterspacing, handles.wordspacing, handles.rowspacing, handles.threshval, handles.imadj, ...
    handles.imadjlow, handles.imadjhigh, handles.histeqval, handles.frameon, handles.circmask, handles.sharpen);

guidata(hObject, handles);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function sliderletterspacing_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderletterspacing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function sliderwordspacing_Callback(hObject, eventdata, handles)
% hObject    handle to sliderwordspacing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.wordspacing = get(hObject, 'Value');
[handles.maskimage, handles.textimage, handles.gray] = createcncim(handles.file1, handles.printletter, handles.fontsize, handles.txtrot, handles.multiprint, ...
    handles.letterspacing, handles.wordspacing, handles.rowspacing, handles.threshval, handles.imadj, ...
    handles.imadjlow, handles.imadjhigh, handles.histeqval, handles.frameon, handles.circmask, handles.sharpen);

guidata(hObject, handles);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function sliderwordspacing_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderwordspacing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function sliderrowspacing_Callback(hObject, eventdata, handles)
% hObject    handle to sliderrowspacing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.rowspacing = get(hObject, 'Value');
[handles.maskimage, handles.textimage, handles.gray] = createcncim(handles.file1, handles.printletter, handles.fontsize, handles.txtrot, handles.multiprint, ...
    handles.letterspacing, handles.wordspacing, handles.rowspacing, handles.threshval, handles.imadj, ...
    handles.imadjlow, handles.imadjhigh, handles.histeqval, handles.frameon, handles.circmask, handles.sharpen);

guidata(hObject, handles);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function sliderrowspacing_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderrowspacing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in checkboxmultiprint.
function checkboxmultiprint_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxmultiprint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.multiprint = get(hObject, 'Value');
[handles.maskimage, handles.textimage, handles.gray] = createcncim(handles.file1, handles.printletter, handles.fontsize, handles.txtrot, handles.multiprint, ...
    handles.letterspacing, handles.wordspacing, handles.rowspacing, handles.threshval, handles.imadj, ...
    handles.imadjlow, handles.imadjhigh, handles.histeqval, handles.frameon, handles.circmask, handles.sharpen);

guidata(hObject, handles);
% Hint: get(hObject,'Value') returns toggle state of checkboxmultiprint


% --- Executes on button press in checkboxframe.
function checkboxframe_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxframe (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.frameon = get(hObject, 'Value');
[handles.maskimage, handles.textimage, handles.gray] = createcncim(handles.file1, handles.printletter, handles.fontsize, handles.txtrot, handles.multiprint, ...
    handles.letterspacing, handles.wordspacing, handles.rowspacing, handles.threshval, handles.imadj, ...
    handles.imadjlow, handles.imadjhigh, handles.histeqval, handles.frameon, handles.circmask, handles.sharpen);

guidata(hObject, handles);
% Hint: get(hObject,'Value') returns toggle state of checkboxframe


% --- Executes on button press in checkboxcircular.
function checkboxcircular_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxcircular (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.circmask = get(hObject, 'Value');
[handles.maskimage, handles.textimage, handles.gray] = createcncim(handles.file1, handles.printletter, handles.fontsize, handles.txtrot, handles.multiprint, ...
    handles.letterspacing, handles.wordspacing, handles.rowspacing, handles.threshval, handles.imadj, ...
    handles.imadjlow, handles.imadjhigh, handles.histeqval, handles.frameon, handles.circmask, handles.sharpen);

guidata(hObject, handles);
% Hint: get(hObject,'Value') returns toggle state of checkboxcircular
