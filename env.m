function I = env()%création de l'environnment
s=0;
p=1;%parcours de I 
while s<4000
    bande=randi([10,100]);
    if s+bande>=3990 % si on dépasse les 4m,ou 4000
        bande=3990-s ; 
    end    
    couleur=randi([0,255]);%nuance de gris
    I(p,1)=bande;
    I(p,2)=couleur;
    s=bande+s; %on incrémente s
    p=p+1;
end
imagesc(I(s,2))
colorbar
colormap grey
end


