function varargout = finalGUI(varargin)
% initialization code
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @finalGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @finalGUI_OutputFcn, ...
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

% --- Executes just before finalGUI is made visible.
function finalGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% handles    structure with handles and user data
% varargin   command line arguments to finalGUI
% default command line output
handles.output = hObject;
% handle structure
guidata(hObject, handles);

% UIWAIT makes finalGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = finalGUI_OutputFcn(hObject, eventdata, handles)
% default command line output from handles structure
varargout{1} = handles.output;

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% here we load image
global im im2 %creates 2 global images (one for back up)
[path]=imgetfile(); %gets the file from the user
im=imread(path); %follows the path and gets the image
im=im2double(im); %Convert image to double precision
im2=im; % for back up process
axes(handles.axes1); %keeps the axes the same
imshow(im) %displays the loaded image

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% here we reset image to original
global im2 %global back up image
axes(handles.axes1); %keeps the axes the same
imshow(im2); %displays the original image

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% Negative
global im %keeps the image global
imNeg=1-im; %changes to negative
axes(handles.axes1); %keeps the axes the same
imshow(imNeg);%displays the negative image

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% Grayscale using (r+g+g)/3
global im %keeps the image global
imgray=(im(:,:,1)+im(:,:,2)+im(:,:,2))/3; %converts the image to grayscale
axes(handles.axes1); %keeps the axes the same
imshow(imgray);%displays the image

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% 2x2 pop art switching rgb
global im %keeps the image global
im2=im; %creates a copy of the orignial image
im2(:,:,1)=im(:,:,3); %switches red and blue layers
im2(:,:,2)=im(:,:,2); %keep green layer
im2(:,:,3)=im(:,:,1); %switches blue and red layers
final2x2img = [im im2; im2 im];
%creates a 2x2 collage of the original image and the new image
axes(handles.axes1); %keeps the axes the same
imshow(final2x2img);%displays the 2x2 pop art image image

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% 2x3 pop art switching rgb
global im %keeps the image global
im2=im; %creates a copy of the orignial image
im3=im; %creates a copy of the orignial image
im2(:,:,1)=im(:,:,3); %switches red and blue layers
im2(:,:,2)=im(:,:,2); %keep green layer
im2(:,:,3)=im(:,:,1); %switches blue and red layers
im3(:,:,1)=im(:,:,1); %keep red layer
im3(:,:,2)=im(:,:,3); %switches green and blue layers
im3(:,:,3)=im(:,:,2); %switches blue and green layers
final2x3img = [im im2 im3; im2 im3 im];
%creates a 2x3 collage of the original image and he two new images
axes(handles.axes1); %keeps the axes the same
imshow(final2x3img);%displays the 2x3 pop art image

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% Applies a wave to the image
global im %keeps the image global
img=im2double(im); % converts image to double percision
[m,n,o]=size(img); % The size of the image is held by m,n,o
waveImg=img; % creates a copy of the original img to a new wave image
for row = 1:m % goes threw row-wise
  for col = 1:n % goes through column-wise
      col=col; % the y stays the same
      newX = row + 50*cos((1/30)*col); % a funtion that creates the wave
      newX = floor(newX); % Round towards minus infinity
      if newX>m % if the x is greater than the number of rows
          newX=max(m); % bound by the largest value of the rows
      elseif newX<1 % if the x is less than 1
          newX=min(1); % bound by the smallest value which is 1
      end
      waveImg(newX,col,:) = img(row,col,:); % creates the new image with the wave function newX on the original image
  end
axes(handles.axes1); %keeps the axes the same
imshow(waveImg);%displays the wave image
end

% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% Saves the image
f = figure; %creates a new figure
copyobj(handles.axes1,f); %copies the image
saveas(f,'finalImg.jpg'); %saves the image

function slider1_Callback(hObject, eventdata, handles)
% Applies brightness to an image
global im %keeps the image global
val=0.5*get(hObject,'Value')-0.5; %gets the value of the hObject the user chooses
imbright=im+val; %creates the image with the brightness chosen
axes(handles.axes1); %keeps the axes the same
imshow(imbright);%displays the image with the brightness chosen

Published with MATLAB® R2014a
