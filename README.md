# HDLFPCA
Conduct High-dimensional Longitudinal PCA
# HDLFPCA

## github
```{r}
library(devtools)
install_github("seonjoo/HDLFPCA")
library(HDLFPCA)
```

## Usage
```{r}
set.seed(12345678)
I=100
visit=rpois(I,1)+3
time = unlist(lapply(visit, function(x) scale(c(0,cumsum(rpois(x-1,1)+1)))))
J = sum(visit)
V=2500
phix0 = matrix(0,V,3);phix0[1:50,1]<-.1;phix0[1:50 + 50,2]<-.1;phix0[1:50 + 100,3]<-.1
phix1 = matrix(0,V,3);phix1[1:50+150,1]<-.1;phix1[1:50 + 200,2]<-.1;phix1[1:50 + 250,3]<-.1
phiw = matrix(0,V,3);phiw[1:50+300,1]<-.1;phiw[1:50 + 350,2]<-.1;phiw[1:50 + 400,3]<-.1
xi = t(matrix(rnorm(I*3),ncol=I)*c(8,4,2))*3
zeta = t(matrix(rnorm(J*3),ncol=J)*c(8,4,2))*2
Y = phix0%*% t(xi[rep(1:I, visit),]) + phix1%*% t(time * xi[rep(1:I, visit),]) + phiw %*% t(zeta) + matrix(rnorm(V*J,0,.1),V,J)
library(Lpredict)
re<-hd_lfpca(Y,T=scale(time,center=TRUE,scale=TRUE),J=J,I=I,visit=visit, varthresh=0.95, projectthresh=1,timeadjust=FALSE,figure=TRUE)
cor(phix0, re$phix0)
cor(phix1, re$phix1)
library(gplots)
par(mfrow=c(2,2),mar=rep(0.5,4),bg="gray")
bs=c(-100:100)/1000*1.5
image(phix0, axes=F,col=bluered(200),breaks=bs)
image(re$phix0[,1:3], axes=F,col=bluered(200),breaks=bs)
image(phix1, axes=F,col=bluered(200),breaks=bs)
image(re$phix1[,1:3], axes=F,col=bluered(200),breaks=bs)
