<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Room;
use Illuminate\Http\Request;

class RoomController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
        $rooms = auth()->user()->rooms;
        if($rooms == json_encode([])){
            return response()->json(['message' => 'have no room']);
        }
        return response()->json($rooms);

    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        //
        $this->validate($request, [
            'name' => 'required',
            'desc' => 'required',
            'tipe' => 'required'
        ]);
 
        $room = new Room();
        $room->name = $request->name;
        $room->desc = $request->desc;
        $room->tipe = $request->tipe;
 
        if (auth()->user()->rooms()->save($room))
            return response()->json([
                'success' => true,
                'data' => $room->toArray()
            ]);
        else
            return response()->json([
                'success' => false,
                'message' => 'room not added'
            ], 500);
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Room  $room
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
        $room = auth()->user()->rooms()->find($id);
 
        if (!$room) {
            return response()->json([
                'success' => false,
                'message' => 'room not found '
            ], 400);
        }
 
        return response()->json($room->toArray()
        , 400);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Room  $room
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        //
        $room = auth()->user()->rooms()->find($id);
 
        if (!$room) {
            return response()->json([
                'success' => false,
                'message' => 'room not found'
            ], 400);
        }
 
        $updated = $room->fill($request->all())->save();
 
        if ($updated)
            return response()->json([
                'success' => true
            ]);
        else
            return response()->json([
                'success' => false,
                'message' => 'room can not be updated'
            ], 500);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Room  $room
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
        $room = auth()->user()->rooms()->find($id);
 
        if (!$room) {
            return response()->json([
                'success' => false,
                'message' => 'room not found'
            ], 400);
        }
 
        if ($room->delete()) {
            return response()->json([
                'success' => true
            ]);
        } else {
            return response()->json([
                'success' => false,
                'message' => 'room can not be deleted'
            ], 500);
        }
    }

    
    public function getDevices($id){
        $room = auth()->user()->rooms()->find($id);
        
        try {
            //code...
            $devices = $room->devices;
        } catch (\Throwable $th) {
            //throw $th;
            return response()->json(['message' => 'have no device']);
        }
        
        return response()->json($devices);
    }
}
