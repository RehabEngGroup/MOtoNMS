function setLegFP1(hObj,event,def_String)

global LegFP1

val = get(hObj,'Value');

stringChoices=textscan(def_String,'%s', 'Delimiter','|');

LegFP1=stringChoices{1}(val);



