//массивы
function isArray(v){
	//проверка: массив или нет
	try{ for(var i in v) return true; }catch(ex){} return false;
}
function len(v){
	//если v - массив, то возвращает его длину, иначе - 0 
	try{ n = 0; for(var i in v) n++; return n;
	}catch(ex){ return 0;
	}
}
//преобразование строк
function inTag_(tag, content, attributes){
	//заключить текст в таг с атрибутами
	//все аргументы - строки
	return "<" + tag + " " + attributes + ((content.length>0)?(">" + content + "</" + tag + ">"): "/>");
}
function inTag(tag, content, attributes){
	//заключить текст в таги с атрибутами
	return inTag_(tag+"", ((content==null)?"":(content+"")), ((attributes==null)?"":(attributes+"")));
}

function nvlStr(v, nullValue){
	//если пустая строка, заменить на nullValue
	var str = v+"";
	return (str=="")? nullValue: str;
}

function escapeHtml(v, nullValue){
	//преобразовать строку в вид HTML
	//если пустая строка, заменить на nullValue (по-умолчанию - "&nbsp;")
	var str = ""+v;
	return (str=="")? 
		((nullValue==null)?"&nbsp;":(nullValue+"")):
		str
		.replace(/&/g, "&amp;").replace(/"/g, "&quot;").replace(/'/g, "&apos;")
		.replace(/</g, "&lt;").replace(/>/g, "&gt;")
		.replace(/ /g, "&nbsp;").replace(/\t/g, "&nbsp;&nbsp;&nbsp;&nbsp;")
		.replace(/(\r\n|\r|\n)/g, "<br>$1");
}
function escapeRegExp(str){
	//преобразовать строку, чтобы 
	//new RegExp(escapeRegExp(str) ) - регулярное выражение для поиска строки str
	return (str+"")
		.replace(/\\/g,"\\\\").replace(/\//g,"\\/")
		.replace(/\$/g,"\\$").replace(/\*/g,"\\*").replace(/\+/g,"\\+")
		.replace(/\./g,"\\.").replace(/\^/g,"\\^").replace(/\(/g,"\\(").replace(/\)/g,"\\)")
		.replace(/\[/g,"\\[").replace(/\]/g,"\\]").replace(/\|/g,"\\|")
		.replace(/\r/g,"\\r").replace(/\n/g,"\\n");
}
function escapeSqlStr(str){
	//строка SQL-запроса, представляющая строку str
	return "'" + 
		(str+"").replace(/\'/g, "''")
		.replace(/\xA/g, "'||CHR(10)||'")
		.replace(/\xD/g, "'||CHR(13)||'")
		.replace(/--/g, "-'||'-")
		.replace(/\/\*/g, "/'||'*")
		.replace(/\*\//g, "*'||'/") + 
		"'";
}
function escapeJavaStr(str){
	//строка JAVA-кода, представляющая строку str
	return "\"" + 
		(str+"").replace(/\\/g, "\\\\")
		.replace(/\n/g, "\\n")
		.replace(/\r/g, "'\\r'")
		.replace(/\t/g, "\\t")
		.replace(/"/g, "\\\"")
		"\"";
}
//представление данных в виде HTML-текста
function outputVar_(v, doEscapeHtml, cutElemLength){
	// html-таблица, отображающая содержимое переменной
	// удобно для просмотра массивов
	// Если doEscapeHtml=true, то простые значения эскейпятся для корректного отображения в HTML
	var txt = "";
	try{
		vLen = len(v);
		if(vLen > 0){
			txt = "<table border=1 cellspacing=0 cellpadding=0><tr><td>";
			txt += "<table border=0><tr><td colspan=3>{(" + vLen + ")</td></tr>\r";
			for(var i in v){
				txt += "<tr><td valign=top>" + i + "</td><td valign=top>:</td><td>\r" + outputVar_(v[i], doEscapeHtml, cutElemLength) + "</td></tr>\r";
			}
			txt += "<tr><td colspan=3>}</td></tr></table>\r";
			txt += "</td></tr></table>\r";
		}else if(doEscapeHtml){
			if(cutElemLength==null){
				txt += escapeHtml(v);
			}else{
				var vv = (v+"");
				if(vv.length > cutElemLength){
					vv = vv.substring(0, cutElemLength) + "...";
				}
				txt += escapeHtml(vv);
			}
		}else{
			if(cutElemLength==null){
				txt += v; 
			}else{
				var vv = (v+"");
				if(vv.length > cutElemLength){
					vv = vv.substring(0, cutElemLength) + "...";
				}
				txt += vv;
			}
		}
		return "<table border=1 cellspacing=0 cellpadding=0><tr><td>" + ((txt=="")?"&nbsp;":txt) + "</td></tr></table>\r"; 
	}catch(ex){
		return "<table border=2 cellspacing=0 cellpadding=0 border-color=red><tr><td>Error:</td><td>" + ex + "</td></tr></table>\r"
	}
}
function outputVar(v){
	return outputVar_(v, false, null);
}
function outputVarHtml(v){
	return outputVar_(v, true, null);
}

function framedStr(v){
	// отображение строки отладочной информации в рамке
	return "<table border=1 bordercolor=blue><tr><td><div style=\"color:orange\">" + v + "</div></td></tr></table><br/>\r";
}
function framed(v){
	// отображение отладочной информации в рамке
	return "<table border=1 bordercolor=blue><tr><td><div style=\"color:orange\">" + outputVar(v) + "</div></td></tr></table><br/>\r";
}

function outputResultSetHtml(pResultSet, maxRowCount){
	//отображение ResultSet в виде Hml-таблицы
	var result = "<table border=1>";
	try{
		var md = pResultSet.getMetaData();
		var cnt; cnt = md.getColumnCount();
		var v = md.getColumnHeaders();
		var rCnt = pResultSet.getRowCount();
		var rCntVis = rCnt;
		try{
			if((maxRowCount>=0)&&(rCnt>maxRowCount)){
				rCntVis = maxRowCount;
			}
		}catch(ex){
		}
		{	//два заголовка: номер столбца (с нулевого) и название столбца
			var str_header0 = "<tr><td><i>&lt;<b>"+cnt+"</b>&gt;</i></td>";
			var str_header = "<tr><td><i><b>"+rCntVis+"</b>/ [<b>"+rCnt+"</b>]</i></td>";
			for(var c = 0; c < cnt; c++) { 
				str_header0 += "<td><i>";
				str_header += "<td><b>";
				try{
					str_header0 += escapeHtml("<" + (c+1) + ">");
				}catch(ex){
					str_header0 += framedStr("ERROR: "+escapeHtml(ex.message));
				}
				try{
					str_header += escapeHtml(v[0][c+0]);
				}catch(ex){
					str_header += framedStr("ERROR: "+escapeHtml(ex.message));
				}
				str_header0 += "</i></td>";
				str_header += "</b></td>";
			}
			str_header0 += "</tr>";
			str_header += "</tr>";
			result += str_header0;
			result += str_header;
		}
		//содержимое
		for(var r = 0; r < rCntVis; r++){
			result += "<tr><td>[<i>"+(r+1)+"</i>]</td>";
			for(var c = 0; c < cnt; c++){
				result += "<td>";
				try{
					result += escapeHtml(pResultSet.getValueAt(r, c));
				}catch(ex){
					result += framedStr("ERROR: "+escapeHtml(ex.message));
				}
				result += "</td>";
			}
			result += "</tr>";
		}
		//result += "<tr><td colspan="+(cnt+1)+"><i>RowCount = <b>"+rCnt+"</b></i></td></tr>";
	}catch(ex){
		result += "<tr><td>" + framedStr("ERROR: "+escapeHtml(ex.message)) + "</td></tr>";
	}
	result += "</table>";
	return result;
}

