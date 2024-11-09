import React, { useState, useEffect } from 'react';
import Lottie from 'react-lottie';
import './InventoryManagement.css';

// Import your Lottie animation JSON files
import addAnimation from 'D:/H/GitHub/Tech-ecommerce/SalesManagement/tech-ecommerce/src/animations/Add Product Animation.json';
import updateAnimation from 'D:/H/GitHub/Tech-ecommerce/SalesManagement/tech-ecommerce/src/animations/Update Product Animation.json';
import deleteAnimation from 'D:/H/GitHub/Tech-ecommerce/SalesManagement/tech-ecommerce/src/animations/Delete Product Animation.json';

const InventoryManagement = () => {
  const [products, setProducts] = useState([]);
  const [categories, setCategories] = useState([]);
  const [newProduct, setNewProduct] = useState({ name: '', quantity: '', price: '', superCategory: '', category: '', image: '' });
  const [updateProduct, setUpdateProduct] = useState({ id: '', name: '', quantity: '', price: '' });
  const [deleteProductInput, setDeleteProductInput] = useState({ id: '', name: '' });
  const [isAddPopupOpen, setAddPopupOpen] = useState(false);
  const [isUpdatePopupOpen, setUpdatePopupOpen] = useState(false);
  const [isDeletePopupOpen, setDeletePopupOpen] = useState(false);

  useEffect(() => {
    fetchProducts();
    fetchCategories();
  }, []);

  const fetchProducts = async () => {
    try {
      const response = await fetch('http://localhost:3000/api/inventory');
      const data = await response.json();
      console.log('Fetched products:', data);
      setProducts(data);
    } catch (error) {
      console.error('Error fetching products:', error);
    }
  };

  const fetchCategories = async () => {
    try {
      const response = await fetch('http://localhost:3000/api/categories');
      const data = await response.json();
      setCategories(data);
    } catch (error) {
      console.error('Error fetching categories:', error);
    }
  };

  const superCategories = [...new Set(categories.map(category => category.Super_Category))];

  const getSubCategories = (superCategory) => {
    const subCategories = categories
      .filter(category => category.Super_Category === superCategory)
      .map(category => category.Category_Name);
    return [...new Set(subCategories)];
  };

  const handleAddProduct = async () => {
    if (!newProduct.name || !newProduct.quantity || !newProduct.price || !newProduct.superCategory || !newProduct.category || !newProduct.image) {
      alert('Please fill in all fields');
      return;
    }

    const newProductData = {
      Product_Name: newProduct.name,
      Price: parseFloat(newProduct.price),
      Stock_Level: newProduct.quantity,
      Super_Category: newProduct.superCategory,
      Category_Name: newProduct.category,
      Image: newProduct.image,
    };

    try {
      await fetch('http://localhost:3000/api/inventory', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(newProductData),
      });
      fetchProducts();
      setAddPopupOpen(false);
      setNewProduct({ name: '', quantity: '', price: '', superCategory: '', category: '', image: '' });
    } catch (error) {
      console.error('Error adding product:', error);
    }
  };

  const handleUpdateInventory = async () => {
    if (!updateProduct.id) {
      alert('Please enter the Product ID to update');
      return;
    }

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
      fetchProducts();
      setUpdatePopupOpen(false);
      setUpdateProduct({ id: '', name: '', quantity: '', price: '' });
    } catch (error) {
      console.error('Error updating product:', error);
    }
  };

  const handleDeleteProduct = async () => {
    if (!deleteProductInput.id && !deleteProductInput.name) {
      alert('Please enter either Product ID or Product Name to delete');
      return;
    }

    const deleteProductData = {
      Product_ID: deleteProductInput.id,
      Product_Name: deleteProductInput.name,
    };

    try {
      await fetch('http://localhost:3000/api/inventory/delete', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(deleteProductData),
      });
      fetchProducts();
      setDeletePopupOpen(false);
      setDeleteProductInput({ id: '', name: '' });
    } catch (error) {
      console.error('Error deleting product:', error);
    }
  };

  const defaultOptions = (animationData) => ({
    loop: true,
    autoplay: true,
    animationData: animationData,
    rendererSettings: {
      preserveAspectRatio: 'xMidYMid slice'
    }
  });

  return (
    <div className="inventory-management">
      <h2>Inventory Management</h2>

      <div className="management-options">
        <div className="management-option" onClick={() => setAddPopupOpen(true)}>
          <Lottie options={defaultOptions(addAnimation)} height={50} width={50} />
          <span>Add Product</span>
        </div>
        <div className="management-option" onClick={() => setUpdatePopupOpen(true)}>
          <Lottie options={defaultOptions(updateAnimation)} height={50} width={50} />
          <span>Update Inventory</span>
        </div>
        <div className="management-option" onClick={() => setDeletePopupOpen(true)}>
          <Lottie options={defaultOptions(deleteAnimation)} height={50} width={50} />
          <span>Delete Product</span>
        </div>
      </div>

      {/* Add New Product Popup */}
      {isAddPopupOpen && (
        <div className="popup">
          <h4>Add New Product</h4>

          {/* Category Fields First */}
          <select
            value={newProduct.superCategory}
            onChange={(e) => setNewProduct({ ...newProduct, superCategory: e.target.value, category: '' })}
          >
            <option value="">Select Super Category</option>
            {superCategories.map((superCategory, index) => (
              <option key={index} value={superCategory}>{superCategory}</option>
            ))}
          </select>

          <select
            value={newProduct.category}
            onChange={(e) => setNewProduct({ ...newProduct, category: e.target.value })}
          >
            <option value="">Select Category</option>
            {newProduct.superCategory && getSubCategories(newProduct.superCategory).map((category, index) => (
              <option key={index} value={category}>{category}</option>
            ))}
          </select>

          {/* Remaining Fields */}
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
            placeholder="Image URL"
            value={newProduct.image}
            onChange={(e) => setNewProduct({ ...newProduct, image: e.target.value })}
          />

          <div className="popup-buttons">
            <button onClick={handleAddProduct}>Add Product</button>
            <button onClick={() => setAddPopupOpen(false)}>Cancel</button>
          </div>
        </div>
      )}

      {/* Update Product Popup */}
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
          <div className="popup-buttons">
            <button onClick={handleUpdateInventory}>Update Product</button>
            <button onClick={() => setUpdatePopupOpen(false)}>Cancel</button>
          </div>
        </div>
      )}

      {/* Delete Product Popup */}
      {isDeletePopupOpen && (
        <div className="popup">
          <h4>Delete Product</h4>
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
          <div className="popup-buttons">
            <button onClick={handleDeleteProduct}>Delete Product</button>
            <button onClick={() => setDeletePopupOpen(false)}>Cancel</button>
          </div>
        </div>
      )}

      <table>
        <thead>
          <tr>
            <th>Product ID</th>
            <th>Product Name</th>
            <th>Price</th>
            <th>Stock Level</th>
            <th>Super Category</th>
            <th>Category</th>
          </tr>
        </thead>
        <tbody>
          {products.map((product) => (
            <tr key={product.Product_ID}>
              <td>{product.Product_ID}</td>
              <td>{product.Product_Name}</td>
              <td>{product.Price}</td>
              <td>{product.Stock_Level}</td>
              <td>{product.Category}</td>
              <td>{product.Subcategory}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

export default InventoryManagement;
