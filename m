From: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
Subject: [PATCH v5 1/3] Documentation: dt: Add Broadcom iproc pwm controller binding
Date: Tue,  5 Jul 2016 02:00:24 -0400
Message-ID: <1467698426-27600-2-git-send-email-yendapally.reddy@broadcom.com>
References: <1467698426-27600-1-git-send-email-yendapally.reddy@broadcom.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:34678 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754494AbcGEGAx (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 5 Jul 2016 02:00:53 -0400
Received: by mail-pf0-f178.google.com with SMTP id h14so66919432pfe.1
        for <linux-pwm@vger.kernel.org>; Mon, 04 Jul 2016 23:00:52 -0700 (PDT)
In-Reply-To: <1467698426-27600-1-git-send-email-yendapally.reddy@broadcom.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>, Russell King <linux@arm.linux.org.uk>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org, Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>

Add a binding for Broadcom iproc pwm controller

Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/pwm/brcm,iproc-pwm.txt      | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/brcm,iproc-pwm.txt

diff --git a/Documentation/devicetree/bindings/pwm/brcm,iproc-pwm.txt b/Documentation/devicetree/bindings/pwm/brcm,iproc-pwm.txt
new file mode 100644
index 0000000..21f75bb
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/brcm,iproc-pwm.txt
@@ -0,0 +1,21 @@
+Broadcom iProc PWM controller device tree bindings
+
+This controller has 4 channels.
+
+Required Properties :
+- compatible: must be "brcm,iproc-pwm"
+- reg: physical base address and length of the controller's registers
+- clocks: phandle + clock specifier pair for the external clock
+- #pwm-cells: Should be 3. See pwm.txt in this directory for a
+  description of the cells format.
+
+Refer to clocks/clock-bindings.txt for generic clock consumer properties.
+
+Example:
+
+pwm: pwm@18031000 {
+	compatible = "brcm,iproc-pwm";
+	reg = <0x18031000 0x28>;
+	clocks = <&osc>;
+	#pwm-cells = <3>;
+};
-- 
2.1.0
