# Jupyter LAN setup
this was tested only for ubuntu

```sh
alias jnn='jupyter notebook --ip "$(hostname -I)" --port 8888'
```


also set up password  
in order to not to deal   
with tokens sharing  
(run once)

```sh
jupyter notebook password
```
