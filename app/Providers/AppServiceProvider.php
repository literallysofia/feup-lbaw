<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;
use App\Category;
use View;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Bootstrap any application services.
     *
     * @return void
     */
    public function boot()
    {
        View::composer('*', function($view) {
            $view->with('navCategories', Category::where([['is_navbar_category', true],['is_archived', false]])->get());            
            //$view->with('navCategories', Category::where('is_navbar_category', true)->get());
        });
    }

    /**
     * Register any application services.
     *
     * @return void
     */
    public function register()
    {
        //
    }
}
