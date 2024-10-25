import React, { useState, useEffect } from 'react';
import './InventoryManagement.css'; // Import your CSS file

const InventoryManagement = () => {
  const [products, setProducts] = useState([]);
  const [categories, setCategories] = useState([]); // State for categories
  const [newProduct, setNewProduct] = useState({ name: '', quantity: '', price: '', superCategory: '', category: '', image: '' });
  const [updateProduct, setUpdateProduct] = useState({ id: '', name: '', quantity: '', price: '' });
  const [deleteProductInput, setDeleteProductInput] = useState({ id: '', name: '' });
  const [isUpdatePopupOpen, setUpdatePopupOpen] = useState(false); // State for controlling the popup

  // Fetch current inventory and categories when the component mounts
  useEffect(() => {
    fetchProducts();
    fetchCategories();
  }, []);

  const fetchProducts = async () => {
    try {
      const response = await fetch('http://localhost:3000/api/inventory'); // Adjusted API endpoint
      const data = await response.json();
      console.log('Fetched products:', data);
      setProducts(data);
    } catch (error) {
      console.error('Error fetching products:', error);
    }
  };

  const fetchCategories = async () => {
    try {
      const response = await fetch('http://localhost:3000/api/categories'); // Adjusted API endpoint for categories
      const data = await response.json();
      setCategories(data);
    } catch (error) {
      console.error('Error fetching categories:', error);
    }
  };

  // Get unique super categories
  const superCategories = [...new Set(categories.map(category => category.Super_Category))];

  // Get unique categories based on selected super category
  const getSubCategories = (superCategory) => {
    const subCategories = categories
      .filter(category => category.Super_Category === superCategory)
      .map(category => category.Category_Name);
    
    // Use Set to filter out duplicates and convert back to an array
    return [...new Set(subCategories)];
  };

  const handleAddProduct = async () => {
    if (!newProduct.name || !newProduct.quantity || !newProduct.price || !newProduct.superCategory || !newProduct.category || !newProduct.image) {
      alert('Please fill in all fields');
      return;
    }

    const newProductData = {
      Product_Name: newProduct.name,
      Price: parseFloat(newProduct.price), // Ensure price is a float
      Stock_Level: newProduct.quantity,
      Super_Category: newProduct.superCategory,
      Category_Name: newProduct.category, // Use Category_Name instead of Sub_Category
      Image: newProduct.image, // Include image link
    };

    console.log(newProductData)

    try {
      await fetch('http://localhost:3000/api/inventory', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(newProductData), // Send the new product data
      });
      fetchProducts(); // Refresh product list
      setNewProduct({ name: '', quantity: '', price: '', superCategory: '', category: '', image: '' }); // Reset input fields
    } catch (error) {
      console.error('Error adding product:', error);
    }
  };

  const handleUpdateInventory = async () => {
    if (!updateProduct.id) {
      alert('Please enter the Product ID to update');
      return;
    }

    // Create an object with only the fields that have values
    const updateData = { Product_ID: updateProduct.id };

    if (updateProduct.name) updateData.Product_Name = updateProduct.name;
    if (updateProduct.quantity) updateData.Stock_Level = updateProduct.quantity;
    if (updateProduct.price) updateData.Price = parseFloat(updateProduct.price);

    try {
      await fetch(`http://localhost:3000/api/inventory/${updateProduct.id}`, {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(updateData),
      });
      fetchProducts(); // Refresh product list
      setUpdateProduct({ id: '', name: '', quantity: '', price: '' }); // Reset input fields
      setUpdatePopupOpen(false); // Close the popup
    } catch (error) {
      console.error('Error updating product:', error);
    }
  };

  const handleDeleteProduct = async () => {
    if (!deleteProductInput.id && !deleteProductInput.name) {
      alert('Please enter either Product ID or Product Name to delete');
      return;
    }

    // Prepare the body for the POST request
    const deleteProductData = {
      Product_ID: deleteProductInput.id,
      Product_Name: deleteProductInput.name,
    };

    console.log('Sending delete request with data:', deleteProductData); // Log the request body

    try {
      await fetch('http://localhost:3000/api/inventory/delete', { // Change to POST endpoint
        method: 'POST', // Use POST instead of DELETE
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(deleteProductData), // Send the delete product data
      });
      fetchProducts(); // Refresh product list
      setDeleteProductInput({ id: '', name: '' }); // Reset input fields
    } catch (error) {
      console.error('Error deleting product:', error);
    }
  };

  return (
    <div className="inventory-management">
      <h2>Inventory Management</h2>

      <div className="add-product">
        <h3>Add New Product</h3>
        <input
          type="text"
          placeholder="Product Name"
          value={newProduct.name}
          onChange={(e) => setNewProduct({ ...newProduct, name: e.target.value })}
        />
        <input
          type="number"
          placeholder="Quantity"
          value={newProduct.quantity}
          onChange={(e) => setNewProduct({ ...newProduct, quantity: e.target.value })}
        />
        <input
          type="number"
          placeholder="Price"
          value={newProduct.price}
          onChange={(e) => setNewProduct({ ...newProduct, price: e.target.value })}
        />
        <input
          type="text"
          placeholder="Image Link" // New input for image link
          value={newProduct.image}
          onChange={(e) => setNewProduct({ ...newProduct, image: e.target.value })}
        />
        <select
          value={newProduct.superCategory}
          onChange={(e) => setNewProduct({ ...newProduct, superCategory: e.target.value, category: '' })} // Reset category when super category changes
        >
          <option value="">Select Super Category</option>
          {superCategories.map((superCategory, index) => (
            <option key={index} value={superCategory}>
              {superCategory}
            </option>
          ))}
        </select>
        <select
          value={newProduct.category}
          onChange={(e) => setNewProduct({ ...newProduct, category: e.target.value })}
        >
          <option value="">Select Category</option>
          {newProduct.superCategory && getSubCategories(newProduct.superCategory).map((category, index) => (
            <option key={index} value={category}>
              {category} {/* Display as Sub Category */}
            </option>
          ))}
        </select>
        <button onClick={handleAddProduct}>Add Product</button>
      </div>

      <div className="update-product">
        <h3>Update Inventory</h3>
        <button onClick={() => setUpdatePopupOpen(true)}>Update Inventory</button>

        {isUpdatePopupOpen && (
          <div className="popup">
            <h4>Update Product</h4>
            <input
              type="text"
              placeholder="Product ID"
              value={updateProduct.id}
              onChange={(e) => setUpdateProduct({ ...updateProduct, id: e.target.value })}
            />
            <input
              type="text"
              placeholder="New Product Name (optional)"
              value={updateProduct.name}
              onChange={(e) => setUpdateProduct({ ...updateProduct, name: e.target.value })}
            />
            <input
              type="number"
              placeholder="New Quantity (optional)"
              value={updateProduct.quantity}
              onChange={(e) => setUpdateProduct({ ...updateProduct, quantity: e.target.value })}
            />
            <input
              type="number"
              placeholder="New Price (optional)"
              value={updateProduct.price}
              onChange={(e) => setUpdateProduct({ ...updateProduct, price: e.target.value })}
            />
            <button onClick={handleUpdateInventory}>Update Product</button>
            <button onClick={() => setUpdatePopupOpen(false)}>Close</button>
          </div>
        )}
      </div>

      <div className="delete-product">
        <h3>Delete Product</h3>
        <input
          type="text"
          placeholder="Product ID (optional)"
          value={deleteProductInput.id}
          onChange={(e) => setDeleteProductInput({ ...deleteProductInput, id: e.target.value })}
        />
        <input
          type="text"
          placeholder="Product Name (optional)"
          value={deleteProductInput.name}
          onChange={(e) => setDeleteProductInput({ ...deleteProductInput, name: e.target.value })}
        />
        <button onClick={handleDeleteProduct}>Delete Product</button>
      </div>

      <div className="current-inventory">
        <h3>Current Inventory</h3>
        <ul>
          {products.map(product => (
            <li key={product.Product_ID}>
              {product.Product_Name} - Quantity: {product.Stock_Level} - Price: ${product.Price} - <img src={product.Image} alt={product.Product_Name} width={50} />
            </li>
          ))}
        </ul>
      </div>
    </div>
  );
};

export default InventoryManagement;
