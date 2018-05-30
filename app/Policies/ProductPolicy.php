<?php

namespace App\Policies;

use App\User;
use App\Product;
use App\Purchase;

use Illuminate\Auth\Access\HandlesAuthorization;
use Illuminate\Support\Facades\Auth;

class ProductPolicy {
    use HandlesAuthorization;

    public function edit(User $user, User $user2) {
      return $user->id == $user2->id;
    }

    public function review(User $user, Product $product) {
        if($product->reviews->where('user_id', $user->id)->count() > 0)
          return false;

      $purchases = $user->purchases;
      foreach($purchases as $purchase) {
        if(($purchase->products->where('id', $product->id))->count() > 0)
          return true;
      }
      return false;
    }
}
?>