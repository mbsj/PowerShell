function get-GroupMembership($UserName,$GroupName){	
    $userFilter = "(&(objectCategory=User)(samAccountName=$UserName))"
    $userDirSearcher = New-Object System.DirectoryServices.DirectorySearcher
    $userDirSearcher.Filter = $userFilter
    $userPath = $userDirSearcher.FindOne()
    $userObject = $userPath.GetDirectoryEntry()
    $userDN = $userObject.distinguishedName
    $userADSI = [ADSI]"LDAP://$userDN"
		
    $groupFilter = "(&(objectCategory=group)(name=$GroupName))"
    $groupDirSearcher = New-Object System.DirectoryServices.DirectorySearcher
    $groupDirSearcher.Filter = $groupFilter
    $groupPath = $groupDirSearcher.FindOne()
	
    If ($groupPath -ne $Null){	
        $groupObject = $groupPath.GetDirectoryEntry()
        $groupDN = $groupObject.distinguishedName

        if ($userADSI.memberOf.Value -eq $groupDN){
            return 1
        }else{
            return 0
        }
    }else{
        return 0
    }
}

$strName = $env:username

$groups = @{}
$groups["SG - GPO - PrinterMaps - ARD - 1sal"] = @("\\sardapp01\ARD_1sal_SH")
$groups["SG - GPO - PrinterMaps - ARD - Alle"] = @("\\sardapp01\ARD_1sal_SH", "\\sardapp01\ARD_1sal_Farve", "\\sardapp01\ARD_Kopirum_SH", "\\sardapp01\ARD_Kopirum_Farve")
$groups["SG - GPO - PrinterMaps - ARD - HR"] = @("\\sardapp01\ARD_KOPIRUM_HR", "\\sardapp01\ARD_KOPIRUM_HR_FARVE")
$groups["SG - GPO - PrinterMaps - ARD - Kopirum"] = @("\\sardapp01\ARD_Kopirum_SH", "\\sardapp01\ARD_Kopirum_Farve")
$groups["SG - GPO - PrinterMaps - ARD - Labels"] = @("\\sardapp01\ARD_LAGER_ECPC4_KUNDEORDRE", "\\sardapp01\ARD_LAGER_ECPC4_SMA_LABELS", "\\sardapp01\ARD_LAGER_ECPC4_STORE_LABELS")
$groups["SG - GPO - PrinterMaps - ARD - Lager"] = @("\\sardapp01\ARD_Lager_SH", "\\sardapp01\ARD_Lager_Farve")
$groups["SG - GPO - PrinterMaps - ARD - Okonomi"] = @("\\sardapp01\ARD_KOPIRUM_OKONOMI", "\\sardapp01\ARD_KOPIRUM_OKONOMI_FARVE")
$groups["SG - GPO - PrinterMaps - ARD - Plotters"] = @("\\sardapp01\ARD_KOPIRUM_CW300")
$groups["SG - GPO - PrinterMaps - ARD - PTA"] = @("\\sardapp01\ARD_PTA_SH", "\\sardapp01\ARD_PTA_Farve")

$groups["SG - GPO - PrinterMaps - ESB - 1sal"] = @("\\sesbprint01\ESB_1SAL_SH", "\\sesbprint01\ESB_1SAL_COLOR")
$groups["SG - GPO - PrinterMaps - ESB - Kaelder"] = @("\\sesbprint01\ESB_KAELDER_SH", "\\sesbprint01\ESB_KAELDER_COLOR")
$groups["SG - GPO - PrinterMaps - ESB - Lager"] = @("\\sesbprint01\ESB_LAGER_ZebraS4M", "\\sesbprint01\ESB_LAGER_COLOR", "\\sesbprint01\ESB_LAGER_SH")
$groups["SG - GPO - PrinterMaps - ESB - Montage"] = @("\\sesbprint01\ESB_MONTAGE_COLOR", "\\sesbprint01\ESB_MONTAGE_SH")
$groups["SG - GPO - PrinterMaps - ESB - Okonomi"] = @("\\sesbprint01\ESB_OKONOMI_SH", "\\sesbprint01\ESB_1SAL_SH")
$groups["SG - GPO - PrinterMaps - ESB - Plotters"] = @("\\sesbprint01\ESB_KAELDER_OCE_TDS700")
$groups["SG - GPO - PrinterMaps - ESB - PTA"] = @("\\sesbprint01\ESB_PTA_SatoCL412e", "\\sesbprint01\ESB_PTA_COLOR", "\\sesbprint01\ESB_PTA_SH")
$groups["SG - GPO - PrinterMaps - ESB - Stuen"] = @("\\sesbprint01\ESB_OKONOMI_COLOR", "\\sesbprint01\ESB_STUEN_COLOR", "\\sesbprint01\ESB_STUEN_SH")
$groups["SG - GPO - PrinterMaps - ESB - VFkontor"] = @("\\sesbprint01\ESB_VKF_SH")

$groups["SG - GPO - PrinterMaps - PIL - Alle"] = @("\\spildc01\PIL_WAREHOUSE_BW", "\\spildc01\PIL_OFFICE_KM_COLOR", "\\spildc01\PIL_OFFICE_KM_BW")
$groups["SG - GPO - PrinterMaps - PIL - Labels"] = @("\\spildc01\PIL_Labels_PrintJet", "\\spildc01\PIL_Labels_2015", "\\spildc01\PIL_Labels_THMPlus", "\\spildc01\PIL_Office_PrintJet")
$groups["SG - GPO - PrinterMaps - PIL - OCE"] = @("\\spildc01\PIL_OCE_TDS400")
$groups["SG - GPO - PrinterMaps - PIL - Office"] = @("\\spildc01\PIL_PROD_OFFICE_BW", "\\spildc01\PIL_OFFICE_KM_BW")
$groups["SG - GPO - PrinterMaps - PIL - ProdOffice"] = @("\\spildc01\PIL_PROD_OFFICE_BW", "\\spildc01\PIL_PROD_OFFICE_COLOR")
$groups["SG - GPO - PrinterMaps - PIL - Warehouse"] = @("\\spildc01\PIL_WAREHOUSE_BW")

$groups.Keys | ForEach-Object {
    $group = $_ 

    $result = get-groupMembership $strName $group
    if ($result -eq '1') {
        $groups[$group] | ForEach-Object {
            $printer = $_
            Add-Printer -ConnectionName $printer
        }
    }
}