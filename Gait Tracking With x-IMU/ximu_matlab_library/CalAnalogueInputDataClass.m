classdef CalAnalogueInputDataClass < AnalogueInputDataBaseClass

    %% Public 'read-only' properties
    properties (SetAccess = private)
        FileNameAppendage = '_CalAnalogueInput.csv';
    end

    %% Public methods
    methods (Access = public)
        function obj = CalAnalogueInputDataClass(varargin)
            fileNamePrefix = varargin{1};
            for i = 2:2:nargin
                if  strcmp(varargin{i}, 'SampleRate'), obj.SampleRate = varargin{i+1};
                else error('Invalid argument.');
                end
            end
            obj.Import(fileNamePrefix);

            % Set protected parent class variables
            obj.ADCunits = 'V';
        end
    end
end