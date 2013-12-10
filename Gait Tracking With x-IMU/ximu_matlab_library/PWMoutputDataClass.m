classdef PWMoutputDataClass < DataBaseClass

    %% Public 'read-only' properties
    properties (SetAccess = private)
        FileNameAppendage = '_PWMoutput.csv';
        AX0 = [];
        AX2 = [];
        AX4 = [];
        AX6 = [];
    end

    %% Public methods
    methods (Access = public)
        function obj = PWMoutputDataClass(fileNamePrefix)
            data = obj.ImportCSVnumeric(fileNamePrefix);
            obj.AX0 = data(:,2);
            obj.AX2 = data(:,3);
            obj.AX4 = data(:,4);
            obj.AX6 = data(:,5);
        end
    end
end