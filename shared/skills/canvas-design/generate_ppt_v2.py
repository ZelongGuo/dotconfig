#!/usr/bin/env python3
"""
Orbital Intelligence - Technical Research Direction Slide
A museum-quality design expressing technology research directions
"""

from PIL import Image, ImageDraw, ImageFont
import math

# Dimensions - 16:9 HD
WIDTH, HEIGHT = 1920, 1080

# Color palette
COLORS = {
    'deep_space': (3, 8, 18),
    'midnight': (7, 18, 38),
    'atmosphere': (15, 31, 58),
    'cyan_primary': (0, 212, 255),
    'cyan_glow': (0, 168, 204),
    'electric_blue': (0, 102, 255),
    'signal': (0, 255, 170),
    'alert': (255, 107, 53),
    'text_white': (232, 244, 252),
    'text_dim': (107, 139, 163),
    'grid': (26, 45, 74),
}

def hex_to_rgba(hex_color, alpha=255):
    """Convert hex color to RGBA tuple"""
    h = hex_color.lstrip('#')
    rgb = tuple(int(h[i:i+2], 16) for i in (0, 2, 4))
    return rgb + (alpha,)

def create_slide_image():
    """Create the slide as a high-resolution image"""

    img = Image.new('RGBA', (WIDTH, HEIGHT), COLORS['deep_space'] + (255,))
    draw = ImageDraw.Draw(img)

    # Background gradient effect
    for y in range(0, HEIGHT, 2):
        factor = y / HEIGHT
        r = int(3 + (7-3) * factor)
        g = int(8 + (18-8) * factor)
        b = int(18 + (38-18) * factor)
        draw.line([(0, y), (WIDTH, y)], fill=(r, g, b, 255))

    # Subtle grid overlay
    grid_spacing = 60
    for x in range(0, WIDTH, grid_spacing):
        alpha = int(5 + 10 * (x / WIDTH))
        draw.line([(x, 0), (x, HEIGHT)], fill=(*COLORS['grid'], alpha), width=1)
    for y in range(0, HEIGHT, grid_spacing):
        draw.line([(0, y), (WIDTH, y)], fill=(*COLORS['grid'], 8), width=1)

    # ========== CONCENTRIC RADAR SYSTEM (Right Side) ==========
    radar_center_x, radar_center_y = 1450, 540
    max_radius = 380

    # Outer glow rings
    for i, radius in enumerate([360, 320, 280, 240, 200, 160, 120, 80]):
        alpha = max(5, 40 - i * 4)
        draw.ellipse([
            radar_center_x - radius, radar_center_y - radius,
            radar_center_x + radius, radar_center_y + radius
        ], outline=(*COLORS['electric_blue'], alpha), width=1)

    # Radar sweep arc - multiple lines for gradient effect
    sweep_angle = 45
    for r in range(40, max_radius, 3):
        angle_start = math.radians(-90)
        angle_end = math.radians(-90 + sweep_angle + r * 0.08)
        alpha = int(80 * (1 - r / max_radius))

        points = []
        steps = 30
        for s in range(steps + 1):
            t = s / steps
            angle = angle_start + (angle_end - angle_start) * t
            x = radar_center_x + r * math.cos(angle)
            y = radar_center_y + r * math.sin(angle)
            points.append((x, y))

        if len(points) > 1:
            for i in range(len(points) - 1):
                draw.line([points[i], points[i+1]],
                         fill=(*COLORS['cyan_primary'], alpha), width=1)

    # Target blips
    targets = [
        (200, -35, COLORS['signal']),
        (160, 45, COLORS['signal']),
        (280, 70, COLORS['cyan_primary']),
        (140, -60, COLORS['alert']),
    ]
    for distance, angle, color in targets:
        rad = math.radians(angle)
        x = radar_center_x + distance * math.cos(rad)
        y = radar_center_y + distance * math.sin(rad)
        # Glow rings
        for r in range(10, 0, -2):
            draw.ellipse([x-r, y-r, x+r, y+r],
                        outline=(*color, 20 - r*2), width=1)
        # Center dot
        draw.ellipse([x-4, y-4, x+4, y+4], fill=color)

    # Center point
    draw.ellipse([radar_center_x-15, radar_center_y-15,
                  radar_center_x+15, radar_center_y+15],
                 outline=(*COLORS['cyan_primary'], 80), width=2)
    draw.ellipse([radar_center_x-6, radar_center_y-6,
                  radar_center_x+6, radar_center_y+6],
                 fill=COLORS['cyan_primary'])

    # Crosshairs
    draw.line([(radar_center_x-40, radar_center_y), (radar_center_x+40, radar_center_y)],
              fill=(*COLORS['electric_blue'], 40), width=1)
    draw.line([(radar_center_x, radar_center_y-40), (radar_center_x, radar_center_y+40)],
              fill=(*COLORS['electric_blue'], 40), width=1)

    # ========== SATELLITE ICONS ==========
    def draw_satellite(cx, cy, size, rotation, draw_layer=draw):
        """Draw a stylized satellite"""
        # Calculate panel positions
        angles = [rotation + a for a in [0, 45, 90, 135, 180, 225, 270, 315]]
        coords = []
        for angle in angles:
            rad = math.radians(angle)
            coords.append((
                cx + size * math.cos(rad),
                cy + size * math.sin(rad)
            ))

        # Draw solar panels (rectangles extending from body)
        panel_length = size * 1.2
        panel_width = size * 0.35

        # Two main solar arrays
        for array_angle in [rotation, rotation + 90]:
            rad = math.radians(array_angle)
            # Panel 1
            p1x = cx + panel_length * math.cos(rad)
            p1y = cy + panel_length * math.sin(rad)
            # Panel 2 (opposite)
            p2x = cx - panel_length * math.cos(rad)
            p2y = cy - panel_length * math.sin(rad)

            # Perpendicular angle for width
            perp_rad = rad + math.pi/2

            # Draw panel 1
            panel1_coords = [
                (cx + size*0.3 * math.cos(rad) + panel_width/2 * math.cos(perp_rad),
                 cy + size*0.3 * math.sin(rad) + panel_width/2 * math.sin(perp_rad)),
                (cx + size*0.3 * math.cos(rad) - panel_width/2 * math.cos(perp_rad),
                 cy + size*0.3 * math.sin(rad) - panel_width/2 * math.sin(perp_rad)),
                (p1x - panel_width/2 * math.cos(perp_rad), p1y - panel_width/2 * math.sin(perp_rad)),
                (p1x + panel_width/2 * math.cos(perp_rad), p1y + panel_width/2 * math.sin(perp_rad)),
            ]
            draw_layer.polygon(panel1_coords, fill=(*COLORS['electric_blue'], 50),
                              outline=(*COLORS['cyan_primary'], 100))

            # Draw panel 2
            panel2_coords = [
                (cx - size*0.3 * math.cos(rad) + panel_width/2 * math.cos(perp_rad),
                 cy - size*0.3 * math.sin(rad) + panel_width/2 * math.sin(perp_rad)),
                (cx - size*0.3 * math.cos(rad) - panel_width/2 * math.cos(perp_rad),
                 cy - size*0.3 * math.sin(rad) - panel_width/2 * math.sin(perp_rad)),
                (p2x - panel_width/2 * math.cos(perp_rad), p2y - panel_width/2 * math.sin(perp_rad)),
                (p2x + panel_width/2 * math.cos(perp_rad), p2y + panel_width/2 * math.sin(perp_rad)),
            ]
            draw_layer.polygon(panel2_coords, fill=(*COLORS['electric_blue'], 50),
                              outline=(*COLORS['cyan_primary'], 100))

        # Center body
        draw_layer.ellipse([cx-size*0.4, cy-size*0.4, cx+size*0.4, cy+size*0.4],
                           fill=COLORS['cyan_primary'],
                           outline=(*COLORS['text_white'], 150), width=1)

    # Satellites in orbit
    draw_satellite(1200, 180, 28, 15)
    draw_satellite(1650, 250, 22, -30)
    draw_satellite(1700, 850, 24, 60)
    draw_satellite(1300, 900, 18, 120)
    draw_satellite(1550, 650, 16, 180)

    # ========== ORBITAL ARCS ==========
    for radius in [100, 150, 200]:
        arc_rect = [
            radar_center_x - radius - 100,
            radar_center_y - radius - 100,
            radar_center_x + radius + 100,
            radar_center_y + radius + 100
        ]
        # Draw partial arc
        for start_angle in range(0, 360, 45):
            draw.arc(arc_rect, start_angle, start_angle + 20,
                    fill=(*COLORS['cyan_primary'], 20), width=1)

    # ========== LEFT SIDE - CONTENT AREA ==========
    content_x = 120

    # Title area with accent line
    title_y = 140
    draw.line([(content_x, title_y - 5), (content_x + 200, title_y - 5)],
              fill=COLORS['cyan_primary'], width=5)

    # Load fonts
    try:
        title_font = ImageFont.truetype("/System/Library/Fonts/PingFang.ttc", 76)
        label_font = ImageFont.truetype("/System/Library/Fonts/PingFang.ttc", 30)
        small_font = ImageFont.truetype("/System/Library/Fonts/Helvetica.ttc", 16)
        number_font = ImageFont.truetype("/System/Library/Fonts/Helvetica-Bold.ttc", 40)
        tag_font = ImageFont.truetype("/System/Library/Fonts/PingFang.ttc", 14)
    except:
        try:
            title_font = ImageFont.truetype("Arial", 72)
            label_font = ImageFont.truetype("Arial", 28)
            small_font = ImageFont.truetype("Arial", 14)
            number_font = ImageFont.truetype("Arial Bold", 36)
            tag_font = ImageFont.truetype("Arial", 12)
        except:
            title_font = ImageFont.load_default()
            label_font = ImageFont.load_default()
            small_font = ImageFont.load_default()
            number_font = ImageFont.load_default()
            tag_font = ImageFont.load_default()

    # Draw title
    draw.text((content_x + 15, title_y - 15), "技术攻关方向",
              fill=COLORS['text_white'], font=title_font)

    # Subtitle
    draw.text((content_x + 15, title_y + 70), "KEY TECHNOLOGY DIRECTIONS",
              fill=COLORS['text_dim'], font=small_font)

    # ========== TECH ITEMS ==========
    tech_items = [
        ("01", "新体制雷达系统", "核心"),
        ("02", "星座/巨星座低轨卫星应用", "前沿"),
        ("03", "空天具身智能应用", "创新"),
        ("04", "超物理极限成像", "突破"),
        ("05", "卫星智能计算", "战略"),
    ]

    item_y_start = 290
    item_height = 115

    for i, (num, name, tag) in enumerate(tech_items):
        y = item_y_start + i * item_height

        # Item background - subtle gradient bar
        for x_offset in range(350):
            alpha = int(20 * (1 - x_offset / 350))
            draw.line([(content_x + x_offset, y + 22),
                      (content_x + x_offset, y + 82)],
                      fill=(*COLORS['atmosphere'], alpha), width=1)

        # Left accent bar
        bar_height = 60
        for x in range(5):
            alpha = int(220 - x * 35)
            draw.line([(content_x + x, y + 22),
                      (content_x + x, y + 22 + bar_height)],
                      fill=(*COLORS['cyan_primary'], alpha), width=1)

        # Number
        draw.text((content_x + 35, y + 20), num,
                  fill=COLORS['electric_blue'], font=number_font)

        # Tech name
        draw.text((content_x + 115, y + 32), name,
                  fill=COLORS['text_white'], font=label_font)

        # Tag badge
        tag_x = content_x + 730
        tag_y = y + 40
        tag_width = 75
        tag_height = 32

        # Tag background
        draw.rounded_rectangle([tag_x, tag_y, tag_x + tag_width, tag_y + tag_height],
                               radius=16, fill=(*COLORS['electric_blue'], 50))
        draw.rounded_rectangle([tag_x, tag_y, tag_x + tag_width, tag_y + tag_height],
                               radius=16, outline=(*COLORS['cyan_primary'], 120), width=1)

        # Tag text - center it
        bbox = tag_font.getbbox(tag)
        text_width = bbox[2] - bbox[0]
        draw.text((tag_x + (tag_width - text_width) // 2, tag_y + 7), tag,
                  fill=COLORS['cyan_primary'], font=tag_font)

    # ========== DECORATIVE BOTTOM ELEMENTS ==========
    bottom_y = HEIGHT - 90

    # Data stream decoration
    for i in range(25):
        x = content_x + i * 38
        height = 8 + (i % 4) * 4
        alpha = int(max(5, 40 - i * 1.5))
        draw.rectangle([x, bottom_y + 15, x + 18, bottom_y + 15 + height],
                       fill=(*COLORS['cyan_primary'], int(alpha * 0.3)),
                       outline=(*COLORS['electric_blue'], alpha))

    # Corner brackets
    bracket_size = 50
    # Top left bracket
    draw.line([(content_x, 100), (content_x, 100 + bracket_size)],
              fill=(*COLORS['cyan_primary'], 60), width=2)
    draw.line([(content_x, 100), (content_x + bracket_size, 100)],
              fill=(*COLORS['cyan_primary'], 60), width=2)
    # Bottom right bracket
    draw.line([(WIDTH - 100, bottom_y), (WIDTH - 100, bottom_y + bracket_size)],
              fill=(*COLORS['cyan_primary'], 40), width=2)
    draw.line([(WIDTH - 100, bottom_y + bracket_size), (WIDTH - 100 - bracket_size, bottom_y + bracket_size)],
              fill=(*COLORS['cyan_primary'], 40), width=2)

    # Bottom info line
    draw.line([(content_x, bottom_y - 35), (WIDTH - 140, bottom_y - 35)],
              fill=(*COLORS['grid'], 100), width=1)

    # Bottom text
    draw.text((content_x, bottom_y - 28), "ORBITAL INTELLIGENCE RESEARCH DIVISION",
              fill=COLORS['text_dim'], font=small_font)

    # Add small status indicators
    for i in range(5):
        ind_x = WIDTH - 300 + i * 40
        ind_y = bottom_y - 25
        draw.ellipse([ind_x, ind_y, ind_x + 6, ind_y + 6],
                     fill=(*COLORS['signal'], 150 - i * 20))

    return img

def create_output_files():
    """Create PNG output"""

    # Generate the image
    img = create_slide_image()

    # Convert to RGB for saving
    img_rgb = Image.new('RGB', img.size, (0, 0, 0))
    img_rgb.paste(img, mask=img.split()[3])

    # Save as high-resolution PNG
    output_path = '/Users/zelong/testspace/test/技术攻关方向_Slide.png'
    img_rgb.save(output_path, 'PNG', quality=100, dpi=(300, 300))

    # Also save a copy in the skills directory
    skills_path = '/Users/zelong/.claude/skills/canvas-design/tech_directions_slide.png'
    img_rgb.save(skills_path, 'PNG', quality=100, dpi=(300, 300))

    return output_path

if __name__ == "__main__":
    output_path = create_output_files()
    print(f"Slide created: {output_path}")
