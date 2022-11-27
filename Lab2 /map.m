function dmap = map(img_l, img_r)
% Function to calculate and return the disparity map

[x, y] = size(img_l); % Both images have same size

dmap = ones(x - 10, y - 10);

for i = 6 : x - 5 % 6: 1 + floor(11/2)
    for j = 6 : y - 5 % 5: floor(11/2)
        cr = img_l(i - 5 : i + 5, j - 5 : j + 5);
        cl = rot90(cr, 2);
        minimum = j;
        difference = inf;

        % searching for similar pattern in the second image
        for k = max(6 , j -14) : j
            T = img_r(i - 5 : i + 5, k - 5 : k + 5);
            cr = rot90(T, 2);
            cv1 = conv2(T, cr);
            cv2 = conv2(T, cl);
            ssd = cv1(11, 11) - 2 * cv2(11, 11);

            if ssd < difference
                difference = ssd;
                minimum = k;
            end
        end
        dmap(i - 5, j - 5) = j - minimum;
    end
end

end