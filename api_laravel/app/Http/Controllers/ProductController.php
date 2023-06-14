<?php

namespace App\Http\Controllers;

use App\Models\Product;
use App\Http\Resources\ProductResource;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class ProductController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $data = Product::paginate(5);
        $products =  ProductResource::collection($data);

        // Tambahkan kode untuk mengakses data gambar
        foreach ($products as $product) {
            $product->image = $this->getImageUrl($product->image);
        }

        return $products;
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        
        $validasi=$request->validate([
            'user_id' => 'required',
            'category_id' => 'required',
            'title' => 'required',
            'desc' => 'required',
            'file' => 'required',
            'price' => 'required'
        ]);

        if($request->file) {
            $fileName = $this->generateRandomString();
            $extension = $request->file->extension();

            Storage::putFileAs('photos', $request->file, $fileName.'.'.$extension);
        }

        
        $request['image'] = $fileName.'.'.$extension;
        $response = Product::create($request->all());
        $response->save();
        return response()->json([
            'success' => true,
            'message' => 'success'
        ]);

       
    }

    /**
     * Display the specified resource.
     */
    public function show(Product $product, Request $request, $id)
    {
        $dataId = Product::find($id);
        return $dataId;

    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Product $product)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Product $product, $id)
    {
        $validasi=$request->validate([
            'user_id' => 'required',
            'category_id' => 'required',
            'title' => 'required',
            'desc' => 'required',
            'file' => 'required',
            'price' => 'required'
        ]);
        $productId=Product::find($id);

        $fileName = $this->generateRandomString();
        $extension = $request->file->extension();

        if (!$productId->image) {
            Storage::delete('photos/' .$productId->image);
        }

        Storage::putFileAs('photos', $request->file, $fileName.'.'.$extension);
        $productId->user_id = $request->input('user_id');
        $productId->category_id = $request->input('category_id');
        $productId->title = $request->input('title');
        $productId->desc = $request->input('desc');
        $productId->image = $fileName.'.'.$extension;
        $productId->price = $request->input('price');
        $productId->save();
        return response()->json([
            'message' => 'Data berhasil di update',
            'data' => $productId
        ]);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Product $product, $id)
    {
        $productId=Product::find($id);
        if (!$productId->image) {
           Storage::delete('photos/'.$productId->image);
        }
        $productId->delete();
        return response()->json([
            'message' => 'Data berhasil dihapus'
        ]);
    }


    public function showImages($fileName) {
        $path = storage_path('app/photos/' . $fileName);
        
        if (!file_exists($path)) {
            return response()->json(['message' => 'Image not found.'], 404);
        }

        $fileNameOnly = basename($fileName);

        $file = file_get_contents($path);
        $type = mime_content_type($path);

        return response($file, 200)->header('Content-Type', $type);
    }



    function generateRandomString($length = 20) {
        $characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
        $charactersLength = strlen($characters);
        $randomString = '';
        for ($i = 0; $i < $length; $i++) {
            $randomString .= $characters[random_int(0, $charactersLength - 1)];
        }
        return $randomString;
    }

    private function getImageUrl($filename)
    {
        $path = 'photos/' . $filename;
        if (Storage::exists($path)) {
            return Storage::url($path);
        }

        return null;
    }
}
