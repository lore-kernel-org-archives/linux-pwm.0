From: Lukasz Majewski <l.majewski@majess.pl>
Subject: [PATCH v3 RESEND 10/11] pwm: imx: doc: Update imx-pwm.txt documentation entry
Date: Mon, 26 Dec 2016 23:56:00 +0100
Message-ID: <1482792961-12702-11-git-send-email-l.majewski@majess.pl>
References: <1477259146-19167-1-git-send-email-l.majewski@majess.pl>
 <1482792961-12702-1-git-send-email-l.majewski@majess.pl>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from 2.mo177.mail-out.ovh.net ([178.33.109.80]:33473 "EHLO
        2.mo177.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755691AbcLZW6d (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 26 Dec 2016 17:58:33 -0500
Received: from player716.ha.ovh.net (b7.ovh.net [213.186.33.57])
        by mo177.mail-out.ovh.net (Postfix) with ESMTP id 66BF87497
        for <linux-pwm@vger.kernel.org>; Mon, 26 Dec 2016 23:58:32 +0100 (CET)
In-Reply-To: <1482792961-12702-1-git-send-email-l.majewski@majess.pl>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Stefan Agner <stefan@agner.ch>, linux-pwm@vger.kernel.org, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, linux-kernel@vger.kernel.org
Cc: Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Lothar Wassmann <LW@karo-electronics.de>, kernel@pengutronix.de, Lukasz Majewski <l.majewski@majess.pl>

The imx-pwm.txt documentation update as a preparation for polarity
support.

Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
Signed-off-by: Lukasz Majewski <l.majewski@majess.pl>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes for v3:
- None

Changes for v2:
- New patch
---
 Documentation/devicetree/bindings/pwm/imx-pwm.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/imx-pwm.txt b/Documentation/devicetree/bindings/pwm/imx-pwm.txt
index e00c2e9..c61bdf8 100644
--- a/Documentation/devicetree/bindings/pwm/imx-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/imx-pwm.txt
@@ -6,8 +6,8 @@ Required properties:
   - "fsl,imx1-pwm" for PWM compatible with the one integrated on i.MX1
   - "fsl,imx27-pwm" for PWM compatible with the one integrated on i.MX27
 - reg: physical base address and length of the controller's registers
-- #pwm-cells: should be 2. See pwm.txt in this directory for a description of
-  the cells format.
+- #pwm-cells: 2 for i.MX1 and 3 for i.MX27 and newer SoCs. See pwm.txt
+  in this directory for a description of the cells format.
 - clocks : Clock specifiers for both ipg and per clocks.
 - clock-names : Clock names should include both "ipg" and "per"
 See the clock consumer binding,
@@ -17,7 +17,7 @@ See the clock consumer binding,
 Example:
 
 pwm1: pwm@53fb4000 {
-	#pwm-cells = <2>;
+	#pwm-cells = <3>;
 	compatible = "fsl,imx53-pwm", "fsl,imx27-pwm";
 	reg = <0x53fb4000 0x4000>;
 	clocks = <&clks IMX5_CLK_PWM1_IPG_GATE>,
-- 
2.1.4
