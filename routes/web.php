<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

//Homepage
Route::get('/', 'ProductsController@showHighlights');

// Cards
Route::get('cards', 'CardController@list');
Route::get('cards/{id}', 'CardController@show');

// API
Route::put('api/cards', 'CardController@create');
Route::delete('api/cards/{card_id}', 'CardController@delete');
Route::put('api/cards/{card_id}/', 'ItemController@create');
Route::post('api/item/{id}', 'ItemController@update');
Route::delete('api/item/{id}', 'ItemController@delete');

// Authentication
Route::get('login', 'Auth\LoginController@showLoginForm')->name('login');
Route::post('login', 'Auth\LoginController@login');
Route::get('logout', 'Auth\LoginController@logout')->name('logout');
Route::get('register', 'Auth\RegisterController@showRegistrationForm')->name('register');
Route::post('register', 'Auth\RegisterController@register');

//Profile
Route::get('profile/{id}', 'UserController@showProfile')->name('profile')->where('id','[0-9]+');
Route::view('404', 'errors/404')->name('404');
Route::view('401', 'errors/401')->name('401');
Route::view('/profile/edit', 'errors/404');
Route::put('/profile/edit', 'UserController@editProfile');
Route::view('/profile/address', 'errors/404');
Route::post('/profile/address', 'AddressController@addAddressResponse');
Route::put('/profile/address', 'AddressController@deleteAddressResponse');

//Admin
Route::get('admin', 'AdminController@showAdmin')->name('admin')->middleware('auth', 'admin');
Route::view('/admin/admin_purchases', 'errors/404');
Route::post('admin/admin_purchases', 'AdminController@updateAdminPurchases');
Route::view('/admin/property', 'errors/404');
Route::post('admin/property', 'AdminController@addPropertyResponse');
Route::delete('admin/property', 'AdminController@deletePropertyResponse');
Route::view('/admin/category', 'errors/404');
Route::post('admin/category', 'AdminController@addCategoryResponse');
Route::put('admin/category', 'AdminController@deleteCategoryResponse');
Route::view('/admin/category_properties', 'errors/404');
Route::post('admin/category_properties', 'AdminController@addCategoryPropertiesResponse');
Route::view('/admin/faq', 'errors/404');
Route::post('admin/faq', 'AdminController@addFaq');
Route::delete('admin/faq', 'AdminController@deleteFaq');

//Static pages
Route::get('faq','FaqController@showFaqs')->name('faq');
Route::view('about','pages/about');
Route::view('contact','pages/contact');
Route::post('contact','ContactController@sendEmail')->name('sendemail');

//Cart and wishlist
Route::get('wishlist','WishlistController@showWishlist')->name('wishlist');
Route::delete('wishlist', 'WishlistController@removeWishlistProduct');
Route::post('wishlist', 'WishlistController@addWishlistProduct');

Route::get('cart', 'CartController@showCart')->name('cart');
Route::delete('cart', 'CartController@removeCartProduct');
Route::post('cart', 'CartController@addCartProduct');
Route::put('cart', 'CartController@updateCartProduct');

//Purchase
Route::post('checkout', 'CartController@checkout')->name('checkout');

//Product
Route::get('product/{product_id}', 'ProductsController@showProduct')->where('product_id','[0-9]+')->name('product');

//Products
Route::get('category/{category_id}','ProductsController@showProducts')->where('category_id','[0-9]+')->name('category_products');
Route::get('search','ProductsController@searchProducts')->name('search_products');

//Add Product
Route::get('add_product/{category_name}','ProductsController@showAddProduct')->name('add_product')->middleware('auth','admin');
Route::post('add_product','ProductsController@addProduct');

//Edit Product
Route::get('/product/{id}/edit','ProductsController@showEditProduct')->where('id','[0-9]+')->name('edit_product')->middleware('auth','admin');
Route::put('/product/{id}/edit','ProductsController@editProduct')->where('id','[0-9]+');
Route::get('/product/{id}/archive', 'ProductsController@archiveProduct')->where('id','[0-9]+')->name('archive_product');

Route::post('upload','ProductsController@uploadImage');


Route::delete('product/{id}/review', 'ProductsController@deleteReview')->where('id','[0-9]+')->name('review');
Route::post('product/{id}/review', 'ProductsController@addReview')->where('id','[0-9]+');
Route::put('product/{id}/review', 'ProductsController@updateReview')->where('id','[0-9]+');

Auth::routes();
