// -----------------------------------------------------------------------------
// SPON debug log macros (#include this file).
//
// Copyright (C) 2007 Bil Bas (bil.bagpuss@gmail.com \ Spooner)
// License: GNU General Public License, version 3 <http://www.gnu.org/licenses/>
//
// Last Modified: $Date: 2007/09/14 13:06:56 $
//
// Description:
//   Tracing macros related to SPON Core debugging.
//
// -----------------------------------------------------------------------------
#ifdef SPON_THIS_FILE
#define SPON_TRACE_PRE [SPON_THIS_FILE] 
#endif
// #else	
#ifndef SPON_THIS_FILE
#define SPON_TRACE_PRE
#endif

// Trace with just a simple message.
#define SPON_TRACE(TEXT) \
	if SPON_debugMode then { [format ['SPON_TRACE_PRE%1', TEXT]] call SPON_debugAppendLog; }
	
// Trace with a message and 1-8 variables to show.
#define SPON_TRACE_1(TEXT,A) \
	if SPON_debugMode then { [format ['SPON_TRACE_PRE%1: A=%2', TEXT, A]] call SPON_debugAppendLog; }
	
#define SPON_TRACE_2(TEXT,A,B) \
	if SPON_debugMode then { [format ['SPON_TRACE_PRE%1: A=%2, B=%3', TEXT, A, B]] call SPON_debugAppendLog; }
	
#define SPON_TRACE_3(TEXT,A,B,C) \
	if SPON_debugMode then { [format ['SPON_TRACE_PRE%1: A=%2, B=%3, C=%4', TEXT, A, B, C]] call SPON_debugAppendLog; }
	
#define SPON_TRACE_4(TEXT,A,B,C,D) \
	if SPON_debugMode then { [format ['SPON_TRACE_PRE%1: A=%2, B=%3, C=%4, D=%5', TEXT, A, B, C, D]] call SPON_debugAppendLog; }
	
#define SPON_TRACE_5(TEXT,A,B,C,D,E) \
	if SPON_debugMode then { [format ['SPON_TRACE_PRE%1: A=%2, B=%3, C=%4, D=%5, E=%6', TEXT, A, B, C, D, E]] call SPON_debugAppendLog; }
	
#define SPON_TRACE_6(TEXT,A,B,C,D,E,F) \
	if SPON_debugMode then { [format ['SPON_TRACE_PRE%1: A=%2, B=%3, C=%4, D=%5, E=%6, F=%7', TEXT, A, B, C, D, E, F]] call SPON_debugAppendLog; }
	
#define SPON_TRACE_7(TEXT,A,B,C,D,E,F,G) \
	if SPON_debugMode then { [format ['SPON_TRACE_PRE%1: A=%2, B=%3, C=%4, D=%5, E=%6, F=%7, G=%8', TEXT, A, B, C, D, E, F, G]] call SPON_debugAppendLog; }
	
#define SPON_TRACE_8(TEXT,A,B,C,D,E,F,G,H) \
	if SPON_debugMode then { [format ['SPON_TRACE_PRE%1: A=%2, B=%3, C=%4, D=%5, E=%6, F=%7, G=%8, H=%9', TEXT, A, B, C, D, E, F, G, H]] call SPON_debugAppendLog; }
	
