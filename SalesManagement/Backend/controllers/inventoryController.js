const db = require('../database'); // Adjust the path based on your project structure

const getInventory = (req, res) => {
  const query = `
    SELECT 
      Inventory.Inventory_ID, 
      Inventory.Product_ID, 
      Products.Product_Name, 
      Products.Price,  -- Include Price from Products table
      Inventory.Stock_Level 
    FROM Inventory 
    JOIN Products ON Inventory.Product_ID = Products.Product_ID`;

  db.query(query, (err, results) => {
    if (err) {
      console.error('Database error:', err);
      return res.status(500).json({ message: 'Internal server error' });
    }
    res.json(results); // This will now include Inventory_ID, Product_ID, Product_Name, Price, and Stock_Level
  });
};



const addNewProduct = (req, res) => {
  console.log('Request Body in addNewProduct:', req.body);

  const { Product_Name, Stock_Level, Price, Super_Category, Category_Name, Image } = req.body; // Include Image
  const stockLevel = parseInt(Stock_Level, 10);

  if (!Product_Name || !Price || isNaN(stockLevel) || !Super_Category || !Category_Name || !Image) { // Check for Image
      return res.status(400).json({ message: 'All fields are required.' });
  }

  // Call the stored procedure to add the product, inventory, and categories
  const sql = 'CALL AddProductWithCategory(?, ?, ?, ?, ?, ?)'; // Update to include Image

  db.query(sql, [Product_Name, stockLevel, Price, Super_Category, Category_Name, Image], (err, result) => {
      if (err) {
          console.error('Error executing stored procedure:', err);
          return res.status(500).json({ message: 'Internal server error' });
      }
      res.status(200).json({ message: 'Product, inventory, and category added successfully.' });
  });
};


  
const updateProduct = (req, res) => {
  console.log('Request Body for updateProduct:', req.body);

  const { Product_ID, Product_Name, Price, Stock_Level } = req.body;
  const updates = [];
  const queryParams = [];

  // Validate Product_ID
  if (!Product_ID) {
      return res.status(400).json({ message: 'Product ID is required.' });
  }

  // Construct the update query based on provided fields
  if (Product_Name) {
      updates.push('Product_Name = ?');
      queryParams.push(Product_Name);
  }
  if (Price) {
      updates.push('Price = ?');
      queryParams.push(Price);
  }
  if (Stock_Level) {
      const stockLevel = parseInt(Stock_Level, 10);
      if (isNaN(stockLevel)) {
          return res.status(400).json({ message: 'Invalid stock level.' });
      }
      updates.push('Stock_Level = ?');
      queryParams.push(stockLevel);
  }

  // If no fields to update, return an error
  if (updates.length === 0) {
      return res.status(400).json({ message: 'At least one field to update is required (Product_Name, Price, or Stock_Level).' });
  }

  // Prepare the final SQL query
  const sql = `UPDATE Products INNER JOIN Inventory ON Products.Product_ID = Inventory.Product_ID 
               SET ${updates.join(', ')} 
               WHERE Products.Product_ID = ?`;

  // Add Product_ID to the parameters
  queryParams.push(Product_ID);

  // Execute the update query
  db.query(sql, queryParams, (err, result) => {
      if (err) {
          console.error('Error executing update query:', err);
          return res.status(500).json({ message: 'Internal server error' });
      }
      res.status(200).json({ message: 'Product and inventory updated successfully.' });
  });
};



  const deleteProduct = (req, res) => {
    // Log the received request body
    console.log('Request Body for deleteProduct:', req.body);
  
    const { Product_ID, Product_Name } = req.body; // Read from body
  
    let deleteProductSql = 'DELETE FROM Products WHERE ';
    const queryParams = [];
  
    if (Product_ID) {
      deleteProductSql += 'Product_ID = ?';
      queryParams.push(Product_ID);
      console.log('Deleting product with ID:', Product_ID); // Log the Product_ID being deleted
    } else if (Product_Name) {
      deleteProductSql += 'Product_Name = ?';
      queryParams.push(Product_Name);
      console.log('Deleting product with Name:', Product_Name); // Log the Product_Name being deleted
    } else {
      return res.status(400).json({ message: 'Please provide either Product_ID or Product_Name.' });
    }
  
    // Execute the delete query
    db.query(deleteProductSql, queryParams, (err, result) => {
      if (err) {
        console.error('Error deleting product:', err);
        return res.status(500).json({ message: 'Error deleting product.' });
      }
  
      res.status(200).json({ message: 'Product deleted successfully.' });
    });
  };
  
  

module.exports = {
  getInventory,
  addNewProduct,
  deleteProduct,
  updateProduct,
};
