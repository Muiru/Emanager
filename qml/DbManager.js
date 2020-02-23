//create people db
function dbPeopleInit()
{
    var db = LocalStorage.openDatabaseSync("Customer_DB", "", "Stock DB", 1000000)
    try {
        db.transaction(function (tx) {
            tx.executeSql('CREATE TABLE IF NOT EXISTS people_DB (name text,job_title text,creation_date text,salary numeric)')
        })
    } catch (err) {
        console.log("Error creating table in database: " + err)
    };
}

//creates dbStock in
function dbStockInit()
{
    var db = LocalStorage.openDatabaseSync("Customer_DB", "", "Stock DB", 1000000)
    try {
        db.transaction(function (tx) {
            tx.executeSql('CREATE TABLE IF NOT EXISTS stock_DB(idNumber numeric,product_name text,product_price numeric)')
        })
    } catch (err) {
        console.log("Error creating table in database: " + err)
    };
}

//Stock out
function dbStockOutInit()
{
    var db = LocalStorage.openDatabaseSync("Customer_DB", "", "Stock DB", 1000000)
    try {
        db.transaction(function (tx) {
            tx.executeSql('CREATE TABLE IF NOT EXISTS stock_DB_Out(idNumber numeric,product_name text,product_price numeric)')
        })
    } catch (err) {
        console.log("Error creating table in database: " + err)
    };
}

//opening main db
function dbGetHandle()
{
    try {
        var db = LocalStorage.openDatabaseSync("Customer_DB", "",
                                               "Stock DB", 1000000)
    } catch (err) {
        console.log("Error opening database: " + err)
    }
    return db
}

//inserting to people db
function dbPeopleInsert(Pname, Ptitle, Pdate,Psalary)
{
    var db = dbGetHandle()
    var rowid = 0;
    db.transaction(function (tx) {
        tx.executeSql('INSERT INTO people_DB VALUES(?, ?, ?, ?)',
                      [Pname, Ptitle, Pdate,Psalary])
        var result = tx.executeSql('SELECT last_insert_rowid()')
        rowid = result.insertId
    })
    return rowid;
}

//inserting to stock db
function dbStockInsert(Pinumber, Pname, Pprice)
{
    var db = dbGetHandle()
    var rowid = 0;
    db.transaction(function (tx) {
        tx.executeSql('INSERT INTO stock_DB VALUES(?, ?, ?)',
                      [Pinumber, Pname, Pprice])
        var result = tx.executeSql('SELECT last_insert_rowid()')
        rowid = result.insertId
    })
    return rowid;
}

//db stock out insert
function dbStockInsertOut(Pinumber, Pname, Pprice)
{
    var db = dbGetHandle()
    var rowid = 0;
    db.transaction(function (tx) {
        tx.executeSql('INSERT INTO stock_DB_Out VALUES(?, ?, ?)',
                      [Pinumber, Pname, Pprice])
        var result = tx.executeSql('SELECT last_insert_rowid()')
        rowid = result.insertId
    })
    return rowid;
}

//reading people database
function dbReadPeopleAll()
{
    var db = dbGetHandle()
    var results;
    db.transaction(function (tx) {
        results = tx.executeSql('SELECT rowid, name, job_title, creation_date, salary FROM people_DB order by rowid desc')
    })
    return results
}

//reading from stock database
function dbReadStockAll()
{
    var db = dbGetHandle()
    var results;

    db.transaction(function (tx) {
        results = tx.executeSql('SELECT rowid, idNumber, product_name, product_price FROM stock_DB order by rowid desc')
    })
    return results
}

//reading from stock out
function dbReadStockOutAll()
{
    var db = dbGetHandle()
    var results;
    try{
    db.transaction(function (tx) {
        results = tx.executeSql('SELECT rowid, idNumber, product_name, product_price FROM stock_DB_Out order by rowid desc')
    })} catch(err){
        console.log("Error reading in database: " + err)
    };

    return results
}

function dbUpdatePeople(Pdate, Psalary, Pname)
{
    var db = dbGetHandle()
    db.transaction(function (tx) {
        tx.executeSql('update people_DB set creation_date=?,salary=? where name= ?', [Pdate, Psalary, Pname])
    })
}

function dbdeletePeople(Pname)
{
    var db = dbGetHandle()
    db.transaction(function (tx) {
        tx.executeSql('delete from people_DB where name = ?', [Pname])
    })
}

function dbDeleteStock(Pid)
{
    var db = dbGetHandle()
    db.transaction(function (tx) {
        tx.executeSql('delete from stock_DB where idNumber = ?', [Pid])
    })
}

//delete stock out
function dbDeleteStockOut(Pid)
{
    var db = dbGetHandle()
    db.transaction(function (tx) {
        tx.executeSql('delete from stock_DB_Out where idNumber = ?', [Pid])
    })
}

function display(){
    activity.visible = true
    var itemsInd
    Store.dbPeopleInit()

    var it = Store.dbReadPeopleAll();
    console.log(JSON.stringify(it.rows.length))

for(var i = 0; i<it.rows.length;i++){
    dataList.push({
                      type:"People",
                text:it.rows.item(i).name,
                detailText:it.rows.item(i).salary,
                })
   // console.log(JSON.stringify(itemsInd))
    listPage.dataListChanged()
}

Store.dbStockInit()
var stockIn = Store.dbReadStockAll()
console.log("Stock in: "+JSON.stringify(stockIn.rows.length))
    for(var s= 0;s<stockIn.rows.length;s++){
        dataList.push({
                          type:"Stock IN",
                          text:stockIn.rows.item(s).product_name,
                          detailText:stockIn.rows.item(s).product_price,
                          badgeValue:stockIn.rows.item(s).idNumber

                      }
                          )
        listPage.dataListChanged()
    }

    Store.dbStockOutInit()
    var stockOut = Store.dbReadStockOutAll()
    console.log("Stock Out: "+JSON.stringify(stockOut.rows.length))
        for(var o= 0;o<stockOut.rows.length;o++){
            dataList.push({
                              type:"Stock Out",
                              text:stockOut.rows.item(o).product_name,
                              detailText:stockOut.rows.item(o).product_price,
                              badgeValue:stockOut.rows.item(o).idNumber

                          }
                              )
            listPage.dataListChanged()
        }

}
