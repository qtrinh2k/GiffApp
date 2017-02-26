<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="WebApp.Index" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Home Page</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>

    <div class="jumbotron text-center">
        <h1>General International Freight Forwarders, Inc.</h1>
    </div>

    <div class="container">
        <div class="row">
            <div class="col-sm-12">
                <nav class="navbar navbar-default">
                    <div class="container-fluid">
                        <ul class="nav navbar-nav">
                            <li class="active"><a href="#">Home</a></li>
                            <li><a href="Booking.aspx">Booking</a></li>
                            <li><a href="Management.apsx">Management</a></li>
                            <li><a href="Accounting.aspx">Accounting</a></li>
                        </ul>
                    </div>
                </nav>

            </div>
            <div class="col-sm-3">
                <div class="panel panel-default">
                    <div class="panel-heading">New Booking</div>
                    <div class="panel-heading">Add Carrier</div>
                </div>
            </div>
            <div class="col-sm-9">
                <form class="form-inline">
                    <div class="form-group">
                        <input type="text" class="form-control" id="search" />
                        <button type="submit" class="btn btn-default">Search</button>
                    </div>
                </form>
            </div>
            <div class="col-sm-9">
                <h2>Recent Transactions</h2>
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>Reference No.</th>
                            <th>BillTo</th>
                            <th>Carrier</th>
                            <td>ModifiedDate</td>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>10000</td>
                            <td>Joe Inc.</td>
                            <td>HM Inc</td>
                            <td>2017-2-24</td>
                        </tr>
                        <tr>
                            <td>10001</td>
                            <td>Trump Inc.</td>
                            <td>HM Inc</td>
                            <td>2017-2-24</td>
                        </tr>
                        <tr>
                            <td>10002</td>
                            <td>Billy Inc.</td>
                            <td>HM Inc</td>
                            <td>2017-2-24</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

</body>
</html>
