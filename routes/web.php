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

Route::get('/', function () {
    return redirect('homepage');
});

//Homepage
Route::view('/homepage', 'pages/homepage');

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
Route::view('/profile/edit', 'errors/404');
Route::put('/profile/edit', 'UserController@editProfile');
Route::view('/profile/address', 'errors/404');
Route::post('/profile/address', 'AddressController@addAddressResponse');
Route::put('/profile/address', 'AddressController@deleteAddressResponse');

//Admin
Route::get('admin', 'AdminController@showAdmin')->name('admin');
Route::post('admin/property', 'AdminController@addPropertyResponse');
Route::delete('admin/property', 'AdminController@deletePropertyResponse');
Route::post('admin/category', 'AdminController@addCategoryResponse');
Route::put('admin/category', 'AdminController@deleteCategoryResponse');
Route::post('admin/category_properties', 'AdminController@addCategoryPropertiesResponse');

//Static pages
Route::get('faq','FaqController@showFaqs')->name('faq');
Route::view('about','pages/about');
Route::view('contact','pages/contact');
Route::post('contact','ContactController@sendEmail')->name('sendemail');

//Cart and wishlist
Route::get('wishlist','CartWishlistController@showWishlist')->name('wishlist');
Route::delete('wishlist', 'CartWishlistController@removeWishlistProduct');
Route::post('wishlist', 'CartWishlistController@addWishlistProduct');
Route::get('cart', 'CartWishlistController@showCart')->name('cart');
Route::delete('cart', 'CartWishlistController@removeCartProduct');
Route::post('cart', 'CartWishlistController@addCartProduct');

//Product
Route::get('product/{product_id}', 'ProductsController@showProduct')->name('product');

//Products
Route::get('category/{category_id}','ProductsController@showProducts')->name('category_products');

//Add Product
Route::get('add_product/{category_name}','ProductsController@showAddProduct')->name('add_product');

//Edit Product
Route::get('/product/{id}/edit','ProductsController@showEditProduct')->name('edit_product');

Route::delete('product/{id}/review', 'ProductsController@deleteReview')->name('review');
Route::post('product/{id}/review', 'ProductsController@addReview');
