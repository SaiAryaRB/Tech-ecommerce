// src/components/Cart.js
import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import axios from 'axios';
import { FaTrash } from 'react-icons/fa';
import './Cart.css';

const Cart = () => {
    const navigate = useNavigate();
    const [cartItems, setCartItems] = useState([]);
    const [totalPrice, setTotalPrice] = useState(0);

    // Fetch cart details from the server
    const fetchCartDetails = async () => {
        const customerId = sessionStorage.getItem('customerId');
        if (!customerId) return console.error('No customer ID found');

        try {
            const response = await axios.post('http://localhost:3000/api/viewcart', { customerId });
            const items = response.data;
            setCartItems(items);
            const total = items.reduce((sum, item) => sum + parseFloat(item.Total_Price), 0);
            setTotalPrice(total);
        } catch (error) {
            console.error('Error fetching cart details:', error);
        }
    };

    useEffect(() => {
        fetchCartDetails();
    }, []);

    // Handle quantity changes
    const handleQuantityChange = async (productId, newQuantity) => {
        const customerId = sessionStorage.getItem('customerId');
        if (!customerId || newQuantity < 1) return;

        try {
            await axios.post('http://localhost:3000/api/updatecart', {
                customerId,
                productId,
                newQuantity,
            });
            await fetchCartDetails();
        } catch (error) {
            console.error('Error updating cart quantity:', error);
        }
    };

    // Handle deleting items
    const handleDeleteItem = async (productId) => {
        const customerId = sessionStorage.getItem('customerId');
        if (!customerId) return;

        try {
            await axios.post('http://localhost:3000/api/deletecart', { customerId, productId });
            await fetchCartDetails();
        } catch (error) {
            console.error('Error deleting cart item:', error);
        }
    };

    // Navigate to order confirmation
    const handleProceedToOrder = () => {
        navigate('/order-confirmation');
    };

    return (
        <div className="cart-container">
            <h1 className="cart-title">Your Cart</h1>
            {cartItems.length === 0 ? (
                <p className="cart-empty">Your cart is empty.</p>
            ) : (
                <ul className="cart-items">
                    {cartItems.map((item) => (
                        <li className="cart-item" key={item.Product_ID}>
                            <div className="item-details">
                                <span className="item-name">{item.Product_Name}</span>
                                <span className="item-price"> - ${parseFloat(item.Price).toFixed(2)}</span>
                                <div className="quantity-container">
                                    <button
                                        className="quantity-button"
                                        onClick={() => handleQuantityChange(item.Product_ID, item.Quantity - 1)}
                                    >
                                        -
                                    </button>
                                    <input
                                        type="text"
                                        className="quantity-input"
                                        value={item.Quantity}
                                        readOnly
                                    />
                                    <button
                                        className="quantity-button"
                                        onClick={() => handleQuantityChange(item.Product_ID, item.Quantity + 1)}
                                    >
                                        +
                                    </button>
                                </div>
                                <span className="item-total"> = ${parseFloat(item.Total_Price).toFixed(2)}</span>
                            </div>
                            <FaTrash className="delete-icon" onClick={() => handleDeleteItem(item.Product_ID)} />
                        </li>
                    ))}
                </ul>
            )}
            <h2 className="total-price">Total Price: ${totalPrice.toFixed(2)}</h2>
            <button className="proceed-button" onClick={handleProceedToOrder}>
                Proceed to Order Confirmation
            </button>
        </div>
    );
};

export default Cart;
