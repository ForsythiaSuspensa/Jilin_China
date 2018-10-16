x=[29,31,35,37,39,42];
A=xlsread('10.7shaixuan data（去重复）.xlsx');
A=A(:,[1:6])
nnum={'1-1','1-3','1-11','1-14','1-17','1-18','1-23','1-28','1-32','1-37','1-46','1-48','1-55','2-2','2-3','2-5','2-7','2-9','2-10','2-28','2-30','2-33','2-36','2-37','2-39','2-41','2-42','2-44','2-46','2-47','2-49','2-50','3-1','3-3','3-4','3-4','3-7','3-8','3-9','3-11','3-13','3-26','3-30','3-33','3-35','3-38','3-43','3-46'};
%k254100i
for i=1:48
    i
    y=A(i,:)
    func = inline('beta(1)./(1+exp(-beta(2).*(log(x)-log(beta(4)))))+beta(3)','beta','x');
    beta0 = [2.2,52.4,2.2,36]';
    [beta,R,J,CovB,MSE,ErrorModelInfo] = nlinfit(x,y,func,beta0);
    %返回残差,R, modelfun的雅可比J, 估计方差-协方差矩阵估计系数CovB,, 
    % 误差项方差的估计 MSE,和一个包含错误模型详细信息的结构, ErrorModelInfo.
    beta
     ys=beta(3)+1/100*beta(1);
    ye=beta(1)*99/100+beta(3);
    ymid=beta(1)/2+beta(3);
     xmid=beta(4);
    xx= 29:0.1:42;
   yy=beta(1)./(1+exp(-beta(2).*(log(xx)-log(beta(4)))))+beta(3);
   syms xxxx;
   f =@(xxxx)beta(1)./(1+exp(-beta(2).*(log(xxxx)-log(beta(4)))))+beta(3)-ye;
   [xe,fval,exitflag] = fzero(f,50);
   f =@(xxxx)beta(1)./(1+exp(-beta(2).*(log(xxxx)-log(beta(4)))))+beta(3)-ys;
   [xs,fval,exitflag] = fzero(f,50);
    xx= 29:0.1:42;
    yy = beta(1)./(1+exp(-beta(2).*(log(xx)-log(beta(4)))))+beta(3);
    yr= beta(1)./(1+exp(-beta(2).*(log(x)-log(beta(4)))))+beta(3);
    R=corrcoef(yr,y)
    R2=R(1,2).^2
    RR(i,1)=R2
    T(i,1)=beta(4);
    MMSE(i,1)=MSE;    
    yys(i,1)=beta(3);
    yye(i,1)=beta(1)+beta(3);
    syms xxx;
    ff(xxx)=beta(1)./(1+exp(-beta(2).*(log(xxx)-log(beta(4)))))+beta(3)
    dy(xxx)=diff(ff(xxx))
    xxx=beta(4);
    sen(i,1)=eval(dy)
    result=[T,yys,yye,sen,RR,MMSE]
     xmid=beta(4);
    ymin=min(min(yy),min(y))
    plot(x,y,'.','markersize',15);
    hold on;
      plot(xmid,ymid,'k.','markersize',15);
    axis([25,45,-inf,inf]) 
    hold on
    plot(xx,yy,'r','linewidth',2);
    %title(nnum(i));
    set(gca,'XTick',[20,30,40]);
    plot([0 xs],[ys ys],'--','color',[0.5451 0.52549 0.5098],'linewidth',2);
    colormap(linspecer);

    plot([0 xe],[ye ye],'--','color',[0.5451 0.52549 0.5098],'linewidth',2);
    plot([0 xmid],[ymid ymid],'--','color',[0.5451 0.52549 0.5098],'linewidth',2)
    plot([xmid xmid],[ymin ymid],'--','color',[0.5451 0.52549 0.5098],'linewidth',2)
    plot([xmid+(ys-ymid)/sen(i,1) xmid+(ye-ymid)/sen(i,1)],[ys ye],'--','color',[0 0 0],'linewidth',1.5)
    plot([xmid xmid+(ye-ymid)/sen(i,1)],[ymid ymid],'--','color',[0 0 0],'linewidth',1.5)
    if xmid<39
        set(gca, 'XTick',[29,31,xmid,39,42] ); % X轴的记号点 
    end;
    if (x>39)&(x<42)
        set(gca, 'XTick',[29,31,35,xmid,42] ); % X轴的记号点 
    end;
    if (x>42)
        set(gca, 'XTick',[29,31,35,42,xmid] ); % X轴的记号点 
    end;
   
    %set(gca, 'XTick',[-3*pi -2*pi -pi 0 pi 2*pi 3*pi], 'XTickLabel', {'-3\pi','-2\pi','-\pi','0','\pi','2\pi','3\pi'});
   % title(nnum(i));
   % text(xmid,ymid-0.1,['  Tm=',num2str(xmid),',sen=',num2str(sen(i,1))])
    xlabel('Temperature(℃)')
    ylabel('Normalized Fluorescence(au)')
    %saveas(gca,num2str(i),'jpg');
%     if i<=21
%         saveas(gca,['singlesvg\',num2str(i)],'svg'); 
%     else saveas(gca,['singlesvg\',num2str(i+3)],'svg'); 
%     end;
    %saveas(gca,nnum(i),'jpg');
    %    saveas(i,['single',])
    hold off
end;