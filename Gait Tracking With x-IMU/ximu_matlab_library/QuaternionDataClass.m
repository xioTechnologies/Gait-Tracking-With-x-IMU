classdef QuaternionDataClass < TimeSeriesDataBaseClass

    %% Public 'read-only' properties
    properties (SetAccess = private)
        FileNameAppendage = '_Quaternion.csv';
        Quaternion = [];
    end

    %% Public methods
    methods (Access = public)
        function obj = QuaternionDataClass(varargin)
            fileNamePrefix = varargin{1};
            for i = 2:2:nargin
                if  strcmp(varargin{i}, 'SampleRate'), obj.SampleRate = varargin{i+1};
                else error('Invalid argument.');
                end
            end
            data = obj.ImportCSVnumeric(fileNamePrefix);
            obj.Quaternion = data(:,2:5);
            obj.SampleRate = obj.SampleRate;	% call set method to create time vector
        end
        function obj = Plot(obj)
            error('This method is unimplemented.');
        end
    end
end