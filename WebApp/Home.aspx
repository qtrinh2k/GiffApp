<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="WebApp.Home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
   <meta charset="utf-8"/>
   <meta name="viewport" content="width=device-width, initial-scale=1">
   <link rel="stylesheet"  
href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
   <link rel="stylesheet"
href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap-theme.min.css">
    <script
       src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js">
    </script>
</head>
<body>
    <form id="form1" runat="server">

<div class="container-fluid">
    <h1>Time Entry</h1>
 
    <div class="row">
        <div class="col-sm-4" >
            <label for="Username">Username</label>
            <input id="Username" type="text" class="form-control"/>
        </div>
        <div class="col-sm-4" >
            <label for="Start">Start</label>
            <input id="Start" type="text" class="form-control"/>
        </div>
    </div>
    <br/>
    <div class="row">
        <div class="col-sm-4" >
            <label for="Client">Client</label>
            <input id="Client" type="text" class="form-control"/>
        </div>
        <div class="col-sm-4" >
            <label for="DurationHours">Duration (Hours)</label>
            <input id="DurationHours" type="text" class="form-control"/>
        </div>
    </div>
    <br/>
    <div class="row">
        <div class="col-sm-4" >
            <label for="Category">Category</label>
            <select id="Category" class="form-control">
                <option>Meeting</option>
                <option>Administration</option>
                <option>Analysis/Design</option>
                <option>Development</option>
                <option>Testing</option>
            </select>
        </div>
        <div class="col-sm-4" >
            <label for="DurationMinutes">Duration (Minutes)</label>
            <input id="DurationMinutes" type="text" class="form-control"/>
        </div>
    </div>
    <br/>
    <div class="row">
        <div class="col-sm-8" >
            <label for="Notes">Notes</label>
            <textarea id="Notes" rows="5" class="form-control"></textarea>
        </div>
    </div>
    <br/>
    <div class="row">
        <div class="col-sm-8" >
            <button type="button" class="btn btn-default btn-lg">
                <span class="glyphicon glyphicon-send" aria-hidden="true"></span>
                Submit
            </button>
        </div>
    </div>   
</div>    

    </form>
</body>
</html>
