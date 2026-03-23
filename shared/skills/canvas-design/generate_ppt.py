#!/usr/bin/env python3
"""
Orbital Intelligence - Technical Research Direction Slide
A museum-quality design expressing technology research directions
through concentric geometry, radar aesthetics, and orbital systems.
"""

from reportlab.lib.pagesizes import A4
from reportlab.pdfgen import canvas
from reportlab.lib.utils import ImageReader
from reportlab.pdfbase import pdfmetrics
from reportlab.pdfbase.ttfonts import TTFont
from reportlab.lib.colors import Color, HexColor
from PIL import Image, ImageDraw, ImageFont
import math
import os

# Dimensions
WIDTH, HEIGHT = 1920, 1080  # 16:9 HD
SCALE = 1

# Color palette - deep orbital blues
COLORS = {
    'deep_space': '#030812',
    'midnight': '#071226',
    'atmosphere': '#0f1f3a',
    'cyan_primary': '#00d4ff',
    'cyan_glow': '#00a8cc',
    'electric_blue': '#0066ff',
    'signal': '#00ffaa',
    'alert': '#ff6b35',
    'text_white': '#e8f4fc',
    'text_dim': '#6b8ba3',
    'grid': '#1a2d4a'
}

def create_slide_image():
    """Create the slide as a high-resolution image first"""

    img = Image.new('RGB', (WIDTH, HEIGHT), COLORS['deep_space'])
    draw = ImageDraw.Draw(img)

    # Background gradient effect
    for y in range(HEIGHT):
        factor = y / HEIGHT
        r = int(3 + (7-3) * factor)
        g = int(8 + (18-8) * factor)
        b = int(18 + (38-18) * factor)
        draw.line([(0, y), (WIDTH, y)], fill=f'#{r:02x}{g:02x}{b:02x}')

    # Subtle grid overlay
    grid_spacing = 60
    for x in range(0, WIDTH, grid_spacing):
        alpha = int(5 + 10 * (x / WIDTH))
        draw.line([(x, 0), (x, HEIGHT)], fill=(*HexColor(COLORS['grid']).rgb, alpha), width=1)
    for y in range(0, HEIGHT, grid_spacing):
        draw.line([(0, y), (WIDTH, y)], fill=(*HexColor(COLORS['grid']).rgb, 8), width=1)

    # ========== CONCENTRIC RADAR SYSTEM (Right Side) ==========
    radar_center_x, radar_center_y = 1450, 540
    max_radius = 380

    # Outer glow rings
    for i, radius in enumerate([360, 320, 280, 240, 200, 160, 120, 80]):
        alpha = max(5, 40 - i * 4)
        draw.ellipse([
            radar_center_x - radius, radar_center_y - radius,
            radar_center_x + radius, radar_center_y + radius
        ], outline=(*HexColor(COLORS['electric_blue']).rgb, alpha), width=1)

    # Radar sweep arc
    sweep_angle = 45
    for r in range(40, max_radius, 2):
        angle_start = math.radians(-90)
        angle_end = math.radians(-90 + sweep_angle + r * 0.1)
        alpha = int(60 * (1 - r / max_radius))

        points = []
        for angle in [angle_start + (angle_end - angle_start) * t for t in [i/50 for i in range(51)]]:
            x = radar_center_x + r * math.cos(angle)
            y = radar_center_y + r * math.sin(angle)
            points.append((x, y))

        if len(points) > 1:
            for i in range(len(points) - 1):
                draw.line([points[i], points[i+1]],
                         fill=(*HexColor(COLORS['cyan_primary']).rgb, alpha), width=1)

    # Target blips
    targets = [
        (200, -35, '#00ffaa'),
        (160, 45, '#00ffaa'),
        (280, 70, '#00d4ff'),
        (140, -60, '#ff6b35'),
    ]
    for distance, angle, color in targets:
        rad = math.radians(angle)
        x = radar_center_x + distance * math.cos(rad)
        y = radar_center_y + distance * math.sin(rad)
        # Glow
        for r in range(8, 0, -2):
            draw.ellipse([x-r, y-r, x+r, y+r],
                        outline=(*HexColor(color).rgb, 15 - r*2), width=1)
        # Center
        draw.ellipse([x-3, y-3, x+3, y+3], fill=color)

    # Center point
    draw.ellipse([radar_center_x-15, radar_center_y-15,
                  radar_center_x+15, radar_center_y+15],
                 outline=(*HexColor(COLORS['cyan_primary']).rgb, 60), width=2)
    draw.ellipse([radar_center_x-6, radar_center_y-6,
                  radar_center_x+6, radar_center_y+6],
                 fill=COLORS['cyan_primary'])

    # Crosshairs
    draw.line([(radar_center_x-40, radar_center_y), (radar_center_x+40, radar_center_y)],
              fill=(*HexColor(COLORS['electric_blue']).rgb, 30), width=1)
    draw.line([(radar_center_x, radar_center_y-40), (radar_center_x, radar_center_y+40)],
              fill=(*HexColor(COLORS['electric_blue']).rgb, 30), width=1)

    # ========== SATELLITE ICONS ==========
    def draw_satellite(cx, cy, size, rotation):
        """Draw a stylized satellite"""
        coords = []
        for angle in [rotation + a for a in [0, 45, 90, 135, 180, 225, 270, 315]]:
            rad = math.radians(angle)
            coords.append((
                cx + size * math.cos(rad),
                cy + size * math.sin(rad)
            ))
        # Solar panels
        panel_offset = size * 0.6
        for i in range(4):
            p1 = coords[i * 2]
            p2 = coords[(i * 2 + 1) % 8]
            p3 = coords[(i * 2 + 2) % 8]
            # Draw panel
            mid_x = (p1[0] + p3[0]) / 2
            mid_y = (p1[1] + p3[1]) / 2
            draw.polygon([
                (mid_x + (p2[0]-mid_x)*1.5, mid_y + (p2[1]-mid_y)*1.5),
                (mid_x - (p2[0]-mid_x)*0.5, mid_y - (p2[1]-mid_y)*0.5),
                (p3[0], p3[1])
            ], fill=(*HexColor(COLORS['electric_blue']).rgb, 40), outline=(*HexColor(COLORS['cyan_primary']).rgb, 60))
        # Center body
        draw.ellipse([cx-size*0.3, cy-size*0.3, cx+size*0.3, cy+size*0.3],
                     fill=COLORS['cyan_primary'])

    # Satellites in orbit
    draw_satellite(1200, 180, 25, 15)
    draw_satellite(1650, 250, 18, -30)
    draw_satellite(1700, 800, 20, 60)
    draw_satellite(1300, 900, 15, 120)

    # ========== LEFT SIDE - CONTENT AREA ==========
    content_x = 120
    content_width = 900

    # Title area with accent line
    title_y = 140
    draw.line([(content_x, title_y - 5), (content_x + 180, title_y - 5)],
              fill=COLORS['cyan_primary'], width=4)

    # Main title
    try:
        # Try to use a system font
        from PIL import ImageFont
        title_font = ImageFont.truetype("/System/Library/Fonts/PingFang.ttc", 72)
        label_font = ImageFont.truetype("/System/Library/Fonts/PingFang.ttc", 28)
        small_font = ImageFont.truetype("/System/Library/Fonts/Helvetica.ttc", 14)
        number_font = ImageFont.truetype("/System/Library/Fonts/Helvetica.ttc", 36)
    except:
        title_font = ImageFont.load_default()
        label_font = ImageFont.load_default()
        small_font = ImageFont.load_default()
        number_font = ImageFont.load_default()

    # Draw title
    draw.text((content_x + 10, title_y - 10), "技术攻关方向",
              fill=COLORS['text_white'], font=title_font)

    # Subtitle
    draw.text((content_x + 10, title_y + 65), "KEY TECHNOLOGY DIRECTIONS",
              fill=COLORS['text_dim'], font=small_font)

    # ========== TECH ITEMS ==========
    tech_items = [
        ("01", "新体制雷达系统", "核心"),
        ("02", "星座/巨星座低轨卫星应用", "前沿"),
        ("03", "空天具身智能应用", "创新"),
        ("04", "超物理极限成像", "突破"),
        ("05", "卫星智能计算", "战略"),
    ]

    item_y_start = 280
    item_height = 110

    for i, (num, name, tag) in enumerate(tech_items):
        y = item_y_start + i * item_height

        # Item background - subtle gradient bar
        for x_offset in range(300):
            alpha = int(15 * (1 - x_offset / 300))
            draw.line([(content_x + x_offset, y + 20),
                      (content_x + x_offset, y + 75)],
                      fill=(*HexColor(COLORS['atmosphere']).rgb, alpha), width=1)

        # Left accent bar
        bar_height = 55
        for x in range(4):
            alpha = int(200 - x * 30)
            draw.line([(content_x + x, y + 20),
                      (content_x + x, y + 20 + bar_height)],
                      fill=(*HexColor(COLORS['cyan_primary']).rgb, alpha), width=1)

        # Number
        num_color = (*HexColor(COLORS['electric_blue']).rgb, 80)
        draw.text((content_x + 30, y + 18), num,
                  fill=COLORS['electric_blue'], font=number_font)

        # Tech name
        draw.text((content_x + 100, y + 30), name,
                  fill=COLORS['text_white'], font=label_font)

        # Tag badge
        tag_x = content_x + 750
        tag_y = y + 35
        tag_width = 70
        tag_height = 28

        # Tag background
        draw.rounded_rectangle([tag_x, tag_y, tag_x + tag_width, tag_y + tag_height],
                               radius=14, fill=(*HexColor(COLORS['electric_blue']).rgb, 40))
        draw.rounded_rectangle([tag_x, tag_y, tag_x + tag_width, tag_y + tag_height],
                               radius=14, outline=(*HexColor(COLORS['cyan_primary']).rgb, 100), width=1)

        # Tag text
        tag_font_size = 14
        try:
            tag_font = ImageFont.truetype("/System/Library/Fonts/Helvetica.ttc", tag_font_size)
        except:
            tag_font = small_font
        # Center text in tag
        bbox = tag_font.getbbox(tag)
        text_width = bbox[2] - bbox[0]
        draw.text((tag_x + (tag_width - text_width) // 2, tag_y + 6), tag,
                  fill=COLORS['cyan_primary'], font=tag_font)

    # ========== DECORATIVE BOTTOM ELEMENTS ==========
    bottom_y = HEIGHT - 80

    # Data stream decoration
    for i in range(20):
        x = content_x + i * 45
        height = 10 + (i % 3) * 5
        draw.rectangle([x, bottom_y + 10, x + 20, bottom_y + 10 + height],
                       fill=(*HexColor(COLORS['cyan_primary']).rgb, 20 - i), outline=(*HexColor(COLORS['electric_blue']).rgb, 40))

    # Corner brackets
    bracket_size = 40
    # Top left
    draw.line([(content_x, 100), (content_x, 100 + bracket_size)],
              fill=(*HexColor(COLORS['cyan_primary']).rgb, 50), width=1)
    draw.line([(content_x, 100), (content_x + bracket_size, 100)],
              fill=(*HexColor(COLORS['cyan_primary']).rgb, 50), width=1)
    # Bottom right
    draw.line([(WIDTH - 80, bottom_y), (WIDTH - 80, bottom_y + bracket_size)],
              fill=(*HexColor(COLORS['cyan_primary']).rgb, 30), width=1)
    draw.line([(WIDTH - 80, bottom_y + bracket_size), (WIDTH - 80 - bracket_size, bottom_y + bracket_size)],
              fill=(*HexColor(COLORS['cyan_primary']).rgb, 30), width=1)

    # Bottom info line
    draw.line([(content_x, bottom_y - 30), (WIDTH - 120, bottom_y - 30)],
              fill=(*HexColor(COLORS['grid']).rgb, 80), width=1)

    # Bottom text
    try:
        info_font = ImageFont.truetype("/System/Library/Fonts/Helvetica.ttc", 12)
    except:
        info_font = small_font
    draw.text((content_x, bottom_y - 22), "ORBITAL INTELLIGENCE RESEARCH DIVISION",
              fill=COLORS['text_dim'], font=info_font)

    return img

def create_pdf():
    """Create the final PDF"""

    # Generate the image
    img = create_slide_image()

    # Save as high-resolution PNG first
    png_path = '/Users/zelong/.claude/skills/canvas-design/tech_directions_slide.png'
    img.save(png_path, 'PNG', quality=100, dpi=(300, 300))

    # Also create PDF version
    pdf_path = '/Users/zelong/.claude/skills/canvas-design/tech_directions_slide.pdf'

    c = canvas.Canvas(pdf_path, pagesize=(WIDTH/SCALE, HEIGHT/SCALE))

    # Draw the image
    c.drawImage(png_path, 0, 0, width=WIDTH/SCALE, height=HEIGHT/SCALE,
                preserveAspectRatio=True, anchor='c')

    c.save()

    return pdf_path, png_path

if __name__ == "__main__":
    pdf_path, png_path = create_pdf()
    print(f"PDF created: {pdf_path}")
    print(f"PNG created: {png_path}")
