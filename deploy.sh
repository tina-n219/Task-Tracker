#!/bin/bash

cd assets 
export MIX_ENV=prod
export PORT=4747
npm install
node_modules/.bin/webpack --mode production
cd ..
mix phx.digest
mix compile
mix release --env=prod

mix ecto.reset
#echo "Stopping old copy of app, if any..."
#_build/prod/rel/draw/bin/practice stop || true

echo "Starting app..."

_build/prod/rel/taskTracker/bin/taskTracker start

