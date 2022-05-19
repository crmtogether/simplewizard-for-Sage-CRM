<!-- #include file ="crmwizard.js" -->
<%

var _Table = "**&TableName&**";
var _gridName=_Table+"UserGrid";

var qscreenobject=CRM.CreateQueryObj("select * from Custom_ScreenObjects where CObj_Name='"+_gridName+"'");
qscreenobject.SelectSQL();

var sURL=new String( Request.ServerVariables("URL")() + "?" + Request.QueryString);

var clsql="select * from Custom_Lists where GriP_GridName='"+_gridName+"'";
var qclsql=CRM.CreateQueryObj(clsql);
qclsql.SelectSQL();
if (qclsql.eof){

  var q = CRM.CreateQueryObj("select top 1 * from "+_Table);
  q.SelectSQL();

  eQueryFields = new Enumerator(q);
  icol=0;
  var idfield="";
  while (!eQueryFields.atEnd()) {
    icol++;
    var fieldx=eQueryFields.item();
    fieldx=fieldx.toLowerCase();
    fieldx=fieldx.replace(/\s/g, "");
	//add to list
	var nf=CRM.CreateRecord("Custom_Lists");
	nf("GriP_GridName")=_gridName;
	nf("GriP_Order")=icol;
	nf("GriP_ColName")=fieldx;
	nf("GriP_ScreenObjectsIDFK")=qscreenobject("CObj_TableId");
	if (icol==1)
	{
		nf("GriP_Jump")="custom";
		nf("GriP_CustomAction")=_Table+"/summary.asp";
		nf("GriP_CustomIDField")=fieldx;
	}	
	nf.SaveChanges();
    eQueryFields.moveNext();
  }
  
}

List=CRM.GetBlock(_Table+"UserGrid");
List.prevURL=sURL;

container = CRM.GetBlock('container');
container.AddBlock(List);

NewButton = CRM.GetBlock("content");

container.DisplayButton(Button_Default) = false;

CRM.AddContent(container.Execute(""));

Response.Write(CRM.GetPage('User'));

%>






