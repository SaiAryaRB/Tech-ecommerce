import React, { useEffect, useState } from 'react';
import axios from 'axios';
import './OrderConfirmation.css';

const OrderConfirmation = () => {
    const [cartItems, setCartItems] = useState([]);
    const [totalPrice, setTotalPrice] = useState(0);
    const [paymentMethod, setPaymentMethod] = useState('Cash');
    const [orderConfirmed, setOrderConfirmed] = useState(false);
    const [loading, setLoading] = useState(false);

    const fetchCartDetails = async () => {
        const customerId = sessionStorage.getItem('customerId');
        if (!customerId) {
            console.error('No customer ID found');
            return;
        }

        try {
            const response = await axios.post('http://localhost:3000/api/viewcart', { customerId });
            const items = response.data;
            console.log('Cart items fetched:', items);
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

    const handleConfirmOrder = async () => {
        const customerId = sessionStorage.getItem('customerId');

        if (!customerId) {
            console.error('No customer ID found for order confirmation');
            return;
        }

        setLoading(true);
        try {
            const response = await axios.post('http://localhost:3000/order/confirm', {
                customerId,
                paymentMethod,
            });
            console.log('Order confirmation response:', response.data);
            setOrderConfirmed(true);
        } catch (error) {
            console.error('Error confirming order:', error);
        } finally {
            setLoading(false);
        }
    };

    return (
        <div className="order-confirmation">
            <h1>Order Confirmation</h1>
            <h2>Review Your Order</h2>
            {cartItems.length === 0 ? (
                <p>Your cart is empty.</p>
            ) : (
                <ul>
                    {cartItems.map((item) => (
                        <li key={item.Product_ID} className="cart-item">
                            <span className="product-name">{item.Product_Name}</span>
                            <span className="price-details">
                                <span className="unit-price">${parseFloat(item.Price).toFixed(2)}</span>
                                <span className="quantity">Qty: {item.Quantity}</span>
                                <span className="total-item-price">${parseFloat(item.Total_Price).toFixed(2)}</span>
                            </span>
                        </li>
                    ))}
                </ul>
            )}
            <div className="total-price">Total Price: ${totalPrice.toFixed(2)}</div>

            <h3>Select Payment Method</h3>
            <div className="payment-methods">
                <label>
                    <input
                        type="radio"
                        value="Cash"
                        checked={paymentMethod === 'Cash'}
                        onChange={(e) => setPaymentMethod(e.target.value)}
                    />
                    <span>Cash</span>
                </label>
                <label>
                    <input
                        type="radio"
                        value="Credit Card"
                        checked={paymentMethod === 'Credit Card'}
                        onChange={(e) => setPaymentMethod(e.target.value)}
                    />
                    <span>Credit Card</span>
                </label>
                <label>
                    <input
                        type="radio"
                        value="Debit Card"
                        checked={paymentMethod === 'Debit Card'}
                        onChange={(e) => setPaymentMethod(e.target.value)}
                    />
                    <span>Debit Card</span>
                </label>
                <label>
                    <input
                        type="radio"
                        value="PayPal"
                        checked={paymentMethod === 'PayPal'}
                        onChange={(e) => setPaymentMethod(e.target.value)}
                    />
                    <span>PayPal</span>
                </label>
            </div>

            <button className="confirm-button" onClick={handleConfirmOrder} disabled={loading}>
                {loading ? 'Processing...' : 'Confirm Order'}
            </button>

            {orderConfirmed && <p className="order-confirmed-message">Your order has been confirmed!</p>}
        </div>
    );
};

export default OrderConfirmation;