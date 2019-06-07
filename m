From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 1/6] dt-bindings: Remove unused compatible strings
Date: Fri,  7 Jun 2019 17:44:05 +0200
Message-ID: <20190607154410.10633-2-paul@crapouillou.net>
References: <20190607154410.10633-1-paul@crapouillou.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190607154410.10633-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: od@zcrc.me, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
List-Id: linux-pwm@vger.kernel.org

Right now none of the Ingenic-based boards probe this driver from
devicetree. This driver defined three compatible strings for the exact
same behaviour. Before these strings are used, we can remove two of
them.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2: Rebase on v5.2-rc3

 Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt b/Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt
index 7d9d3f90641b..493bec80d59b 100644
--- a/Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt
@@ -2,10 +2,7 @@ Ingenic JZ47xx PWM Controller
 =============================
 
 Required properties:
-- compatible: One of:
-  * "ingenic,jz4740-pwm"
-  * "ingenic,jz4770-pwm"
-  * "ingenic,jz4780-pwm"
+- compatible: Should be "ingenic,jz4740-pwm"
 - #pwm-cells: Should be 3. See pwm.txt in this directory for a description
   of the cells format.
 - clocks : phandle to the external clock.
-- 
2.21.0.593.g511ec345e18
