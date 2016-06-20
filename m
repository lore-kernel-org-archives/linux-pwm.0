From: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v3 1/3] Documentation: dt: Add Broadcom iproc pwm controller binding
Date: Mon, 20 Jun 2016 10:14:32 -0400
Message-ID: <1466432074-7780-2-git-send-email-yendapally.reddy@broadcom.com>
References: <1466432074-7780-1-git-send-email-yendapally.reddy@broadcom.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1466432074-7780-1-git-send-email-yendapally.reddy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Jon Mason <jonmason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Yendapally Reddy Dhananjaya Reddy <yendapally.reddy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Add a binding for Broadcom iproc pwm controller

Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
