@verbatim
<div class="review-item row col-12 ml-0">
    <div class="col-xl-2 col-lg-2 col-md-3 col-sm-4 col-xs-12">
        <div class="d-flex flex-column align-items-start">
            <div class="stars">
            <input type="hidden" value="{{score}}"> 
                <div class="stars-outer">
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <div class="stars-inner">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                    </div>
                </div>
            </div>
        </div>
        <div class="review-info">
            <p>By
                <strong>{{user.name}}</strong>
            </p>
            <p>{{date}}</p>

        </div>
    </div>
    <div class="col-xl-10 col-lg-10 col-md-9 col-sm-8 col-xs-12">
        <div class="d-flex flex-column align-items-start review_comment">
            <h1>{{title}}</h1>
            <p>{{content}}</p>
        </div>
    </div>
    {{#owner}}
    <div class="d-flex flex-row align-items-end col-12">
        <a class="ml-auto mr-3" onclick="editReview({{product_id}}, {{id}}, '{{title}}', '{{content}}', {{score}})" data-toggle="modal" data-target="#giveOpinionModal">
            <i class="fas fa-lg fa-pencil-alt "></i>
        </a>
        <a onclick="deleteReview(this, {{id}}, {{product_id}})">
            <i class="fas fa-lg fa-trash-alt"></i>
        </a>
    </div>
    {{/owner}}
</div>
{{#last}}
<hr class="my-4">
{{/last}}
@endverbatim