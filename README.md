# Multiple Walker Well-Tempered Metadynamics
Author: Shinji Iida

## How to use 
Execute the following commands consecutively:
1. `01_em.sh`
2. `02_get_ref.sh`
3. `03_mw_metad.sh`
4. `04_rest_mw_metad.sh`

> [!NOTE]
> `template_metad.sh` and `template_rst_metad.sh` are used to create a job script for each walker.
> In `03_mw_metad.sh` or `04_rest_mw_metad.sh`, the template is modified for each walker.

> [!warning]
> Be careful when restarting your metadynamics simulations. 
> It would be sensible to check output filfes whenever you restart them.

## Utilities
- `clean.sh`: clean metadynamics outputs.
- `keepfiles.sh`: Creating a directory, the current metadynamics outputs are saved in it.
- `revertfiles.sh`: From the keepfile directory, the metadynamics outputs are reverted.
