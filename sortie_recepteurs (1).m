function [ph1, ph2] = sortie_recepteurs(x, y, I)
   delta_rho = 0.0663; %en radian
  
    deltaphi = 3.8;     %en degrée
    deltarho = deltaphi;
    
    
    abs_I = I(:,3); %on extraie les abscisses de début de chaque bande
    

    
    A = matrice(delta_rho, 5E-3);         %on calcule la matrice A
    theta_n=-rad2deg(atan2(y, I(:,3)-x)); %on calcule les angles
    
    
    bordDroit1 = -90-1.3*deltarho + deltaphi/2;   %constantes de detection de bord
    bordGauche1 = -90+1.3*deltarho + deltaphi/2;  
    bordDroit2 = -90-1.3*deltarho - deltaphi/2;
    bordGauche2 = -90+1.3*deltarho - deltaphi/2;
    
    indPh1 = find(bordGauche1 >= theta_n & theta_n >= bordDroit1);
    indPh2 = find(bordGauche2 >= theta_n & theta_n >= bordDroit2);
    
    %on determine comme ça l'indice pour ph1 et ph2 à partir duquel on voit
    %les bandes
    
    
    theta_n_Ph1 = (theta_n(indPh1)-deltaphi/2+90)/(1.3*deltarho);
    theta_n_Ph1 = (theta_n_Ph1+1)/2*1975+1; 
    
    if length(indPh1) < 1 
        if x < 0 || x > 4000   %on sort du mur
            ph1 = 0;          %on met la vision à 0 arbitrairement (le robot voit rien)
        else                  
            [~, iMax] = max(abs_I(abs_I < x)); %on cherche l'intensité de la bande % tild parce qu'on s'en fiche du max on veut l'indice
            intensite = I(iMax, 2);            %on récupère son niveau de gris
            
            ph1 = intensite; %on donne la couleur la plus forte au capteur
        end
    else
        intensiteGauche = 0; %on lève des exeptions si on est aux extrémités
                             % (en pratique on place le robot au milieu
                             % pour eviter cela
        
        if indPh1(1) > 1 
            intensiteGauche = I(indPh1(1)-1,2); %de même à lautre extremite
        end 
        intensiteDroite = I(indPh1(end),2); 
     
        ph1 = A(1, floor(theta_n_Ph1(1)))*intensiteGauche + A(floor(theta_n_Ph1(end)), 1976)*intensiteDroite;
     
        
        for i=1:length(indPh1)-1 %calcule normal au milieu du mur
            intensite = I(indPh1(i),2); 
            ph1 = ph1 + A(floor(theta_n_Ph1(i)),floor(theta_n_Ph1(i+1)))*intensite; %!
        end
    end
    
    %On répète pour le second capteur
    theta_nPh2 = (theta_n(indPh2)+deltaphi/2+90)/(1.3*deltarho);
    theta_nPh2 = (theta_nPh2+1)/2*1975+1;
    
    if length(indPh2) < 1
        if x < 0 || x > 4000
            ph2 = 0;
        else
            [~, iMax] = max(abs_I(abs_I < x));
            intensite = I(iMax, 2);
            
            ph2 = intensite;
        end
    else
        intensiteGauche = 0;
        
        if indPh2(1) > 1
            intensiteGauche = I(indPh2(1)-1,2);
        end
        
        intensiteDroite = I(indPh2(end),2);
     
        ph2 = A(1, floor(theta_nPh2(1)))*intensiteGauche + A(floor(theta_nPh2(end)), 1976)*intensiteDroite;
        
        for i=1:length(indPh2)-1
            intensite = I(indPh2(i),2);
            ph2 = ph2 + A(floor(theta_nPh2(i)),floor(theta_nPh2(i+1)))*intensite;
        end
    end
end

