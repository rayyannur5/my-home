<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;

class AuthController extends Controller
{

    public function index(){
        return auth()->user();
    }

    public function update(Request $request){
        // dd($request->name);
        
        if($request->name != null){
            $this->validate($request, [
                'name' => 'required|min:4'
            ]);
    
            $user = auth()->user();
            $user->update([
                'name' => $request->name
            ]);      
        }
        if($request->email != null){
            $this->validate($request, [
                'email' => 'required|email'
            ]);
    
            $user = auth()->user();
            $user->update([
                'email' => $request->email
            ]);      
        }
        if($request->password != null){
            $this->validate($request, [
                'password' => 'required|min:8'
            ]);
    
            $user = auth()->user();
            $user->update([
                'password' => bcrypt($request->password)
            ]);      
        }

        return auth()->user();
    }
    public function register(Request $request)
    {
        $this->validate($request, [
            'name' => 'required|min:4',
            'email' => 'required|email',
            'password' => 'required|min:8',
        ]);
 
        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => bcrypt($request->password)
        ]);
       
        $token = $user->createToken('LaravelAuthApp')->accessToken;
 
        return response()->json(['token' => $token], 200);
    }
 
    /**
     * Login
     */
    public function login(Request $request)
    {
        $data = [
            'email' => $request->email,
            'password' => $request->password
        ];
 
        if (auth()->attempt($data)) {
            $token = auth()->user()->createToken('LaravelAuthApp')->accessToken;
            return response()->json(['token' => $token, 'message' => 'success', 'user' => auth()->user()], 200);
        } else {
            return response()->json(['message' => 'Unauthorised'], 401);
        }
    }  

    public function logout()
    { 
        auth()->user()->token()->revoke();
        return response()->json(['logout' => 'success'], 200);
        
    }
    public function checkPassword(Request $request)
    { 
        $this->validate($request, [
            'password' => 'required|min:8'
        ]);
        
        if(password_verify($request->password, auth()->user()->password)){
            return response()->json([
            'message' => 'match'], 200);
            
        }else {
            
            return response()->json(['message' => 'not match'], 200);
        }

    }
}
