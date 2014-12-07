robocopy "%userprofile%\Desktop"                                "\\10.193.2.1\backups\%username%\%username%\desktop" /E /Z /R:3
robocopy "%userprofile%\Documents"                              "\\10.193.2.1\backups\%username%\%username%\documents" /E /Z /R:3
robocopy "%userprofile%\Favorites"                              "\\10.193.2.1\backups\%username%\%username%\Favorites" /E /Z /R:3
robocopy "%userprofile%\APPLICATION DATA\MICROSOFT\SIGNATURES"  "\\10.193.2.1\backups\%username%\%username%\SIGNATURES" /E /Z /R:3
