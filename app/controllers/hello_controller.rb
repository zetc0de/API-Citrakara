class HelloController < ApplicationController
    def index 
       @hello = {
           "hello" => "hello world"}
        render json: @hello
    end
end
