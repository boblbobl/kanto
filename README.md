# Getting Started
The following is the quick guide to getting started running Kanto on your local development environment.

## Spin up Elastic Search

Elastic Search is currently installed here (on my machine):
```/usr/local/share/elasticsearch-0.90.2```

Run Elatic Search with the ```-f``` parameter:
```bin/elasticsearch -f```

## Update node packages

Install the required Node.js dependencies with npm:
```npm update```

## Finally start a Node.js server

The server itself is written in Coffee Script, so use the following command to start the server:
```coffee server.coffee```

And that's is, visit [http://localhost:3000](http://localhost:3000) and see Kanto in action.