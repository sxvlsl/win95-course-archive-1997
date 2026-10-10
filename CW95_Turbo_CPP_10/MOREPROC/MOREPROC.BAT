@ECHO OFF

mkdir %2\PFM

COPY %1\system\SY______.PFM    %2\PFM\SY______.PFM
COPY %1\system\ZD______.PFM    %2\PFM\ZD______.PFM
COPY %1\system\ZX______.PFM    %2\PFM\ZX______.PFM
COPY %1\system\ZX______.MMM    %2\PFM\ZX______.MMM
COPY %1\system\ZY______.PFM    %2\PFM\ZY______.PFM
COPY %1\system\ZY______.MMM    %2\PFM\ZY______.MMM

COPY %1\system\SY______.PFB    %2\SY______.PFB
COPY %1\system\ZD______.PFB    %2\ZD______.PFB
COPY %1\system\ZX______.PFB    %2\ZX______.PFB
COPY %1\system\ZY______.PFB    %2\ZY______.PFB


COPY %1\system\ATMSYS.DRV     %2\system\ATMSYS.DRV
COPY %1\system\ATM32.DLL      %2\system\ATM32.DLL
