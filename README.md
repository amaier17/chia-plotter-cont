# Chia Plotter service

This repo contains all relevant files for getting the plotter up and running.

Open up the chia-plotter.service file and make sure that you have the
proper paths for the mad max plotter
(https://github.com/madMAx43v3r/chia-plotter.git). Check the -t, -p, -d, and -c
arguments for the plotter tool.

Install the service, enable, and start it:
```
sudo ln -s chia-plotter.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo sytemctl enable chia-plotter
sudo systemctl start chia-plotter
```
