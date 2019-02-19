From: <Claudiu.Beznea@microchip.com>
Subject: [PATCH v2 4/4] pwm: atmel: add PWM binding for SAM9X60
Date: Tue, 19 Feb 2019 10:09:03 +0000
Message-ID: <1550570914-26391-5-git-send-email-claudiu.beznea@microchip.com>
References: <1550570914-26391-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550570914-26391-1-git-send-email-claudiu.beznea@microchip.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com, Ludovic.Desroches@microchip.com
Cc: linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Claudiu.Beznea@microchip.com
List-Id: linux-pwm@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add PWM binding for SAM9X60 SoC.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/pwm/atmel-pwm.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/atmel-pwm.txt b/Document=
ation/devicetree/bindings/pwm/atmel-pwm.txt
index c8c831d7b0d1..591ecdd39c7b 100644
--- a/Documentation/devicetree/bindings/pwm/atmel-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/atmel-pwm.txt
@@ -5,6 +5,7 @@ Required properties:
     - "atmel,at91sam9rl-pwm"
     - "atmel,sama5d3-pwm"
     - "atmel,sama5d2-pwm"
+    - "microchip,sam9x60-pwm"
   - reg: physical base address and length of the controller's registers
   - #pwm-cells: Should be 3. See pwm.txt in this directory for a
     description of the cells format.
--=20
2.7.4
