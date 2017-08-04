function obj = UpdateIMU(obj, Gyroscope, Accelerometer)

	% Normalise accelerometer measurement
	if(norm(Accelerometer) == 0)                                          	% handle NaN
		warning(0, 'Accelerometer magnitude is zero.  Algorithm update aborted.');
		return;
	else
		Accelerometer = Accelerometer / norm(Accelerometer);                % normalise measurement
	end

	% Compute error between estimated and measured direction of gravity
	v = [2*(obj.q(2)*obj.q(4) - obj.q(1)*obj.q(3))
		2*(obj.q(1)*obj.q(2) + obj.q(3)*obj.q(4))
		obj.q(1)^2 - obj.q(2)^2 - obj.q(3)^2 + obj.q(4)^2];               	% estimated direction of gravity
	error = cross(v, Accelerometer');
	
%            	% Compute ramped Kp value used during init period
%             if(obj.KpRamped > obj.Kp)
%                 obj.IntError = [0 0 0]';
%                 obj.KpRamped = obj.KpRamped - (obj.KpInit - obj.Kp) / (obj.InitPeriod / obj.SamplePeriod);
%             else                                                                    % init period complete
%                 obj.KpRamped = obj.Kp;
		obj.IntError = obj.IntError + error;                                % compute integral feedback terms (only outside of init period)
%             end

	% Apply feedback terms
	Ref = Gyroscope - (obj.Kp*error + obj.Ki*obj.IntError)';

	% Compute rate of change of quaternion
	pDot = 0.5 * quaternProd(obj.q, [0 Ref(1) Ref(2) Ref(3)]);          % compute rate of change of quaternion
	obj.q = obj.q + pDot * obj.SamplePeriod;                                % integrate rate of change of quaternion
	obj.q = obj.q / norm(obj.q);                                            % normalise quaternion

	% Store conjugate
	obj.Quaternion = quaternConj(obj.q);
end