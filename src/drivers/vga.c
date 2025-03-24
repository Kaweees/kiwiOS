/**
 * @file vga.c
 * @brief VGA text and graphics mode driver implementation
 *
 * Provides functions to manage text output on a VGA display in text mode (80x25) and graphics mode (320x200).
 */

#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

#include "../../include/kernel/drivers/vga.h"

static VgaTextModeDriver vga_text_mode_driver;

/**
 * @brief Initializes the VGA text mode driver.
 * */
void vgaTextModeInitialize(void) {
  vga_text_mode_driver.row = 0;
  vga_text_mode_driver.column = 0;
  vga_text_mode_driver.color = vgaTextModeEntryColor(VGA_COLOR_GREEN, VGA_COLOR_BLACK);
  vga_text_mode_driver.buffer = VGA_TEXT_MODE_BUFFER;
  vgaTextModeClear();
}

/**
 * @brief Sets the foreground and background colors for the text mode
 * */
uint8_t vgaTextModeEntryColor(VgaTextModeColor fg, VgaTextModeColor bg) { return fg | bg << 4; }

/**
 * @brief Writes a character to the text mode
 * */
uint16_t vgaTextModeEntry(unsigned char ch, uint8_t color) { return (uint16_t)ch | (uint16_t)color << 8; }

/**
 * @brief Sets the color of the text mode
 *
 * Sets the color of the text mode to the color passed in.
 * */
void vgaTextModeSetColor(VgaTextModeColor color) { vga_text_mode_driver.color = color; }

/**
 * @brief Puts a character to the text mode
 *
 * Puts a character to the text mode at the current cursor position.
 * */
void vgaTextModePutChar(char c) {
  vga_text_mode_driver.buffer[vga_text_mode_driver.row * VGA_TEXT_WIDTH + vga_text_mode_driver.column] =
      vgaTextModeEntry(c, vga_text_mode_driver.color);
  if (++vga_text_mode_driver.column == VGA_TEXT_WIDTH) {
    vga_text_mode_driver.column = 0;
    if (++vga_text_mode_driver.row == VGA_TEXT_HEIGHT) vga_text_mode_driver.row = 0;
  }
}

/**
 * @brief Puts an entry to the text mode
 *
 * Puts an entry to the text mode at the current cursor position.
 * */
void vgaTextModePutEntry(char ch, uint8_t color, size_t x, size_t y) {
  const size_t index = y * VGA_TEXT_WIDTH + x;
  vga_text_mode_driver.buffer[index] = vgaTextModeEntry(ch, color);
}

/**
 * @brief Writes a string to the text mode
 *
 * Writes a string to the text mode.
 * */
void vgaTextModeWrite(const char* str) {
  for (size_t i = 0; i < strlen(str); i++) vgaTextModePutChar(str[i]);
}

/**
 * @brief Clears the screen and resets the cursor.
 * */
void vgaTextModeClear(void) {
  for (size_t y = 0; y < VGA_TEXT_HEIGHT; y++) {
    for (size_t x = 0; x < VGA_TEXT_WIDTH; x++) {
      const size_t index = y * VGA_TEXT_WIDTH + x;
      vga_text_mode_driver.buffer[index] = vgaTextModeEntry(' ', vga_text_mode_driver.color);
    }
  }
}

/**
 * @brief Scrolls the screen up by one line.
 *
 * */
void vgaTextModeScroll(void) {
  for (size_t y = 0; y < VGA_TEXT_HEIGHT; y++) {
    for (size_t x = 0; x < VGA_TEXT_WIDTH; x++) {
      const size_t index = y * VGA_TEXT_WIDTH + x;
      vga_text_mode_driver.buffer[index] = vga_text_mode_driver.buffer[index + VGA_TEXT_WIDTH];
    }
  }
}
