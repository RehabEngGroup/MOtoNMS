function setLegFP2(hObj,event,def_String)

global LegFP2

val = get(hObj,'Value');

stringChoices=textscan(def_String,'%s', 'Delimiter','|');

LegFP2=stringChoices{1}(val);
