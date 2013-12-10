classdef DateTimeDataClass < TimeSeriesDataBaseClass

    %% Public 'read-only' properties
    properties (SetAccess = private)
        FileNameAppendage = '_DateTime.csv';
        String = [];
        Vector = [];
        Serial = [];
    end

    %% Public methods
    methods (Access = public)
        function obj = DateTimeDataClass(varargin)
            fileNamePrefix = varargin{1};
            for i = 2:2:nargin
                if  strcmp(varargin{i}, 'SampleRate'), obj.SampleRate = varargin{i+1};
                else error('Invalid argument.');
                end
            end
            data = obj.ImportCSVnumeric(fileNamePrefix);
            obj.Vector = data(:,2:7);
            obj.String = cellstr(datestr(obj.Vector));
            obj.Serial = datenum(obj.Vector);
            obj.SampleRate = obj.SampleRate;	% call set method to create time vector
        end
        function obj = Plot(obj)
            error('This method is unimplemented.');
        end
    end
end