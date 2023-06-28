<?php

namespace App\Http\Controllers;

use App\Models\Category;
use Illuminate\Http\Request;
use App\Http\Resources\CategoryResource;

class CategoryController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $data = Category::all();
        return $data;
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
            'id' => 'required',
            'category_name' => 'required'
        ]);
        $response = Category::create($request->all());
        $response->save();
        return response()->json([
            'success' => true,
            'message' => 'success'
        ]);
    }

    /**
     * Display the specified resource.
     */
    public function show(Category $category, Request $request, $id)
    {
        $dataId = Category::find($id);
        return new CategoryResource($dataId);
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Category $category)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Category $category, $id)
    {
        $validasi=$request->validate([
            'id' => 'required',
            'category_name' => 'required'
        ]);
        $categoryId=Category::find($id);

        $categoryId->id = $request->input('id');
        $categoryId->category_name = $request->input('category_name');
        $categoryId->save();
        return response()->json([
            'message' => 'Data berhasil di update',
            'data' => $categoryId
        ]);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Category $category, $id)
    {
        $categoryId=Category::find($id);
        $categoryId->delete();
        return response()->json([
            'message' => 'Data berhasil dihapus'
        ]);
    }
}
