//
//  SharedSystemTypes.h
//  
//
//  Created by Tom Salvo on 10/24/21.
//

#ifndef SHSharedSystemTypes_h
#define SHSharedSystemTypes_h

#if TARGET_OS_IOS
#define SH_SYSTEM_COLOR_TYPE UIColor
#define SH_SYSTEM_FONT_TYPE UIFont
#else
#define SH_SYSTEM_COLOR_TYPE NSColor
#define SH_SYSTEM_FONT_TYPE NSFont
#endif

#endif /* SharedSystemTypes_h */
