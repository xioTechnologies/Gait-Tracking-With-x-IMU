classdef xIMUdataClass < handle

    %% Public properties

    properties (Access = public)

        % General properties
        FileNamePrefix = '';
        ConstructorImport = true;

        % Data classes
        RawBattThermData = RawBattThermDataClass();
        CalBattThermData = CalBattThermDataClass();
        RawInertialMagneticData = RawInertialMagneticDataClass();
        CalInertialMagneticData = CalInertialMagneticDataClass();
        QuaternionData = QuaternionDataClass();
        RotationMatrixData = RotationMatrixDataClass();
        EulerAnglesData = EulerAnglesDataClass();
        DigitalIOData = DigitalIODataClass();

    end

    %% Public methods

    methods (Access = public)

        % Constructor
        function obj = xIMUdataClass(varargin)
            obj.FileNamePrefix = varargin{1};
            for i = 2:2:nargin
                if  strcmp(varargin{i}, 'PrintProgress'), obj.PrintProgress = varargin{i+1};
                elseif  strcmp(varargin{i}, 'ConstructorImport'), obj.ConstructorImport = varargin{i+1};
                elseif  strcmp(varargin{i}, 'BattThermSampleRate')
                    obj.RawBattThermData.SampleRate = varargin{i+1};
                    obj.CalwBattThermData.SampleRate = varargin{i+1};
                elseif  strcmp(varargin{i}, 'InertialMagneticSampleRate')
                    obj.RawInertialMagneticData.SampleRate = varargin{i+1};
                    obj.CalInertialMagneticData.SampleRate = varargin{i+1};
                elseif  strcmp(varargin{i}, 'QuaternionSampleRate')
                    obj.QuaternionData.SampleRate = varargin{i+1};
                    obj.RotationMatrixData.SampleRate = varargin{i+1};
                    obj.EulerAnglesData.SampleRate = varargin{i+1};
                elseif  strcmp(varargin{i}, 'DigitalIOSampleRate'), obj.DigitalIOData.SampleRate = varargin{i+1};
                else error('Invalid argument.');
                end
            end
            if(obj.ConstructorImport)
                obj.Import();
            end
        end

        % General methods
        function obj = Import(obj)
            fileName = strcat(obj.FileNamePrefix, obj.RawBattThermData.FileNameAppendage);
            if(exist(fileName, 'file')), obj.RawBattThermData.Import(obj.FileNamePrefix); end
            fileName = strcat(obj.FileNamePrefix, obj.CalBattThermData.FileNameAppendage);
            if(exist(fileName, 'file')), obj.CalBattThermData.Import(obj.FileNamePrefix); end
            fileName = strcat(obj.FileNamePrefix, obj.RawInertialMagneticData.FileNameAppendage);
            if(exist(fileName, 'file')), obj.RawInertialMagneticData.Import(obj.FileNamePrefix); end
            fileName = strcat(obj.FileNamePrefix, obj.CalInertialMagneticData.FileNameAppendage);
            if(exist(fileName, 'file')), obj.CalInertialMagneticData.Import(obj.FileNamePrefix); end
            fileName = strcat(obj.FileNamePrefix, obj.QuaternionData.FileNameAppendage);
            if(exist(fileName, 'file')), obj.QuaternionData.Import(obj.FileNamePrefix); end
            fileName = strcat(obj.FileNamePrefix, obj.EulerAnglesData.FileNameAppendage);
            if(exist(fileName, 'file')), obj.EulerAnglesData.Import(obj.FileNamePrefix); end
            fileName = strcat(obj.FileNamePrefix, obj.RotationMatrixData.FileNameAppendage);
            if(exist(fileName, 'file')), obj.RotationMatrixData.Import(obj.FileNamePrefix); end
            fileName = strcat(obj.FileNamePrefix, obj.DigitalIOData.FileNameAppendage);
            if(exist(fileName, 'file')), obj.DigitalIOData.Import(obj.FileNamePrefix); end
        end
        function Plot(obj)
            if(obj.RawBattThermData.NumSamples ~= 0), obj.RawBattThermData.Plot(); end
            if(obj.CalBattThermData.NumSamples ~= 0), obj.CalBattThermData.Plot(); end
            if(obj.RawInertialMagneticData.NumSamples ~= 0), obj.RawInertialMagneticData.Plot(); end
            if(obj.CalInertialMagneticData.NumSamples ~= 0), obj.CalInertialMagneticData.Plot(); end
            %if(obj.QuaternionData.NumSamples ~= 0), obj.QuaternionData.Plot(); end
            %if(obj.RotationMatrixData.NumSamples ~= 0), obj.RotationMatrixData.Plot(); end
            if(obj.EulerAnglesData.NumSamples ~= 0), obj.EulerAnglesData.Plot(); end
            if(obj.DigitalIOData.NumSamples ~= 0), obj.DigitalIOData.Plot(); end
        end
    end

end

%% End of class