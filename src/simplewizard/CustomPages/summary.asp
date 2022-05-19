<!-- #include file ="crmwizard.js" -->
<%
var _Table = "**&TableName&**";
var _screenName=_Table+"Screen";

var qscreenobject=CRM.CreateQueryObj("select * from Custom_ScreenObjects where CObj_Name='"+_screenName+"'");
qscreenobject.SelectSQL();

var qtable=CRM.CreateQueryObj("select * from Custom_Tables where Bord_Name='"+_Table+"'");
qtable.SelectSQL();
var _idfield=qtable("Bord_IdField");
if (!Defined(_idfield)||(_idfield==""))
{
  var q = CRM.CreateQueryObj("select top 1 * from "+_Table);
  q.SelectSQL();
  if (!q.eof)
  {
	eQueryFields = new Enumerator(q);
	icol=0;
	if (!eQueryFields.atEnd()) {
		var fieldx=eQueryFields.item();
		_idfield=fieldx.toLowerCase();
	}
  }
}

var clsql="select * from Custom_screens where SeaP_SearchBoxName='"+_screenName+"'";
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
	var nf=CRM.CreateRecord("Custom_screens");	
	nf("SeaP_SearchBoxName")=_screenName;
	nf("SeaP_Order")=icol;
	nf("SeaP_ColName")=fieldx;
	nf("SeaP_Newline")="1";
	nf("SeaP_ScreenObjectsIDFK")=qscreenobject("CObj_TableId");;
	nf.SaveChanges();
    eQueryFields.moveNext();
  } 
  CRM.AddContent("Refresh metadata");  
  Response.Write(CRM.GetPage());  
  Response.End();
}

Container=CRM.GetBlock("container");
Entry=CRM.GetBlock(_screenName);
Entry.Title=CRM.GetTrans("TabNames",_Table);
Container.AddBlock(Entry);
Container.DisplayButton(1)=false;
content=CRM.GetBlock("content");
Container.AddBlock(content);

var Id = new String(Request.Querystring(_idfield));
if (Id.toString() == 'undefined') {
  Id = new String(Request.Querystring("Key58"));
}

var UseId = 0;

if (Id.indexOf(',') > 0) {
   var Idarr = Id.split(",");
   UseId = Idarr[0];
}
else if (Id != '') 
  UseId = Id;

if (UseId != 0) {

  var Idarr = Id.split(",");

  record = CRM.FindRecord(_Table, _idfield+"="+UseId);

  Container.DisplayButton(Button_Continue) = true;
	
  CRM.AddContent(Container.Execute(record));
	 
  Response.Write(CRM.GetPage());
}

%>
