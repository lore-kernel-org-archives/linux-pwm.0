From: Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 1/3] dt-bindings: pwm: Update bindings for the Meson G12A Family
Date: Tue, 23 Apr 2019 15:36:44 +0200
Message-ID: <20190423133646.5705-2-narmstrong@baylibre.com>
References: <20190423133646.5705-1-narmstrong@baylibre.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190423133646.5705-1-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, devicetree@vger.kernel.org
Cc: baylibre-upstreaming@groups.io, Neil Armstrong <narmstrong@baylibre.com>, linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Update the doc to explicitly support Meson G12A Family.
The 2 first (A & B) AO PWM uses different clock source than the last 2
(C & D) AO PWM modules, thus we need to differentiate them.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/devicetree/bindings/pwm/pwm-meson.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-meson.txt b/Documentation/devicetree/bindings/pwm/pwm-meson.txt
index 1fa3f7182133..891632354065 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-meson.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-meson.txt
@@ -7,6 +7,9 @@ Required properties:
                          or "amlogic,meson-gxbb-ao-pwm"
                          or "amlogic,meson-axg-ee-pwm"
                          or "amlogic,meson-axg-ao-pwm"
+                         or "amlogic,meson-g12a-ee-pwm"
+                         or "amlogic,meson-g12a-ao-pwm-ab"
+                         or "amlogic,meson-g12a-ao-pwm-cd"
 - #pwm-cells: Should be 3. See pwm.txt in this directory for a description of
   the cells format.
 
-- 
2.21.0
