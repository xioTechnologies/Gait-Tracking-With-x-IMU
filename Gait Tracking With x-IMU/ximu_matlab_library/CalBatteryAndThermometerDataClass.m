classdef CalBatteryAndThermometerDataClass < BatteryAndThermometerDataBaseClass

    %% Public 'read-only' properties
    properties (SetAccess = private)
        FileNameAppendage = '_CalBattAndTherm.csv';
    end

    %% Public methods
    methods (Access = public)
        function obj = CalBatteryAndThermometerDataClass(varargin)
            fileNamePrefix = varargin{1};
            for i = 2:2:nargin
                if  strcmp(varargin{i}, 'SampleRate'), obj.SampleRate = varargin{i+1};
                else error('Invalid argument.');
                end
            end
            obj.Import(fileNamePrefix);

            % Set protected parent class variables
            obj.ThermometerUnits = '^\circC';
            obj.BatteryUnits = 'G';
        end
    end
end