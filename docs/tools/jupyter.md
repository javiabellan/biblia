# Jupyter


## Start jupyter when conected with SSH

```bash
jupyter notebook --no-browser
```

## [Jupyter extensions](https://jupyter-contrib-nbextensions.readthedocs.io/en/latest/install.html)

1. `sudo pip install jupyter_contrib_nbextensions`
2. `sudo jupyter contrib nbextension install`




# Jupyter Lab

## On the Remote Server
1. Get the IP address of your server: `$ hostname -I  # 192.168.0.120`
2. Configure Jupyter Lab Password
   - `$ jupyter notebook --generate-config`
   - `$ jupyter notebook password`
   - `Enter password:  ****`
   - `Verify password: ****`
3. Starting Jupyter Lab `$ jupyter-lab --ip 0.0.0.0 --port 8888 --no-browser`

## On client
1. Navigate to `http://<your-routers-public-ip>:8888`
2. Enter password