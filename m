From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH v4 2/4] pwm: sirf: add dt-binding document
Date: Wed,  5 Mar 2014 17:59:43 +0800
Message-ID: <1394013583-6352-1-git-send-email-21cnbao@gmail.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:35085 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751943AbaCEKAB (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 5 Mar 2014 05:00:01 -0500
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com, linux-pwm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, workgroup.linux@csr.com, devicetree@vger.kernel.org, Barry Song <Baohua.Song@csr.com>

From: Barry Song <Baohua.Song@csr.com>

this patch adds dt-binding document for pwm-sirf. here the controller clock
can't generate PWM signals, so we need seperate clock as signal source.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 Documentation/devicetree/bindings/pwm/pwm-sirf.txt |   23 ++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sirf.txt

diff --git a/Documentation/devicetree/bindings/pwm/pwm-sirf.txt b/Documentation/devicetree/bindings/pwm/pwm-sirf.txt
new file mode 100644
index 0000000..47851ea
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-sirf.txt
@@ -0,0 +1,23 @@
+SiRF prima2 & atlas6 PWM drivers
+
+Required properties:
+- compatible: "sirf,prima2-pwm"
+- reg: physical base address and length of the controller's registers
+- #pwm-cells: should be 2.  The first cell specifies the per-chip index of the
+  PWM to use and the second cell is the period in nanoseconds.
+- clocks: from common clock binding: the 1st clock is for PWM controller the
+  other clocks are the sources to generate PWM signals
+- clock-names : The first one is the name of the clock for PWM, others are names
+  of clock sources to generate PWM signal, e.g.sigsrc0 ~sigsrc4. For prima2 and
+  atlas6, sigsrc0 is OSC with 26MHz, sigsrc3 is RTC with 32KHz, others are PLLs.
+  Generally, PWM module uses the OSC as clock source to generate PWM signals.
+
+
+Example:
+pwm: pwm@b0130000 {
+	compatible = "sirf,prima2-pwm";
+	#pwm-cells = <2>;
+	reg = <0xb0130000 0x10000>;
+	clocks = <&clks 21>, <&clks 1>;
+	clock-names = "pwmc", "sigsrc0"";
+};
-- 
1.7.5.4

