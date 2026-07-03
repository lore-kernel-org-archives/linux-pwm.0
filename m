Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F4C3B14B8;
	Fri,  3 Jul 2026 09:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783071275; cv=none; b=T73x9XryoOvy+pE5z+8CeIYqEavKKQE+8R0Cd58SrCkktqqwbF41v/GnY6HjAKr0+1+4MoJXboJg86+7+xTJl2tVtXy197D2MB5PFjDhzqcilI87nvZGo9K+4Bcdb7FNZ9ndTQcnitOqX9CylPDvVtcyNGnFkR3j6OjtRsJZfo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783071275; c=relaxed/simple;
	bh=OLOJA9GaM38w2ZHrbkNh4EXEkIt+8RX1ScKXmXIPtPI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rul4VIfP0L55BvhXrHHR0b9LV9fPWu7W2qFYBqvNGl11Ng3I/Jek81gQRqapNrgHf/TXyPF9zjWXaVpKP6mkG/Q8WRi563IA33ihqQ9HqbtPpMkaBOwuJn0/c0yAW8BpZvwyrerHmKFaEHcK4r7j+GbJQ0il0E0vO6G7cU658aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0005152DT.eswin.cn (unknown [10.12.96.41])
	by app2 (Coremail) with SMTP id TQJkCgAnPaAZgkdqizsxAA--.36766S2;
	Fri, 03 Jul 2026 17:34:19 +0800 (CST)
From: Xuyang Dong <dongxuyang@eswincomputing.com>
To: ukleinek@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ben-linux@fluff.org,
	ben.dooks@codethink.co.uk,
	p.zabel@pengutronix.de,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	xuxiang@eswincomputing.com,
	wangguosheng@eswincomputing.com,
	pinkesh.vaghela@einfochips.com,
	Xuyang Dong <dongxuyang@eswincomputing.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v10 2/3] dt-bindings: pwm: dwc: Add eswin compatible
Date: Fri,  3 Jul 2026 17:34:14 +0800
Message-Id: <20260703093414.644-1-dongxuyang@eswincomputing.com>
X-Mailer: git-send-email 2.31.1.windows.1
In-Reply-To: <20260703093308.482-1-dongxuyang@eswincomputing.com>
References: <20260703093308.482-1-dongxuyang@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TQJkCgAnPaAZgkdqizsxAA--.36766S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WFyrKryDXry7CFy7Xw4xZwb_yoW8uF4rpF
	4furyvqw1fXr17Xws5XF10k3W3Xas5JFW3Kr1xtrWUCa90qF4jqFW3KFn0yFWUZr4I9ry3
	Wa93ur15A3Wj9r7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9G14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wrylc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMx
	C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
	wI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
	vE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v2
	0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxV
	W8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRiKsUtUUUUU==
X-CM-SenderInfo: pgrqw5xx1d0w46hv4xpqfrz1xxwl0woofrz/

EIC7700 integrates the DesignWare PWM IP described by the generic
snps,dw-apb-timers-pwm2 binding. On this SoC, the presetn and
timer_N_resetn inputs are physically tied together to a single reset
line, so exactly one reset is both required and sufficient, unlike
the generic binding where up to two independent lines are optional.

Add the eswin,eic7700-pwm compatible string and constrain its resets
property to exactly one entry.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Xuyang Dong <dongxuyang@eswincomputing.com>
---
 .../bindings/pwm/snps,dw-apb-timers-pwm2.yaml | 32 ++++++++++++++++---
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml b/Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml
index 213fdaef25d9..9a9a24ddc61b 100644
--- a/Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml
+++ b/Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml
@@ -20,12 +20,11 @@ description:
   instead of having to encode the IP version number in the device tree
   compatible.
 
-allOf:
-  - $ref: pwm.yaml#
-
 properties:
   compatible:
-    const: snps,dw-apb-timers-pwm2
+    enum:
+      - snps,dw-apb-timers-pwm2
+      - eswin,eic7700-pwm
 
   reg:
     maxItems: 1
@@ -44,6 +43,7 @@ properties:
       - const: timer
 
   resets:
+    minItems: 1
     items:
       - description: Interface bus (presetn) reset
       - description: PWM timer logic (timer_N_resetn) reset
@@ -59,6 +59,21 @@ required:
   - clocks
   - clock-names
 
+allOf:
+  - $ref: pwm.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: eswin,eic7700-pwm
+    then:
+      properties:
+        resets:
+          maxItems: 1
+      required:
+        - resets
+
 additionalProperties: false
 
 examples:
@@ -70,3 +85,12 @@ examples:
       clocks = <&bus>, <&timer>;
       clock-names = "bus", "timer";
     };
+  - |
+    pwm@50818000 {
+      compatible = "eswin,eic7700-pwm";
+      reg = <0x50818000 0x4000>;
+      #pwm-cells = <3>;
+      clocks = <&bus>, <&timer>;
+      clock-names = "bus", "timer";
+      resets = <&reset>;
+    };
-- 
2.34.1

