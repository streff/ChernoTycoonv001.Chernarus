// -----------------------------------------------------------------------------
// SPON general macros (#include this file).
//
// Copyright (C) 2007 Bil Bas (bil.bagpuss@gmail.com \ Spooner)
// License: GNU General Public License, version 3 <http://www.gnu.org/licenses/>
//
// Last Modified: $Date: 2007/09/22 12:01:45 $
//
// Description:
//   Useful macros.
//
// -----------------------------------------------------------------------------
// Type-checking macros.
#define SPON_IS_ARRAY(X)   ((typeName (X)) == "ARRAY")
#define SPON_IS_BOOL(X)    ((typeName (X)) == "BOOL")
#define SPON_IS_CODE(X)    ((typeName (X)) == "CODE")
#define SPON_IS_CONFIG(X)  ((typeName (X)) == "CONFIG")
#define SPON_IS_CONTROL(X) ((typeName (X)) == "CONTROL")
#define SPON_IS_DISPLAY(X) ((typeName (X)) == "DISPLAY")
#define SPON_IS_GROUP(X)   ((typeName (X)) == "GROUP")
#define SPON_IS_OBJECT(X)  ((typeName (X)) == "OBJECT")
#define SPON_IS_SCALAR(X)  ((typeName (X)) == "SCALAR")
#define SPON_IS_SCRIPT(X)  ((typeName (X)) == "SCRIPT")
#define SPON_IS_SIDE(X)    ((typeName (X)) == "SIDE")
#define SPON_IS_STRING(X)  ((typeName (X)) == "STRING")
#define SPON_IS_TEXT(X)    ((typeName (X)) == "TEXT")

#define SPON_IS_INTEGER(X)  (SPON_IS_SCALAR(X) and (floor(X) == X))

// -----------------------------------------------------------------------------
// Splitting an array into a number of variables.
#define SPON_EXPLODE_2(X,A,B) \
	A = X select 0; B = X select 1
	
#define SPON_EXPLODE_3(X,A,B,C) \
	A = X select 0; B = X select 1; C = X select 2
	
#define SPON_EXPLODE_4(X,A,B,C,D) \
	A = X select 0; B = X select 1; C = X select 2; D = X select 3
	
#define SPON_EXPLODE_5(X,A,B,C,D,E) \
	SPON_EXPLODE_4(X,A,B,C,D); E = X select 4;
	
#define SPON_EXPLODE_6(X,A,B,C,D,E,F) \
	SPON_EXPLODE_4(X,A,B,C,D); E = X select 4; F = X select 5
	
#define SPON_EXPLODE_7(X,A,B,C,D,E,F,G) \
	SPON_EXPLODE_4(X,A,B,C,D); E = X select 4; F = X select 5; G = X select 6
	
#define SPON_EXPLODE_8(X,A,B,C,D,E,F,G,H) \
	SPON_EXPLODE_4(X,A,B,C,D); E = X select 4; F = X select 5; G = X select 6; H = X select 7

// -----------------------------------------------------------------------------
// Getting parameters passed to a code block (function).
#define SPON_GET_PARAMS_1(A) \
	private 'A'; A = _this select 0
	
#define SPON_GET_PARAMS_2(A,B) \
	private ['A', 'B']; SPON_EXPLODE_2(_this,A,B)
	
#define SPON_GET_PARAMS_3(A,B,C) \
	private ['A', 'B', 'C']; SPON_EXPLODE_3(_this,A,B,C)
	
#define SPON_GET_PARAMS_4(A,B,C,D) \
	private ['A', 'B', 'C', 'D']; SPON_EXPLODE_4(_this,A,B,C,D)
	
#define SPON_GET_PARAMS_5(A,B,C,D,E) \
	private ['A', 'B', 'C', 'D', 'E']; SPON_EXPLODE_5(_this,A,B,C,D,E)
	
#define SPON_GET_PARAMS_6(A,B,C,D,E,F) \
	private ['A', 'B', 'C', 'D', 'E', 'F']; SPON_EXPLODE_6(_this,A,B,C,D,E,F)
	
#define SPON_GET_PARAMS_7(A,B,C,D,E,F,G) \
	private ['A', 'B', 'C', 'D', 'E', 'F', 'G']; SPON_EXPLODE_7(_this,A,B,C,D,E,F,G)
	
#define SPON_GET_PARAMS_8(A,B,C,D,E,F,G,H) \
	private ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H']; SPON_EXPLODE_8(_this,A,B,C,D,E,F,G,H)

	
#define SPON_GET_DEFAULT_PARAM(INDEX,NAME,DEF_VALUE) \
	private 'NAME'; \
	if (isNil {_this}) then \
	{ \
		NAME = DEF_VALUE; \
	} \
	else \
	{ \
		if ((count _this) > INDEX) then \
		{ \
			if (isNil {_this select INDEX}) then \
			{ \
				NAME = DEF_VALUE; \
			} \
			else \
			{ \
				NAME = _this select INDEX; \
			}; \
		} \
		else \
		{ \
			NAME = DEF_VALUE; \
		}; \
	};
	
// -----------------------------------------------------------------------------
// Array operations.
#define SPON_PUSH(ARRAY,VALUE) ARRAY resize ((count ARRAY) + 1); ARRAY set [(count ARRAY) - 1, VALUE]
#define SPON_LAST(ARRAY) (ARRAY select ((count ARRAY) - 1))

// Some commonly used vehicle-checking operations.
#define SPON_IN_VEHICLE(X) ((vehicle X) != X)
#define SPON_IS_DRIVING(X) (SPON_IN_VEHICLE(X) and ((driver (vehicle X)) == X))
#define SPON_ON_FOOT(X) ((vehicle X) == X)

// Wait until the player has properly synched in MP.
#define SPON_WAIT_FOR_PLAYER_SYNC() \
if ((not isServer) and (isNull player)) then \
{ \
	waitUntil { not (isNull player); }; \
	waitUntil { time > 10; }; \
}