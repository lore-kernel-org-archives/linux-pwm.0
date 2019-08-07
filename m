From: Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH v5 1/4] dt-bindings: display: mediatek: update dpi  supported chips
Date: Wed, 7 Aug 2019 14:02:54 +0800
Message-ID: <20190807060257.57007-2-jitao.shi@mediatek.com>
References: <20190807060257.57007-1-jitao.shi@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190807060257.57007-1-jitao.shi@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-pwm@vger.kernel.org, David Airlie <airlied@linux.ie>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Jitao Shi <jitao.shi@mediatek.com>, Thierry Reding <treding@nvidia.com>, Ajay Kumar <ajaykumar.rs@samsung.com>, Inki Dae <inki.dae@samsung.com>, Rahul Sharma <rahul.sharma@samsung.com>, Sean Paul <seanpaul@chromium.org>, Vincent Palatin <vpalatin@chromium.org>, Andy Yan <andy.yan@rock-chips.com>, Philipp Zabel <p.zabel@pengutronix.de>, Russell King <rmk+kernel@arm.linux.org.uk>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, Sascha Hauer <kernel@pengutronix.de>, yingjoe.chen@mediatek.com, eddie.huang@mediatek.com, cawa.cheng@mediatek.com, bibby.hsieh@mediatek.com, ck.hu@mediate
List-Id: linux-pwm@vger.kernel.org

Add decriptions about supported chips, including MT2701 & MT8173 &
mt8183

Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
---
 .../bindings/display/mediatek/mediatek,dpi.txt        | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.txt
index b6a7e7397b8b..cd6a1469c8b7 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.txt
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.txt
@@ -7,6 +7,7 @@ output bus.
 
 Required properties:
 - compatible: "mediatek,<chip>-dpi"
+  the supported chips are mt2701 , mt8173 and mt8183.
 - reg: Physical base address and length of the controller's registers
 - interrupts: The interrupt signal from the function block.
 - clocks: device clocks
@@ -16,6 +17,11 @@ Required properties:
   Documentation/devicetree/bindings/graph.txt. This port should be connected
   to the input port of an attached HDMI or LVDS encoder chip.
 
+Optional properties:
+- dpi_pin_mode_swap: Swap the pin mode between dpi mode and gpio mode.
+- pinctrl-names: Contain "gpiomode" and "dpimode".
+- dpi_dual_edge: Control the RGB 24bit data on 12 pins or 24 pins.
+
 Example:
 
 dpi0: dpi@1401d000 {
@@ -26,6 +32,11 @@ dpi0: dpi@1401d000 {
 		 <&mmsys CLK_MM_DPI_ENGINE>,
 		 <&apmixedsys CLK_APMIXED_TVDPLL>;
 	clock-names = "pixel", "engine", "pll";
+	dpi_dual_edge;
+	dpi_pin_mode_swap;
+	pinctrl-names = "gpiomode", "dpimode";
+	pinctrl-0 = <&dpi_pin_gpio>;
+	pinctrl-1 = <&dpi_pin_func>;
 
 	port {
 		dpi0_out: endpoint {
-- 
2.21.0
