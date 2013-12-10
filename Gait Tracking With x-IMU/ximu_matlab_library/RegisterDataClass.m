classdef RegisterDataClass < DataBaseClass

    %% Public 'read-only' properties
    properties (SetAccess = private)
        FileNameAppendage = '_Registers.csv';
        Address = [];
        Value = [];
        FloatValue = [];
        Name = {};
    end

    %% Public methods
    methods (Access = public)
        function obj = RegisterDataClass(fileNamePrefix)
            data = obj.ImportCSVmixed(fileNamePrefix, '%f %f %f %f %s');
            obj.Address = data{2};
            obj.Value = data{3};
            obj.FloatValue = data{4};
            obj.Name = data{5};
        end
        function value = GetValueAtAddress(obj, address)
            value = obj.ValueAtIndexes(obj.IndexesOfAddress(address));
        end
        function floatValue = GetFloatValueAtAddress(obj, address)
            floatValue = obj.FloatValueAtIndexes(obj.IndexesOfAddress(address));
        end
        function value = GetValueAtName(obj, name)
            value = obj.ValueAtIndexes(obj.IndexesOfName(name));
        end
        function floatValue = GetFloatValueAtName(obj, name)
            floatValue = obj.FloatValueAtIndexes(obj.IndexesOfName(name));
        end
    end

    %% Private methods
    methods (Access = private)
        function indexes = IndexesOfAddress(obj, address)
            indexes = find(obj.Address == address);
            if(isempty(indexes))
                error('Register address not found.');
            end
        end
        function indexes = IndexesOfName(obj, name)
            indexes = find(ismember(obj.Name, name));
            if(isempty(indexes))
                error('Register name not found.');
            end
        end
        function value = ValueAtIndexes(obj, indexes)
            if(numel(unique(obj.Value(indexes))) > 1)
                error('Conflicting register values exist.');
            end
            value = obj.Value(indexes(1));
        end
        function floatValue = FloatValueAtIndexes(obj, indexes)
            if(numel(unique(obj.FloatValue(indexes))) > 1)
                error('Conflicting register values exist.');
            end
            floatValue = obj.FloatValue(indexes(1));
        end
    end
end