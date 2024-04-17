%% Import data from text file.
% Script for importing data from the following text file:
%
%    C:\Users\kevin\A\Instrumentacion\Practicas\Practica4\Medidas\Sobre\Inductor\F0002CH1.CSV
%
% To extend the code to different selected data or a different text file,
% generate a function instead of a script.

% Auto-generated by MATLAB on 2024/04/09 19:25:38

%% Initialize variables.
filename = 'C:\Users\kevin\A\Instrumentacion\Practicas\Practica4\Medidas\Sobre\Inductor\F0000CH1.CSV';
delimiter = ',';

%% Format string for each line of text:
%   column4: double (%f)
%	column5: double (%f)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%*s%*s%*s%f%f%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'EmptyValue' ,NaN, 'ReturnOnError', false);

%% Close the text file.
fclose(fileID);

%% Post processing for unimportable data.
% No unimportable data rules were applied during the import, so no post
% processing code is included. To generate code which works for
% unimportable data, select unimportable cells in a file and regenerate the
% script.

%% Create output variable
SobVl = table(dataArray{1:end-1}, 'VariableNames', {'t','V'});
SobVl = table(SobVl.t(132:689)-SobVl.t(132),SobVl.V(132:689), 'VariableNames', {'t','V'});
% -SobVl.t(223)
%% Clear temporary variables
clearvars filename delimiter formatSpec fileID dataArray ans;