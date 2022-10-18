<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Device;
use App\Models\Room;
use Illuminate\Http\Request;

class DeviceController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
        $devices = auth()->user()->devices;
        if($devices == json_encode([])){
            return response()->json(['message' => 'have no device']);
        }
        return response()->json(
            $devices);
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
            'room_id' => 'required',
            'name' => 'required',
            'tipe' => 'required',
            'state' => 'required'
        ]);

        if(!Room::find($request->room_id)){
            return response()->json([
                'success' => false,
                'message' => 'room not found'
            ]);
        }
 
        $device = new Device();
        $device->room_id = $request->room_id;
        $device->name = $request->name;
        $device->tipe = $request->tipe;
        $device->state = $request->state;
        
 
        if (auth()->user()->devices()->save($device))
            return response()->json([
                'success' => true,
                'data' => $device->toArray()
            ]);
        else
            return response()->json([
                'success' => false,
                'message' => 'Post not added'
            ], 500);
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Device  $device
     * @return \Illuminate\Http\Response
     */
    public function show(Device $device)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Device  $device
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        //
        $device = auth()->user()->devices()->find($id);
 
        if (!$device) {
            return response()->json([
                'success' => false,
                'message' => 'device not found'
            ], 400);
        }
 
        $updated = $device->fill($request->all())->save();
 
        if ($updated)
            return response()->json([
                'success' => true
            ]);
        else
            return response()->json([
                'success' => false,
                'message' => 'device can not be updated'
            ], 500);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Device  $device
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
        $device = auth()->user()->devices()->find($id);
 
        if (!$device) {
            return response()->json([
                'success' => false,
                'message' => 'device not found'
            ], 400);
        }
 
        if ($device->delete()) {
            return response()->json([
                'success' => true
            ]);
        } else {
            return response()->json([
                'success' => false,
                'message' => 'device can not be deleted'
            ], 500);
        }
    }
}
