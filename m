From: Sylvain Lemieux <slemieux.tyco@gmail.com>
Subject: [PATCH v2 3/3] dt-bindings: pwm: lpc32xx: Add nxp,pwm-disabled-level-high property
Date: Mon, 27 Jun 2016 09:09:57 -0400
Message-ID: <1467032997-5340-4-git-send-email-slemieux.tyco@gmail.com>
References: <1467032997-5340-1-git-send-email-slemieux.tyco@gmail.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:33667 "EHLO
	mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751634AbcF0NKI (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 27 Jun 2016 09:10:08 -0400
Received: by mail-it0-f68.google.com with SMTP id y93so10236162ita.0
        for <linux-pwm@vger.kernel.org>; Mon, 27 Jun 2016 06:10:08 -0700 (PDT)
In-Reply-To: <1467032997-5340-1-git-send-email-slemieux.tyco@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: vz@mleia.com, thierry.reding@gmail.com
Cc: linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org

From: Sylvain Lemieux <slemieux@tycoint.com>

Document the nxp,pwm-disabled-level-high property used by the
pwm-lpc32xx driver to setup the pin output level to high when
the PWM is disabled.

The driver setup the pin output level to the reset value
by default.

Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>
---
Changes from v1 to v2:
* New patch in version 2.

 Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt b/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt
index 74b5bc5..5829f3f 100644
--- a/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt
@@ -4,6 +4,9 @@ Required properties:
 - compatible: should be "nxp,lpc3220-pwm"
 - reg: physical base address and length of the controller's registers
 
+Optional properties:
+- nxp,pwm-disabled-level-high: Set the PWM output level to high when disabled
+
 Examples:
 
 pwm@4005c000 {
-- 
1.8.3.1
