From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH v2 1/3] dt-bindings: pwm: meson: add comptabible for gxbb ao pwms
Date: Thu,  8 Jun 2017 14:24:14 +0200
Message-ID: <20170608122416.1993-2-jbrunet@baylibre.com>
References: <20170608122416.1993-1-jbrunet@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170608122416.1993-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Kevin Hilman <khilman@baylibre.com>, Neil Armstrong <narmstrong@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Carlo Caione <carlo@caione.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Add compatible string to properly handle the PWMs found in the AO domain
of the gxbb (and gxl) family

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 Documentation/devicetree/bindings/pwm/pwm-meson.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-meson.txt b/Documentation/devicetree/bindings/pwm/pwm-meson.txt
index 5376a4468cb6..5b07bebbf6f7 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-meson.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-meson.txt
@@ -2,7 +2,9 @@ Amlogic Meson PWM Controller
 ============================
 
 Required properties:
-- compatible: Shall contain "amlogic,meson8b-pwm" or "amlogic,meson-gxbb-pwm".
+- compatible: Shall contain "amlogic,meson8b-pwm"
+                         or "amlogic,meson-gxbb-pwm"
+                         or "amlogic,meson-gxbb-ao-pwm"
 - #pwm-cells: Should be 3. See pwm.txt in this directory for a description of
   the cells format.
 
-- 
2.9.4
