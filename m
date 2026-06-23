Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A9C340286;
	Tue, 23 Jun 2026 07:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782198902; cv=none; b=ccTQArLsT+SIFdTTfgL2gfCTRhnVlTbO7Jz4jVM5K9jaEYMDVk9nawBZyIzlkAG8LB1V9Mr2Tn7PS9ZKhWkkcpW3DpzEjI1wVBZi/rPPqP+TLuQFlKZjZDlJg9THL/EWVmXhHk52/2MpxQ7yU/TRrSfkVu5Lnq1RcwOoZ8DafUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782198902; c=relaxed/simple;
	bh=BG7aJT75SeSudrAVtENnb67kpwtBrgsQnPh0cT54ldg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d8KPyNbJ1mKXjLWpMhVIdRGIW6CEmD7vvFial8cZwsVF9OceD4/BJnvfyLZaXf+eG6SKmDYgWjhrEcUnJtTwJtcw79q+XETMBRxdOy5glFzpv3teHMESp1rz9kxrZxB3Xk5BLAxkxzVUQ+uLEyz/TaoDCX1qJsf5bLg8laIG0Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0005152DT.eswin.cn (unknown [10.12.96.41])
	by app1 (Coremail) with SMTP id TAJkCgA3y29gMjpqAoctAA--.48226S2;
	Tue, 23 Jun 2026 15:14:41 +0800 (CST)
From: dongxuyang@eswincomputing.com
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
	Xuyang Dong <dongxuyang@eswincomputing.com>
Subject: [PATCH v8 2/3] dt-bindings: pwm: dwc: Add eswin compatible
Date: Tue, 23 Jun 2026 15:14:38 +0800
Message-Id: <20260623071438.2147-1-dongxuyang@eswincomputing.com>
X-Mailer: git-send-email 2.31.1.windows.1
In-Reply-To: <20260623071329.2034-1-dongxuyang@eswincomputing.com>
References: <20260623071329.2034-1-dongxuyang@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TAJkCgA3y29gMjpqAoctAA--.48226S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww43uw4fXrW5XF1xJr1kKrg_yoW8uF48pF
	4furWvqw1fXr17Zws5XF10k3W3Xas5JFW3Kr1xtFWUCa90qF4jqFW3Kr15AFWUZr4xurW3
	Wa93ur15A3Wj9r7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r1q6r43MxkIecxEwVCm-wCF04
	k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
	MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr4
	1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l
	IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUHCJQUUUUU=
X-CM-SenderInfo: pgrqw5xx1d0w46hv4xpqfrz1xxwl0woofrz/

From: Xuyang Dong <dongxuyang@eswincomputing.com>

EIC7700 integrates the DesignWare PWM IP described by the generic
snps,dw-apb-timers-pwm2 binding. On this SoC, the presetn and
timer_N_resetn inputs are physically tied together to a single reset
line, so exactly one reset is both required and sufficient, unlike
the generic binding where up to two independent lines are optional.

Add the eswin,eic7700-pwm compatible string and constrain its resets
property to exactly one entry.

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

