/*
    client.c - Load tester using threads to issue multiple HTTP requests.

    This sample demonstrates retrieving content using the HTTP GET method with threads.

    Copyright (c) All Rights Reserved. See copyright notice at the bottom of the file.
 */
/***************************** Includes *******************************/

#include    "appweb.h"

/*
    Please change this to a local URL to test against
 */
#define TEST_URL "http://example.com/index.html"
#define TEST_THREADS 1
#define TEST_ITERATIONS 1
#define TEST_POST_DATA "Hello Post"

static int threadCount = 0;

/******************************** Forwards ****************************/

static int request(HttpConn *conn);
static void threadMain(void *data, MprThread *thread);

/********************************* Code *******************************/

MAIN(simpleClient, int argc, char **argv, char **envp)
{
    MprThread   *tp;
    int         i;

    /*
       Create the Multithreaded Portable Runtime and start it.
       Initialize the HTTP subsystem for client requests
     */
    mprCreate(argc, argv, MPR_USER_EVENTS_THREAD);
    httpCreate(HTTP_CLIENT_SIDE);

    /*
        Enable if you would like logging and request tracing

        mprStartLogging("stdout:6", 0);
        httpStartTracing("stdout:6");
     */

    mprStart();

    /*
        Create and start the threads. Each thread will issue one http request.
     */
    for (i = 0; i < TEST_THREADS; i++) {
        tp = mprCreateThread("test-thread", threadMain, NULL, 0);
        mprStartThread(tp);
    }

    /*
        Service requests until instructed to exit by the call to mprShutdown
     */
    mprServiceEvents(-1, 0);
    mprDestroy();
    return 0;
}


/*
    Main program for each thread
 */
static void threadMain(void *data, MprThread *thread)
{
    MprDispatcher   *dispatcher;
    HttpConn        *conn;
    int             i;

    if ((dispatcher = mprCreateDispatcher("httpRequest", 0)) == 0) {
        mprError("Cannot create dispatcher");
        return;
    }
    mprStartDispatcher(dispatcher);

    /*
        Create a connection object for the network connection for this thread.
     */
    if ((conn = httpCreateConn(NULL, dispatcher)) == 0) {
        mprError("Cannot create connection");
        mprDestroyDispatcher(dispatcher);
        return;
    }
    for (i = 0; i < TEST_ITERATIONS; i++) {
        if (request(conn) < 0) {
            mprError("Can't get URL");
            return;
        }
    }
    httpDestroyConn(conn);
    mprDestroyDispatcher(dispatcher);

    /*
        All threads run in parallel, so need a mutex here so threadCount will be accurate.
     */
    mprGlobalLock();
    if (--threadCount <= 0) {
        mprShutdown(MPR_EXIT_NORMAL, 0, 0);
    }
    mprGlobalUnlock();
}


/*
    Issue a test request on a thread
 */
static int request(HttpConn *conn)
{
    cchar           *data;
    ssize           len;

    /*
       Connect and issue the request. Then finalize the request output - this forces the request out.
     */
    if (httpConnect(conn, "POST", TEST_URL, NULL) < 0) {
        mprError("Cannot connect to %s", TEST_URL);
        return MPR_ERR_CANT_CONNECT;
    }
    data = TEST_POST_DATA;
    if (data) {
        len = slen(data);
        if (httpWriteBlock(conn->writeq, data, len, HTTP_BLOCK) != len) {
            mprError("Cannot write request body data");
            return MPR_ERR_CANT_WRITE;
        }
    }
    httpFinalizeOutput(conn);

    if (httpWait(conn, HTTP_STATE_CONTENT, MPR_MAX_TIMEOUT) < 0) {
        mprError("No response");
        return MPR_ERR_BAD_STATE;
    }
    if (httpGetStatus(conn) != 200) {
        mprError("Server responded with status %d\n", httpGetStatus(conn));
        return MPR_ERR_BAD_STATE;
    }
    mprPrintf("%s\n", httpReadString(conn));
    return 0;
}

/*
    Copyright (c) Embedthis Software. All Rights Reserved.
    This software is distributed under commercial and open source licenses.
    You may use the Embedthis Open Source license or you may acquire a
    commercial license from Embedthis Software. You agree to be fully bound
    by the terms of either license. Consult the LICENSE.md distributed with
    this software for full details and other copyrights.
 */
