/**
 * @file vga.h
 * @brief VGA text and graphics mode driver header
 *
 * Provides functions to manage text output on a VGA display in text mode (80x25) and graphics mode (320x200).
 */

#pragma once

#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

/* VGA text mode buffer dimensions */
#define VGA_TEXT_WIDTH (size_t)80
#define VGA_TEXT_HEIGHT (size_t)25

/* VGA text mode buffer address */
#define VGA_TEXT_MODE_BUFFER (uint16_t*)0xB8000

/* VGA graphics mode buffer dimensions */
#define VGA_GRAPHICS_WIDTH (size_t)320
#define VGA_GRAPHICS_HEIGHT (size_t)200

/* VGA graphics mode buffer address */
#define VGA_GRAPHICS_MODE_BUFFER (uint32_t*)0xA0000

/* Begin typedef declarations */

/* Represents the mode of the VGA */
typedef enum VgaMode {
  VGA_MODE_TEXT = 0,
  VGA_MODE_GRAPHICS = 1,
} VgaMode;

/* Represents the colors available in the VGA text mode */
typedef enum VgaTextModeColor {
  VGA_COLOR_BLACK = 0,
  VGA_COLOR_BLUE = 1,
  VGA_COLOR_GREEN = 2,
  VGA_COLOR_CYAN = 3,
  VGA_COLOR_RED = 4,
  VGA_COLOR_MAGENTA = 5,
  VGA_COLOR_BROWN = 6,
  VGA_COLOR_LIGHT_GREY = 7,
  VGA_COLOR_DARK_GREY = 8,
  VGA_COLOR_LIGHT_BLUE = 9,
  VGA_COLOR_LIGHT_GREEN = 10,
  VGA_COLOR_LIGHT_CYAN = 11,
  VGA_COLOR_LIGHT_RED = 12,
  VGA_COLOR_LIGHT_MAGENTA = 13,
  VGA_COLOR_LIGHT_BROWN = 14,
  VGA_COLOR_WHITE = 15,
} VgaTextModeColor;

/* Represents a text mode driver for the VGA */
typedef struct VgaTextModeDriver {
    /* The row of the text mode */
    size_t row;
    /* The column of the text mode */
    size_t column;
    /* The color of the text mode */
    uint8_t color;
    /* The buffer of the text mode */
    uint16_t* buffer;
} VgaTextModeDriver;

/* Begin function prototype declarations */
void vgaTextModeInitialize(void);
uint8_t vgaTextModeEntryColor(VgaTextModeColor fg, VgaTextModeColor bg);
uint16_t vgaTextModeEntry(unsigned char ch, uint8_t color);
void vgaTextModeSetColor(VgaTextModeColor color);
void vgaTextModePutChar(char ch);
void vgaTextModePutEntry(char ch, uint8_t color, size_t x, size_t y);
void vgaTextModeWrite(const char* str);
void vgaTextModeClear(void);
void vgaTextModeScroll(void);

/* Begin inline function declarations */
inline size_t strlen(const char* str) {
  size_t len = 0;
  while (str[len]) len++;
  return len;
}