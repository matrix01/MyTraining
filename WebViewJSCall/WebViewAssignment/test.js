document.getElementById("myBtn").onclick = showMore;
var pageNo = 3;
function hello_out(){
    var str = "";
    for (i = 1*pageNo; i < 10*pageNo; i++){
        str = str + " "+ i;
    }
    window.location = str;
}
function printTable(totalRow, totalCol, str){
    var myArray = new Array();
    myArray = JSON.parse(str);
    myArray.reverse();
    var table = document.getElementById("myTable");
    if(myArray.length > 0){
        arrayIndex = 0;
        var header = table.insertRow(0);
        var rowInTable = table.rows.length;
        if(rowInTable == 0){
            for(col = 0; col<totalCol; col++){
                var cell = header.insertCell(col);
                cell.innerHTML = "<b>Col: " + (col+1) + "</b>";
            }
        }
        for(row = 0; row < totalRow; row++){
            var rowInTable = table.rows.length;
            var newRow = table.insertRow(rowInTable);
            for(col = 0; col<totalCol; col++){
                var cell = newRow.insertCell(col);
                if(myArray[arrayIndex]){
                    cell.innerHTML = myArray[arrayIndex++];
                }
                else {
                    cell.innerHTML = "-";
                }
            }
        }
    }
}
function showMore() {
    pageNo = pageNo + 3;
    hello_out();
}
