const connection = require('../database'); // Import the direct connection

// Function to fetch sales data for October 2023
const xyz = async (req, res) => {
  try {
    // Query to get sales data, grouped by day for October 2023
    connection.query(`
      SELECT 
        DAY(SalesDate) AS day, 
        SUM(SalesAmount) AS totalSales
      FROM SALES
      WHERE YEAR(SalesDate) = 2023 AND MONTH(SalesDate) = 10
      GROUP BY DAY(SalesDate)
      ORDER BY DAY(SalesDate);
    `, (err, dailySales) => {
      if (err) {
        console.error('Error fetching daily sales:', err);
        return res.status(500).json({ error: 'Internal server error' });
      }

      // Query to get total sales made, total revenue, and items sold for October 2023
      connection.query(`
        SELECT 
          COUNT(DISTINCT S.SalesID) AS salesMade, 
          SUM(S.SalesAmount) AS totalRevenue, 
          SUM(PS.Quantity) AS itemsSold
        FROM SALES S
        LEFT JOIN PRODUCT_SALES PS ON S.SalesID = PS.Sales_ID
        WHERE YEAR(S.SalesDate) = 2024 AND MONTH(S.SalesDate) = 10;
      `, (err, summaryStats) => {
        if (err) {
          console.error('Error fetching summary stats:', err);
          return res.status(500).json({ error: 'Internal server error' });
        }

        // Combine the data and send it back in the response
        res.json({
          dailySales,                          // Array of daily sales grouped by day
          salesMade: summaryStats[0]?.salesMade || 0, // Total sales made (with a fallback)
          totalRevenue: summaryStats[0]?.totalRevenue || 0, // Total revenue (with a fallback)
          itemsSold: summaryStats[0]?.itemsSold || 0,     // Total items sold (with a fallback)
        });
      });
    });
  } catch (err) {
    console.error('Error fetching sales data:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
};

module.exports = { xyz };
