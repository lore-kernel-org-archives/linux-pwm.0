From: Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH] dt-bindings: pwm: fix nodename pattern
Date: Wed, 11 Dec 2019 16:00:21 +0100
Message-ID: <20191211150021.20125-1-benjamin.gaignard@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Gaignard <benjamin.gaignard@st.com>
List-Id: linux-pwm@vger.kernel.org

Typical pwm nodes should be named pwm@xxx.
The pattern shouldn't match nodes named pwm-xxx to avoid
conflicts with pinmux or pwm-fan nodes.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 Documentation/devicetree/bindings/pwm/pwm.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm.yaml b/Documentation/devicetree/bindings/pwm/pwm.yaml
index fa4f9de92090..29b86886c282 100644
--- a/Documentation/devicetree/bindings/pwm/pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/pwm.yaml
@@ -11,7 +11,7 @@ maintainers:
 
 properties:
   $nodename:
-    pattern: "^pwm(@.*|-[0-9a-f])*$"
+    pattern: "^pwm(@.*[0-9a-f])*$"
 
   "#pwm-cells":
     description:
-- 
2.15.0
