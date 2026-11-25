Below is a step-by-step test procedure for your Racket chat application. We'll test each feature independently so that if something breaks, we know where to look.

Use **three terminal windows**:

- Terminal 1: Server
- Terminal 2: Client Bob
- Terminal 3: Client Alice

All commands assume you're using macOS and your project is in `labs/week10`.

## **1. Start the server**

**Terminal 1:**

```
cd labs/week10
racket -i -e '(require "server.rkt") (start-server 5555)'
```

Expected:

```
Server listening on port 5555
'okay
```

Leave this terminal running.

## **2. Connect two clients**

**Terminal 2:**

```
racket -i -e "(require \"client.rkt\") (im-enroll \"127.0.0.1\" 5555 'alice)"
```

**Terminal 3:**

```
racket -i -e "(require \"client.rkt\") (im-enroll \"127.0.0.1\" 5555 'bob)"
```

Expected:

- Both clients successfully log in.
- The server logs both registrations.
- Both clients receive updated client lists.

## **3. Test duplicate usernames**

Open a fourth terminal:

```
racket -i -e "(require \"client.rkt\") (im-enroll \"127.0.0.1\" 5555 'bob)"
```

Expected:

```
Sending hello...
Connection closed.
Username already in use
```

This confirms that duplicate usernames are rejected.

## **4. Test private messaging**

Go to Terminal 2 (Bob):

```
(im 'alice "Hello Alice!")
```

Expected in Terminal 3 (Alice):

```
Message from bob:
    Hello Alice!
```

Now reply from Alice:

```
(im 'bob "Hi Bob!")
```

Expected in Bob's terminal:

```
Message from alice:
    Hi Bob!
```



Pass condition

&#x20;Both clients can exchange private messages.



## **5. Test an unknown recipient**

In Bob's terminal:

```
(im 'charlie "Are you there?")
```

Expected:

```
Message from server:
    User not found: charlie
```

The server should continue running.

## **6. Test client logout**

In Alice's terminal:

```
(im-exit)
```

Expected:

- Alice disconnects.
- Bob receives an updated client list.
- Alice disappears from the server's client registry.

Check the server terminal for the removal message.

## **7. Test unexpected disconnection**

Reconnect Alice:

```
(im-enroll "127.0.0.1" 5555 'alice)
```

Then terminate Alice's Racket process using `Ctrl+C`.

Check the server terminal.

Expected:

- Server detects the disconnected socket.
- Alice is removed from the client registry.
- Bob receives an updated client list.

This is an important test because users don't always log out properly.

## **8. Test server shutdown**

With Bob and Alice connected, go to Terminal 1 and execute:

```
(stop-server)
```

Expected:

- Server announces shutdown.
- Connected clients receive a goodbye message or detect connection closure.
- Server closes its listening socket.
- Client connections are terminated.

## **9. Test reconnection**

Start the server again:

```
(start-server 5555)
```

Then reconnect Bob:

```
(im-enroll "127.0.0.1" 5555 'bob)
```

Expected: Bob can log in again without a duplicate-username error.
