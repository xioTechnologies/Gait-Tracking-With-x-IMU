classdef ErrorDataClass < DataBaseClass

    %% Public 'read-only' properties
    properties (SetAccess = private)
        FileNameAppendage = '_Errors.csv';
        Code = [];
        Message = [];
    end

    %% Public methods
    methods (Access = public)
        function obj = ErrorDataClass(fileNamePrefix)
            data = obj.ImportCSVmixed(fileNamePrefix, '%f %f %s');
            obj.Code = data{2};
            obj.Message = data{3};
        end
    end
end