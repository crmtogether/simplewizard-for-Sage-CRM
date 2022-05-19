
var TableName = Param('TABLE NAME');

CreateTable(TableName,'','',false,false,false,false);
var TableId10259 = AddCustom_Tables(TableName,'','',TableName,'','','','','',false);
AddCustom_Data('Custom_Tables','Bord','Bord_TableId','Bord_TableId,Bord_PersonUpdateFieldName,Bord_CompanyUpdateFieldName,Bord_AssignedUserId,Bord_CEOptions,Bord_SLAIdField,Bord_SDataAccess', TableId10259+',"","","","","",""','1');

ObjectName='User';
ObjectType='TabGroup';
EntityName='System';
AllowDelete=false;
var CObjId10390 = AddScreenObject();

ObjectName=TableName+'UserGrid';
ObjectType='List';
EntityName=TableName;
TargetTable=TableName;
var CObjId10765 = AddScreenObject();

ObjectName=TableName+'Screen';
ObjectType='Screen';
EntityName=TableName;
Properties=TableName+'Screen';
var CObjId10766 = AddScreenObject();

//add to users my crm
var TabsId10796 = AddCustom_Tabs(0,0,18,'User',TableName,'customfile',TableName+'/mycrm.asp','','',0,'',false,0);

FamilyType='Tags';
Family='Screens';
Code=TableName+'Screen';
Captions['US']=TableName+'Screen';
AddCaption();

FamilyType='Tags';
Family='Tables';
Code=TableName;
AddCaption();

var DLLDir = GetDLLDir();
var InstallDir = GetInstallDir();
var componentDir = InstallDir + '\\inf\\mainEntityWizard\\';
var customPagesDir = componentDir + '\\CustomPages\\';
var entityDir = DLLDir + '\\CustomPages\\' + TableName + '\\';

CreateNewDir(GetDLLDir() + '\\CustomPages\\' + TableName);
CopyASPTo('crmwizard.js','custompages\\'+TableName+'\\crmwizard.js');
CopyASPTo('crmwizardnolang.js','custompages\\'+TableName+'\\crmwizardnolang.js');
CopyASPTo('mycrm.asp','custompages\\'+TableName+'\\mycrm.asp');
CopyASPTo('summary.asp','custompages\\'+TableName+'\\summary.asp');

SearchAndReplaceInCustomFile(entityDir + 'mycrm.asp', '**&TableName&**', TableName);
SearchAndReplaceInCustomFile(entityDir + 'summary.asp', '**&TableName&**', TableName);