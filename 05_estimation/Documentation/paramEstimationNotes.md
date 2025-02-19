# Two parts
* Parameters estimation 
    * we have data
    * we know the model
    * we need to find the parameters
* Model estimation 
    * we have data
    * we do not have the model
    * we need to find both the model and parameters

    
## Param estimation
### Motivating 1d example
<img src = "/Users/asitkumar/Documents/GitHub/asitk/05_estimation/Documentation/sampleModelData.png" width = 400>    
#### Define *best* fit
1. Maximum error $L_\infty$
$$
E_{\infty}(f) = \max_{1 \leq\ k \leq\ n} \lvert f(x_k)-y_k \rvert
$$
2. Average absolute error $L_1$
$$
E_1(f) = \frac{1}{n} \sum_{k=1}^n \lvert f(x_k)-y_k \rvert
$$
3. Root mean square error (rmse) $L_2$   
Commonly known as least square fit
$$
E_2(f) = \sqrt{ \frac{1}{n} \sum_{k=1}^n {\lvert f(x_k)-y_k \rvert}^2}
$$

#### Minimum RMSE method
[Link - Nathan Kutz](https://youtu.be/3hz6Tb1i2FY?si=jSi0BpiRlpKPQTrw)
$$
Ax=b
$$


#### Matlab example