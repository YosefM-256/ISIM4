function results = plotVsatIcPNP(beta,Icset,pathsNconsts,simulationVariables)
    arguments                             
        beta                    double      {mustBePositive}
        Icset                   double      {mustBeNonempty, mustBeNegative}
        pathsNconsts            struct
        simulationVariables     struct
    end

    informLog(["starting [Vsat - Ic](PNP) graph for beta=" num2str(beta)]);

    results = {};
    setCRes(0);
    CResNum = 0;
    setDAC1(0);
    setDAC0(2048);
    setEpwr(1);

    for ic = Icset
        Icmsg = tuneToIc(ic);
        if Icmsg ~= "SUCCESS"
            error("TOP BREACH occured while tuning Ic to %d",ic);
        end
        betamsg = tuneToBeta();
        if betamsg ~= "SUCCESS"
            error("TOP BREACH occured while tuning beta to %d",beta);
        end
        results{end+1} = simulate(pathsNconsts,simulationVariables);
    end
    informProgress("[Vsat - Ic](NPN) graph successufully finished");
    results = cell2mat(results);
    
    function result = tuneToIc(ic)
        result = "SUCCESS";
        % the tuning is to Ie because the 'Ie' in the circuit is the Ic of
        % a PNP transistor
        msg = tuneBy("Ie","DAC0",ic,"inverse",pathsNconsts,simulationVariables);
        if msg == "TOP BREACH" && CResNum == 0  
            informLog(['TOP BREACH occured while trying to tune DAC0 for Ic=' num2str(ic) ...
                '.Switching to Rc=10 Ohm']);
            setCRes(1);
            CResNum = 1;
            msg = tuneToIc(ic);
        end
        if msg == "TOP BREACH" && CResNum == 1
            informLog(['the TOP BREACH for Ic=' num2str(ic) ' repeated when Rc=10 Ohm']);
            result = "TOP BREACH";
            return;
        end
    end
        
    function result = tuneToBeta
        result = "SUCCESS";
        msg = tuneBy("beta PNP","DAC1",beta,"direct",pathsNconsts,simulationVariables);
        if msg ~= "SUCCESS" 
            informLog(["TOP BREACH occured while tuning beta to" num2str(beta)]);
            result = msg;
            return;
        end           
    end
end