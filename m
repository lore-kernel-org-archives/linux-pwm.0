From: Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 1/3] dt-bindings: pwm: Update bindings for the Meson G12A Family
Date: Fri, 12 Apr 2019 11:23:35 +0200
Message-ID: <20190412092337.6941-2-narmstrong@baylibre.com>
References: <20190412092337.6941-1-narmstrong@baylibre.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190412092337.6941-1-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, devicetree@vger.kernel.org
Cc: baylibre-upstreaming@groups.io, Neil Armstrong <narmstrong@baylibre.com>, linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Update the doc to explicitly support Meson G12A Family

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/devicetree/bindings/pwm/pwm-meson.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-meson.txt b/Documentation/devicetree/bindings/pwm/pwm-meson.txt
index 1fa3f7182133..e2bcd8e92ad0 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-meson.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-meson.txt
@@ -7,6 +7,8 @@ Required properties:
                          or "amlogic,meson-gxbb-ao-pwm"
                          or "amlogic,meson-axg-ee-pwm"
                          or "amlogic,meson-axg-ao-pwm"
+                         or "amlogic,meson-g12a-ee-pwm"
+                         or "amlogic,meson-g12a-ao-pwm"
 - #pwm-cells: Should be 3. See pwm.txt in this directory for a description of
   the cells format.
 
-- 
2.21.0
