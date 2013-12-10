function xIMUdataStruct = ImportDirectory(directory)
%IMPORTDIRECTORY Imports all x-IMU data CSV files within directory
%
%   xIMUdataStruct = ImportDirectory(directory)
%
%   Automatically imports x-IMU CSV files within specified directly.
%   Imported data is returned as a structure of xIMUdataClass objects.  The
%   name of each member will "ID_ABCD" where "ABCD" if the x-IMU device ID
%   if available (i.e. if *_Registers.csv file present) or "FILE_00000"
%   where "00000" is the file name prefix of the CSV files.

    %% Import CSV files
    listing = dir(strcat(directory, '\*_*.csv'));				% list all *_*.csv files in directory
    fileNamePrefixes = unique(strtok({listing.name}, '_'));     % list unique file name prefixes (e.g. name_*.csv)
    xIMUdataObjs = cell(length(fileNamePrefixes), 1);
    for i = 1:length(fileNamePrefixes)
        try xIMUdataObjs{i} = xIMUdataClass(strcat(directory, '\', fileNamePrefixes{i})); catch e, end
    end
    fileNamePrefixes(cellfun(@isempty,xIMUdataObjs)) = [];      % remove failures from lists
    xIMUdataObjs(cellfun(@isempty,xIMUdataObjs)) = [];
    if(numel(xIMUdataObjs) == 0)
        error('No data was imported.');
    end

    %% Organise data in structure
    fieldNames = cell(numel(xIMUdataObjs), 1);
    try                                                         % try using device IDs as structure field names
        for i = 1:numel(xIMUdataObjs)
            fieldNames{i} = strcat('ID_', dec2hex(xIMUdataObjs{i}.RegisterData.GetValueAtAddress(2)));
        end
        xIMUdataStruct = orderfields(cell2struct(xIMUdataObjs, fieldNames, 1));
    catch e                                                     % otherwise use file name prefix (alpha-numeric characters only)
        for i = 1:numel(xIMUdataObjs)
            fieldNames{i} = strcat('FILE_', fileNamePrefixes{i}(isstrprop(fileNamePrefixes{i}, 'alphanum')));
        end
        xIMUdataStruct = orderfields(cell2struct(xIMUdataObjs, fieldNames, 1));
    end
end
