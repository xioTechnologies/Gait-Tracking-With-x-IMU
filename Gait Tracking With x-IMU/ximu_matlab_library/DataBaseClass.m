classdef DataBaseClass < handle

    %% Abstract public 'read-only' properties
    properties (Abstract, SetAccess = private)
        FileNameAppendage;
    end

    %% Public 'read-only' properties
    properties (SetAccess = private)
        NumPackets = 0;
        PacketNumber = [];
    end

    %% Protected methods
    methods (Access = protected)
        function data = ImportCSVnumeric(obj, fileNamePrefix)
            data = dlmread(obj.CreateFileName(fileNamePrefix), ',', 1, 0);
            obj.PacketNumber = data(:,1);
            obj.NumPackets = length(obj.PacketNumber);
        end
        function data = ImportCSVmixed(obj, fileNamePrefix, fieldSpecifier)
            fid = fopen(obj.CreateFileName(fileNamePrefix));
            fgets(fid);     % disregard column headings
            data = textscan(fid, fieldSpecifier, 'Delimiter', ',');
            fclose(fid);
            obj.PacketNumber = data{1};
            obj.NumPackets = length(obj.PacketNumber);
        end
        function figName = CreateFigName(obj)
            [pathstr, name , ext, versn] = fileparts(obj.FileNameAppendage);
            figName = name(2:end);
        end
    end

    %% Private methods
    methods (Access = private)
        function fileName = CreateFileName(obj, fileNamePrefix)
            fileName = strcat(fileNamePrefix, obj.FileNameAppendage);
            if(~exist(fileName, 'file'))
                error('File not found. No data was imported.');
            end
        end
    end
end