function [stem, ring, protrusion, freeBase, freeEnergy, GC, len] = seq2num(seq)
[structure, freeEnergy] = rnafold(seq);
% seq = '((((((....(((.......)))...))))))';
% flag = 0;
ring = 0;
ringStart = 0;
ringEnd = 0;
ringFlag = 0;
stem = 0;
stemLeft = 0;
stemRight = 0;
stemStart = 0;
stemEnd = 0;
stemFlag = 0;
protrusion = 0;
freeBase = 0;
for index = 1:length(structure)
%     计算茎长起始和结束位点
    if structure(index) == '('
        stemLeft = stemLeft + 1;
    end
    if structure(index) == ')'
        stemRight = stemRight +1;
    end
    if structure(index) == '(' && stemFlag == 0
        stemStart = index;
        stemFlag = 1;
    end
    if structure(index) == '(' && stemFlag == 1
        stemEnd = index;
        ringStart = index + 1;  %计算环长起始位点
    end
    %计算环长结束位点
    if structure(index) == ')' && ringFlag == 0
        ringEnd = index - 1;
        ringFlag = 1;
    end
%     计算自由碱基数量
    if structure(index) == '.'
        freeBase = freeBase + 1;
    end
end
% stem = stemEnd - stemStart + 1;
if stemLeft > stemRight
    stem = stemLeft;
else
    stem = stemRight;
end
ring = ringEnd - ringStart + 1;
% 判断有无突起
if stemLeft ~= stemRight || (stemEnd-stemStart+1>stem)
    protrusion = 1;
end
% G/C
au=0;
gc=0;
for i = 1:length(seq)
    if seq(i)=='A' || seq(i)=='U'
        au = au+1;
    end
    if seq(i)=='G' || seq(i)=='C'
        gc = gc+1;
    end
end
GC = au/gc;
len = length(seq);