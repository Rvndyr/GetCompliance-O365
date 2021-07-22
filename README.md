
# GetCompliance-O365

A script that allows you get a list of searched jobs ran in O365 admin portal to purge emails within your associated tenant. 

## Pre-reqs
- You will need an enterprise Office 365 tenant to run this 
- You will need Power Shell Exchange online 
- You will need to first run a “Search Query” job in Office 365 admin portal to query the emails you need deleted from exchange (office 365) accounts


## Installation

- Git clone this repo
- In power shell 
- Cd into the downloaded folder
- Run
```bash
 IHTPlaybook.ps1 -email <O365email>
```
    