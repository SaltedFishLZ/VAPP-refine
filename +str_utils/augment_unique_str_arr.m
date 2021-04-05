function out = augment_unique_str_arr(str_arr, str)
    if isempty(str_arr) || any(strcmp(str, str_arr)) == false
       out = [str_arr, {str}];
   else
       out = str_arr;
   end
end
