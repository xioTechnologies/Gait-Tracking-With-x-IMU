classdef xIMUdataClass < handle

    %% Public properties
    properties (SetAccess = private)
        FileNamePrefix = '';
        ErrorData = [];
        CommandData = [];
        RegisterData = [];
        DateTimeData = [];
        RawBatteryAndThermometerData = [];
        CalBatteryAndThermometerData = [];
        RawInertialAndMagneticData = [];
        CalInertialAndMagneticData = [];
        QuaternionData = [];
        RotationMatrixData = [];
        EulerAnglesData = [];
        DigitalIOdata = [];
        RawAnalogueInputData = [];
        CalAnalogueInputData = [];
        PWMoutputData = [];
        RawADXL345busData = [];
        CalADXL345busData = [];
    end

    %% Public methods
    methods (Access = public)
        function obj = xIMUdataClass(varargin)
            % Create data objects from files
            obj.FileNamePrefix = varargin{1};
            dataImported = false;
            try obj.ErrorData = ErrorDataClass(obj.FileNamePrefix); dataImported = true; catch e, end
            try obj.CommandData = CommandDataClass(obj.FileNamePrefix); dataImported = true; catch e, end
            try obj.RegisterData = RegisterDataClass(obj.FileNamePrefix); dataImported = true; catch e, end
            try obj.DateTimeData = DateTimeDataClass(obj.FileNamePrefix); dataImported = true; catch e, end
            try obj.RawBatteryAndThermometerData = RawBatteryAndThermometerDataClass(obj.FileNamePrefix); dataImported = true; catch e, end
            try obj.CalBatteryAndThermometerData = CalBatteryAndThermometerDataClass(obj.FileNamePrefix); dataImported = true; catch e, end
            try obj.RawInertialAndMagneticData = RawInertialAndMagneticDataClass(obj.FileNamePrefix); dataImported = true; catch e, end
            try obj.CalInertialAndMagneticData = CalInertialAndMagneticDataClass(obj.FileNamePrefix); dataImported = true; catch e, end
            try obj.QuaternionData = QuaternionDataClass(obj.FileNamePrefix); dataImported = true; catch e, end
            try obj.EulerAnglesData = EulerAnglesDataClass(obj.FileNamePrefix); dataImported = true; catch e, end
            try obj.RotationMatrixData = RotationMatrixDataClass(obj.FileNamePrefix); dataImported = true; catch e, end
            try obj.DigitalIOdata = DigitalIOdataClass(obj.FileNamePrefix); dataImported = true; catch e, end
            try obj.RawAnalogueInputData = RawAnalogueInputDataClass(obj.FileNamePrefix); dataImported = true; catch e, end
            try obj.CalAnalogueInputData = CalAnalogueInputDataClass(obj.FileNamePrefix); dataImported = true; catch e, end
            try obj.PWMoutputData = PWMoutputDataClass(obj.FileNamePrefix); dataImported = true; catch e, end
            try obj.RawADXL345busData = RawADXL345busDataClass(obj.FileNamePrefix); dataImported = true; catch e, end
            try obj.CalADXL345busData = CalADXL345busDataClass(obj.FileNamePrefix); dataImported = true; catch e, end
            if(~dataImported)
                error('No data was imported.');
            end

            % Apply SampleRate from register data
            try h = obj.DateTimeData; h.SampleRate = obj.SampleRateFromRegValue(obj.RegisterData.GetValueAtAddress(67)); catch e, end
            try h = obj.RawBatteryAndThermometerData; h.SampleRate = obj.SampleRateFromRegValue(obj.RegisterData.GetValueAtAddress(68)); catch e, end
            try h = obj.CalBatteryAndThermometerData; h.SampleRate = obj.SampleRateFromRegValue(obj.RegisterData.GetValueAtAddress(68)); catch e, end
            try h = obj.RawInertialAndMagneticData; h.SampleRate = obj.SampleRateFromRegValue(obj.RegisterData.GetValueAtAddress(69)); catch e, end
            try h = obj.CalInertialAndMagneticData; h.SampleRate = obj.SampleRateFromRegValue(obj.RegisterData.GetValueAtAddress(69)); catch e, end
            try h = obj.QuaternionData; h.SampleRate = obj.SampleRateFromRegValue(obj.RegisterData.GetValueAtAddress(70)); catch e, end
            try h = obj.RotationMatrixData; h.SampleRate = obj.SampleRateFromRegValue(obj.RegisterData.GetValueAtAddress(70)); catch e, end
            try h = obj.EulerAnglesData; h.SampleRate = obj.SampleRateFromRegValue(obj.RegisterData.GetValueAtAddress(70)); catch e, end
            try h = obj.DigitalIOdata; h.SampleRate = obj.SampleRateFromRegValue(obj.RegisterData.GetValueAtAddress(78)); catch e, end
            try h = obj.RawAnalogueInputData; h.SampleRate = obj.SampleRateFromRegValue(obj.RegisterData.GetValueAtAddress(80)); catch e, end
            try h = obj.CalAnalogueInputData; h.SampleRate = obj.SampleRateFromRegValue(obj.RegisterData.GetValueAtAddress(80)); catch e, end
            try h = obj.RawADXL345busData; h.SampleRate = obj.SampleRateFromRegValue(obj.RegisterData.GetValueAtAddress(85)); catch e, end
            try h = obj.CalADXL345busData; h.SampleRate = obj.SampleRateFromRegValue(obj.RegisterData.GetValueAtAddress(85)); catch e, end

            % Apply SampleRate if specified as argument
            for i = 2:2:(nargin)
                if strcmp(varargin{i}, 'DateTimeSampleRate')
                    try h = obj.DateTimeData; h.SampleRate = varargin{i+1}; catch e, end
                elseif strcmp(varargin{i}, 'BattThermSampleRate')
                    try h = obj.RawBatteryAndThermometerData; h.SampleRate = varargin{i+1}; catch e, end
                    try h = obj.CalBatteryAndThermometerData; h.SampleRate = varargin{i+1}; catch e, end
                elseif strcmp(varargin{i}, 'InertialMagneticSampleRate')
                    try h = obj.RawInertialAndMagneticData; h.SampleRate = varargin{i+1}; catch e, end
                    try h = obj.CalInertialAndMagneticData; h.SampleRate = varargin{i+1}; catch e, end
                elseif strcmp(varargin{i}, 'QuaternionSampleRate')
                    try h = obj.QuaternionData; h.SampleRate = varargin{i+1}; catch e, end
                    try h = obj.RotationMatrixData.SampleRate; h.SampleRate = varargin{i+1}; catch e, end
                    try h = obj.EulerAnglesData; h.SampleRate = varargin{i+1}; catch e, end
                elseif strcmp(varargin{i}, 'DigitalIOSampleRate')
                    try h = obj.DigitalIOdata; h.SampleRate = varargin{i+1}; catch e, end
                elseif strcmp(varargin{i}, 'AnalogueInputSampleRate')
                    try h = obj.RawAnalogueInputData; h.SampleRate = varargin{i+1}; catch e, end
                    try h = obj.CalAnalogueInputData; h.SampleRate = varargin{i+1}; catch e, end
                elseif strcmp(varargin{i}, 'ADXL345SampleRate')
                    try h = obj.RawADXL345busData; h.SampleRate = varargin{i+1}; catch e, end
                    try h = obj.CalADXL345busData; h.SampleRate = varargin{i+1}; catch e, end
                else
                    error('Invalid argument.');
                end
            end
        end
        function obj = Plot(obj)
            try obj.RawBatteryAndThermometerData.Plot(); catch e, end
            try obj.CalBatteryAndThermometerData.Plot(); catch e, end
            try obj.RawInertialAndMagneticData.Plot(); catch e, end
            try obj.CalInertialAndMagneticData.Plot(); catch e, end
            try obj.QuaternionData.Plot(); catch e, end
            try obj.EulerAnglesData.Plot(); catch e, end
            try obj.RotationMatrixDataClass.Plot(); catch e, end
            try obj.DigitalIOdata.Plot(); catch e, end
            try obj.RawAnalogueInputData.Plot(); catch e, end
            try obj.CalAnalogueInputData.Plot(); catch e, end
            try obj.RawADXL345busData.Plot(); catch e, end
            try obj.CalADXL345busData.Plot(); catch e, end
        end
    end

    %% Private methods
    methods (Access = private)
        function sampleRate = SampleRateFromRegValue(obj, value)
            sampleRate = floor(2^(value-1));
        end
    end
end