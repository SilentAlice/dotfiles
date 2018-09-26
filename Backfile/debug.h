#ifndef NX_DEBUG_H
#define NX_DEBUG_H

//#include <stdio.h>
//#include <stdlib.h>

/* #define DEBUG */ /* define DEBUG VERSION_NUM */
#define ALICE_DEBUG 7

/* #define TERMINAL_DEBUG */
#define KERNEL_DEBUG 

/* Only used in terminals */
#ifdef TERMINAL_DEBUG
#define ERROR   0
#define WARN    1
#define INFO    2
#define LOG     3
#define GOOD    4

/* colors for different debug level
 * HILI uses xterm-256color and may not display
 * correctly on legacy terminals */
#define ERROR_COLOR  "\e[1;31m"
#define GOOD_COLOR   "\e[1;32m"
#define WARN_COLOR   "\e[1;33m"
#define INFO_COLOR   "\e[1;34m"
#define LOG_COLOR    "\e[1;37m"
#define FNAME_COLOR(x)  "\e[1;34m" x "\e[0m"
#define LINUM_COLOR(x)  "\e[1;35m" x "\e[0m"
#define HILI_COLOR   "\e[48;5;220m\e[30;22m"
#define dprintf(level, fmt, ...)                                        \
    do {                                                                \
	    if (DEBUG) { \
        fprintf(stderr, level##_COLOR "[%s:%d] %s: " fmt "\e[0m\n",     \
                __FILE__, __LINE__, __FUNCTION__, ##__VA_ARGS__);       \
	    }\
    } while (0)

#define die(fmt, ...)                                                   \
    do {                                                                \
        fprintf(stderr, ERROR_COLOR "[%s:%d] %s: " fmt "\e[0m\n",       \
                __FILE__, __LINE__, __FUNCTION__, ##__VA_ARGS__);       \
        exit(1);                                                        \
    } while (0)

#define BUG_ON_NZ(x) do { if ( (x)) die("error: " #x " failed (returned non-zero)." ); } while (0)
#define BUG_ON_Z(x)  do { if (!(x)) die("error: " #x " failed (returned zero/null)."); } while (0)

#define cpu_relax() ({asm("pause\n\t":::"memory");})
#define barrier() ({asm("":::"memory");})
#endif /* TERMINAL_DEBUG */

#ifdef KERNEL_DEBUG
#define wprintk(version, fmt, ...)                                      \
    do {                                                                \
	    if (ALICE_DEBUG <= version) {                                         \
        printk("[%s:%d] %s: " fmt,                                      \
                __FILE__, __LINE__, __FUNCTION__, ##__VA_ARGS__);       \
	    }                                                               \
    } while (0)

#define wwarn(version)                                                  \
    do {                                                                \
        if (ALICE_DEBUG <= version) {                                         \
            WARN_ON(1);                                                  \
        }                                                               \
    } while (0)

#endif /* KERNEL_DEBUG */

#endif /* SS_DEBUG_H */
