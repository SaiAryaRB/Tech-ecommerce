import React, { useState } from 'react';
import './ReportGeneration.css';
import 'bootstrap/dist/css/bootstrap.min.css';
import { Table, Dropdown } from 'react-bootstrap';
import { jsPDF } from 'jspdf';  // Import jsPDF
import 'jspdf-autotable'; // Import the autoTable plugin

const ReportGeneration = () => {
  const [reportData, setReportData] = useState([]);
  const [reportType, setReportType] = useState('');
  const [startDate, setStartDate] = useState('');
  const [endDate, setEndDate] = useState('');

  // List of reports that require date filters
  const dateFilteredReports = [
    'AllProducts', 'TopSelling', 'WorstSelling', 'BestReviews', 'WorstReviews',
    'AllCategories', 'AllSubcategories', 'TopSellingCategories', 'TopSellingSubcategories',
    'AllSales', 'BestSales', 'DemographicSales', 'SalesByPaymentMethod', 'SalesSummary'
  ];

  const generateReport = async (type) => {
    setReportType(type);
    try {
      let url = '';

      if (type === 'CustomerDemographic' || type === 'TopCustomersByAmount' || type === 'FrequentCustomers' || type === 'AllCustomers' || type === 'InactiveCustomers') {
        url = `http://localhost:3000/api/reports/customer/${type}`;
      } else if (dateFilteredReports.includes(type)) {
        url = `http://localhost:3000/api/reports/${type.includes('Category') ? 'category' : 'product'}/${type}?startDate=${startDate}&endDate=${endDate}`;
      } else {
        url = `http://localhost:3000/api/reports/sales/${type}?startDate=${startDate}&endDate=${endDate}`;
      }

      const response = await fetch(url);
      const data = await response.json();
      setReportData(data);
    } catch (error) {
      console.error('Error generating report:', error);
    }
  };

  const exportToCSV = () => {
    if (reportData.length === 0) {
      alert('No data to export!');
      return;
    }

    const headers = Object.keys(reportData[0]).join(','); // CSV headers
    const rows = reportData.map((row) => Object.values(row).join(',')); // CSV rows

    const csvContent = [headers, ...rows].join('\n'); // Join headers and rows
    const blob = new Blob([csvContent], { type: 'text/csv' }); // Create a Blob for the CSV content
    const url = window.URL.createObjectURL(blob); // Create URL for the Blob

    const a = document.createElement('a'); // Create an anchor element
    a.href = url;
    a.download = `${reportType}.csv`; // Set download filename
    a.click(); // Trigger the download
  };

  const exportToPDF = () => {
    if (reportData.length === 0) {
      alert('No data to export!');
      return;
    }

    const doc = new jsPDF();
    doc.text(`Report Type: ${reportType.charAt(0).toUpperCase() + reportType.slice(1)}`, 10, 10); // Add a title

    const headers = [Object.keys(reportData[0])];
    const rows = reportData.map((row) => Object.values(row));

    // Add table to the PDF
    doc.autoTable({
      head: headers,
      body: rows,
      startY: 20, // Position below the title
    });

    doc.save(`${reportType}.pdf`); // Save the PDF
  };

  return (
    <div className="container">
      <h1 className="text-center my-4">Admin Report Generation</h1>

      {/* Conditional rendering of date filters */}
      {dateFilteredReports.includes(reportType) && (
        <div className="d-flex justify-content-center my-4">
          <input
            type="date"
            name="startDate"
            value={startDate}
            onChange={(e) => setStartDate(e.target.value)}
            className="mx-2"
          />
          <input
            type="date"
            name="endDate"
            value={endDate}
            onChange={(e) => setEndDate(e.target.value)}
            className="mx-2"
          />
          <button className="btn btn-secondary mx-2" onClick={() => generateReport(reportType)}>
            Apply Filters
          </button>
        </div>
      )}

      <div className="d-flex justify-content-center my-4">
        {/* Dropdowns for different report types */}
        <Dropdown className="mx-2">
          <Dropdown.Toggle variant="primary" id="dropdown-basic">
            Generate Customer Report
          </Dropdown.Toggle>

          <Dropdown.Menu>
            <Dropdown.Item onClick={() => generateReport('CustomerDemographic')}>Customer Demographics</Dropdown.Item>
            <Dropdown.Item onClick={() => generateReport('TopCustomersByAmount')}>Top Customers by Amount</Dropdown.Item>
            <Dropdown.Item onClick={() => generateReport('FrequentCustomers')}>Frequent Customers</Dropdown.Item>
            <Dropdown.Item onClick={() => generateReport('AllCustomers')}>All Customers</Dropdown.Item>
            <Dropdown.Item onClick={() => generateReport('InactiveCustomers')}>Inactive Customers</Dropdown.Item>
          </Dropdown.Menu>
        </Dropdown>

        <Dropdown className="mx-2">
          <Dropdown.Toggle variant="primary" id="dropdown-basic">
            Generate Item Report
          </Dropdown.Toggle>

          <Dropdown.Menu>
            <Dropdown.Item onClick={() => generateReport('AllProducts')}>All Products</Dropdown.Item>
            <Dropdown.Item onClick={() => generateReport('TopSelling')}>Top Selling Products</Dropdown.Item>
            <Dropdown.Item onClick={() => generateReport('WorstSelling')}>Worst Selling Products</Dropdown.Item>
            <Dropdown.Item onClick={() => generateReport('BestReviews')}>Top Reviewed Products</Dropdown.Item>
            <Dropdown.Item onClick={() => generateReport('WorstReviews')}>Worst Reviewed Products</Dropdown.Item>
          </Dropdown.Menu>
        </Dropdown>

        <Dropdown className="mx-2">
          <Dropdown.Toggle variant="primary" id="category-dropdown">
            Generate Category Report
          </Dropdown.Toggle>

          <Dropdown.Menu>
            <Dropdown.Item onClick={() => generateReport('AllCategories')}>All Categories</Dropdown.Item>
            <Dropdown.Item onClick={() => generateReport('AllSubcategories')}>All Subcategories</Dropdown.Item>
            <Dropdown.Item onClick={() => generateReport('TopSellingCategories')}>Top Selling Categories</Dropdown.Item>
            <Dropdown.Item onClick={() => generateReport('TopSellingSubcategories')}>Top Selling Subcategories</Dropdown.Item>
          </Dropdown.Menu>
        </Dropdown>

        <Dropdown className="mx-2">
          <Dropdown.Toggle variant="primary" id="sales-dropdown">
            Generate Sales Report
          </Dropdown.Toggle>

          <Dropdown.Menu>
            <Dropdown.Item onClick={() => generateReport('AllSales')}>All Sales</Dropdown.Item>
            <Dropdown.Item onClick={() => generateReport('BestSales')}>Best Sales</Dropdown.Item>
            <Dropdown.Item onClick={() => generateReport('DemographicSales')}>Demographic Sales</Dropdown.Item>
            <Dropdown.Item onClick={() => generateReport('SalesByPaymentMethod')}>Sales By Payment Method</Dropdown.Item>
            <Dropdown.Item onClick={() => generateReport('SalesSummary')}>Sales Summary</Dropdown.Item>
          </Dropdown.Menu>
        </Dropdown>
      </div>

      <div className="report-output">
        {reportData.length > 0 ? (
          <div className="report-table">
            <h3 className="text-center">
              Report Type: {reportType.charAt(0).toUpperCase() + reportType.slice(1)}
            </h3>
            <Table striped bordered hover responsive>
              <thead>
                <tr>
                  {Object.keys(reportData[0]).map((key) => (
                    <th key={key}>{key}</th>
                  ))}
                </tr>
              </thead>
              <tbody>
                {reportData.map((item, index) => (
                  <tr key={index}>
                    {Object.values(item).map((value, idx) => (
                      <td key={idx}>{value}</td>
                    ))}
                  </tr>
                ))}
              </tbody>
            </Table>
          </div>
        ) : (
          <p className="text-center">No report data available. Please generate a report.</p>
        )}
      </div>

      <div className="d-flex justify-content-center my-4">
        <button className="btn btn-success mx-2" onClick={exportToCSV}>
          Export to CSV
        </button>
        <button className="btn btn-danger mx-2" onClick={exportToPDF}>
          Export to PDF
        </button>
      </div>
    </div>
  );
};

export default ReportGeneration;
