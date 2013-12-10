function SyncroniseData(varargin)
%SYNCRONISEDATA Syncronises time series data between xIMUdataClass objects
%
%   SyncroniseData(xIMUdataStruct, StartEventTimes)
%   SyncroniseData(xIMUdataStruct, StartEventTimes, EndEventTimes)
%   SyncroniseData(xIMUdataStruct, 'UseAX0fallingEdge')
%
%   This fuction syncronises time series data between xIMUdataClass objects
%   by adjusting the StartTime and SampleRate properties of each data
%   class.
%
%   StartEventTimes is vector of values representing the time at which a
%   'start synchronisation event' common to all xIMUdataClass objects is
%   known to occur within each xIMUdataClass object's time series data. The
%   length of this vector must equal the number of xIMUdataClass objects
%   in xIMUdataStruct.
%
%   EndEventTimes is vector of values representing the time at which a
%   'end synchronisation event' common to all xIMUdataClass objects is
%   known to occur within each xIMUdataClass object's time series data. The
%   length of this vector must equal the number of xIMUdataClass objects
%   in xIMUdataStruct.
%
%   'UseAX0fallingEdge' should be specified if a falling edge of the
%   auxilary port (configured in digital I/O mode) channel AX0 represents
%   the 'start synchronisation event' or 'start synchronisation event' and
%   'end synchronisation event'.

    %% Apply arguments
    xIMUdata = varargin{1};
    xIMUdataObjs = struct2cell(xIMUdata);
    StartEventTimes = [];
    EndEventTimes = [];
    UseAX0fallingEdge = false;
    if(ischar(varargin{2}))
        if strcmp(varargin{2}, 'UseAX0fallingEdge'), UseAX0fallingEdge = true;
        else error('Invalid argument.');
        end
    else
        StartEventTimes = varargin{2};
        if(nargin == 3)
            EndEventTimes = varargin{3};
        end
    end

    %% Use AX0 falling edge of auxiliary port in Digital I/O mode
    if(UseAX0fallingEdge)
        for i = 1:numel(xIMUdataObjs)
            fallingEdgeIndexes = [0; diff(xIMUdataObjs{i}.DigitalIOdata.State.AX0)] == -1;
            fallingEdgeTimes = xIMUdataObjs{i}.DigitalIOdata.Time(fallingEdgeIndexes);
            StartEventTimes = [StartEventTimes; fallingEdgeTimes(1)];
            if(numel(fallingEdgeTimes) > 1)
                EndEventTimes = [EndEventTimes; fallingEdgeTimes(end)];
            end
        end
    end

    %% Modify start times to synchronise start of window
    if(numel(StartEventTimes) ~= numel(xIMUdataObjs))
        error('Length of StartEventTimes vector must equal number of xIMUdataClass objects');
    end
    for i = 1:numel(xIMUdataObjs)
        try h = xIMUdataObjs{i}.DateTimeData; h.StartTime = -StartEventTimes(i); catch e, end
        try h = xIMUdataObjs{i}.RawBatteryAndThermometerData; h.StartTime = -StartEventTimes(i); catch e, end
        try h = xIMUdataObjs{i}.CalBatteryAndThermometerData; h.StartTime = -StartEventTimes(i); catch e, end
        try h = xIMUdataObjs{i}.RawInertialAndMagneticData; h.StartTime = -StartEventTimes(i); catch e, end
        try h = xIMUdataObjs{i}.CalInertialAndMagneticData; h.StartTime = -StartEventTimes(i); catch e, end
        try h = xIMUdataObjs{i}.QuaternionData; h.StartTime = -StartEventTimes(i); catch e, end
        try h = xIMUdataObjs{i}.RotationMatrixData; h.StartTime = -StartEventTimes(i); catch e, end
        try h = xIMUdataObjs{i}.EulerAnglesData; h.StartTime = -StartEventTimes(i); catch e, end
        try h = xIMUdataObjs{i}.DigitalIOdata; h.StartTime = -StartEventTimes(i); catch e, end
        try h = xIMUdataObjs{i}.RawAnalogueInputData; h.StartTime = -StartEventTimes(i); catch e, end
        try h = xIMUdataObjs{i}.CalAnalogueInputData; h.StartTime = -StartEventTimes(i); catch e, end
        try h = xIMUdataObjs{i}.RawADXL345busData; h.StartTime = -StartEventTimes(i); catch e, end
        try h = xIMUdataObjs{i}.CalADXL345busData; h.StartTime = -StartEventTimes(i); catch e, end
    end

    %% Modify sample rate to synchronise end of window
    if(numel(EndEventTimes) == 0)
        return;
    end
    if(numel(EndEventTimes) ~= numel(xIMUdataObjs))
        error('Length of EndEventTimes vector must equal number of xIMUdataClass objects');
    end
    scalers = (EndEventTimes - StartEventTimes) * (1/((EndEventTimes(1)-StartEventTimes(1))));
    for i = 2:numel(xIMUdataObjs)
        try h = xIMUdataObjs{i}.DateTimeData; h.SampleRate = scalers(i)*h.SampleRate; h.StartTime = StartEventTimes(i)/scalers(i); catch e, end
        try h = xIMUdataObjs{i}.RawBatteryAndThermometerData; h.SampleRate = scalers(i)*h.SampleRate; h.StartTime = StartEventTimes(i)/scalers(i); catch e, end
        try h = xIMUdataObjs{i}.CalBatteryAndThermometerData; h.SampleRate = scalers(i)*h.SampleRate; h.StartTime = StartEventTimes(i)/scalers(i); catch e, end
        try h = xIMUdataObjs{i}.RawInertialAndMagneticData; h.SampleRate = scalers(i)*h.SampleRate; h.StartTime = StartEventTimes(i)/scalers(i); catch e, end
        try h = xIMUdataObjs{i}.CalInertialAndMagneticData; h.SampleRate = scalers(i)*h.SampleRate; h.StartTime = -StartEventTimes(i)/scalers(i); catch e, end
        try h = xIMUdataObjs{i}.QuaternionData; h.SampleRate = scalers(i)*h.SampleRate; h.StartTime = StartEventTimes(i)/scalers(i); catch e, end
        try h = xIMUdataObjs{i}.RotationMatrixData; h.SampleRate = scalers(i)*h.SampleRate; h.StartTime = StartEventTimes(i)/scalers(i); catch e, end
        try h = xIMUdataObjs{i}.EulerAnglesData; h.SampleRate = scalers(i)*h.SampleRate; h.StartTime = StartEventTimes(i)/scalers(i); catch e, end
        try h = xIMUdataObjs{i}.DigitalIOdata; h.SampleRate = scalers(i)*h.SampleRate; h.StartTime = StartEventTimes(i)/scalers(i); catch e, end
        try h = xIMUdataObjs{i}.RawAnalogueInputData; h.SampleRate = scalers(i)*h.SampleRate; h.StartTime = StartEventTimes(i)/scalers(i); catch e, end
        try h = xIMUdataObjs{i}.CalAnalogueInputData; h.SampleRate = scalers(i)*h.SampleRate; h.StartTime = StartEventTimes(i)/scalers(i); catch e, end
        try h = xIMUdataObjs{i}.RawADXL345busData; h.SampleRate = scalers(i)*h.SampleRate; h.StartTime = StartEventTimes(i)/scalers(i); catch e, end
        try h = xIMUdataObjs{i}.CalADXL345busData; h.SampleRate = scalers(i)*h.SampleRate; h.StartTime = StartEventTimes(i)/scalers(i); catch e, end
    end
end
