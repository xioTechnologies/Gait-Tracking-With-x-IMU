function obj = AHRS_Octave(varargin)
	%Assign constant values
	obj = struct();
	obj.SamplePeriod = 1/256;
	obj.Quaternion = [1 0 0 0];     % output quaternion describing the sensor relative to the Earth
	obj.q = [1 0 0 0];
	obj.Kp = 2;                     % proportional gain
	obj.Ki = 0;                     % integral gain
	obj.KpInit = 200;               % proportional gain used during initialisation
	obj.initPeriod = 5;             % initialisation period in seconds	
	obj.IntError = [0 0 0]';        % integral error
    obj.KpRamped = 200;                   % internal proportional gain used to ramp during initialisation

	
	for i = 1:2:nargin
		if  strcmp(varargin{i}, 'SamplePeriod'), obj.SamplePeriod = varargin{i+1};
		elseif  strcmp(varargin{i}, 'Quaternion')
			obj.Quaternion = varargin{i+1};
			obj.q = quaternConj(obj.Quaternion);
		elseif  strcmp(varargin{i}, 'Kp'), obj.Kp = varargin{i+1};
		elseif  strcmp(varargin{i}, 'Ki'), obj.Ki = varargin{i+1};
		elseif  strcmp(varargin{i}, 'KpInit'), obj.KpInit = varargin{i+1};
		elseif  strcmp(varargin{i}, 'InitPeriod'), obj.InitPeriod = varargin{i+1};                    
		else error('Invalid argument');
		end
		obj.KpRamped = obj.KpInit;
	end;
end