function result = face_classification(D, img, alp, atoms_per_class)

    e = [];
    n = norm(alp);
    for i = 1 : atoms_per_class : (length(alp) - atoms_per_class + 1)
        d = D(:, i : i + atoms_per_class - 1);
        x = alp(i : i + atoms_per_class - 1, :);
        y = d * x;
        e = [e norm(x)/n]; 
    end
    [C, I] = max(e);
    result = I;
end