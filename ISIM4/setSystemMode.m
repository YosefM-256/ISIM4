function setSystemMode(mode)
    mustBeMember(string(mode),["N" "P"]);
    global sMode;
    mustBeNonempty(sMode);
    if mode == "N"
        sMode(1) = 1;
        sMode(2) = 1;
        sMode(4) = 0;
    else
        sMode(1) = 0;
        sMode(2) = 0;
        sMode(4) = 1;
    end
end