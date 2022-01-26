function [ dist ] = myDESCRIMINATOR( picture_1, picture_2 )
for i=1:2
    switch i
        case 1
            picture=(rgb2gray(picture_1));
        case 2
            picture=(rgb2gray(picture_2));
    end
[ strings, columns ]=myMATR_TRACKER(picture);
[left right]=myMATR_CUTTER(columns);
[top bottom]=myMATR_CUTTER(strings);
picture_cut=picture(top:bottom,left:right);
knot_mass=myKNOT_PTS(picture_cut);
signature(i,:)=mySIGNATURE(knot_mass);
end
dist=mySPECIAL_DIST(signature(1,:), signature(2,:));
end

