Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF190411A03;
	Thu, 30 Jul 2026 11:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785410155; cv=none; b=Jxz1e+sGkRkc/FiPbMtV2sOvh2jA6Nd0ZuFGBfcH761WkKdm3otrxTDknnPd/X79XZkcab3ovpg9736Xa26lI0/COyHjrcnUjO5qkqkkP9r84inTFhXY0whnPmO4d8qiftk4aEd3CVVwC3/83JEPirpheNIx55pTC8o+gxDoaoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785410155; c=relaxed/simple;
	bh=Ls9kE8/mTTNfCpcNGnqUTiMNmDuZgrZUzm3EiD39aE8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QD0Yzd4fUs3OGtS4+/5gZ+URDlC9nHiW/WwfAn8mlAUnqNpdX2XjPrTqyHlkBMubUWc6Hqug9BC/ypM2sLXMBXXO/4U18BUI+Kzhg9P0GRYY1qlH9dIWDL1fb7uQeHEobnnS/yWZ2VPTiDPkXwnRMW4kchG1sNoP1O8iwGQpLiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0005152DT.eswin.cn (unknown [10.12.96.41])
	by app2 (Coremail) with SMTP id TQJkCgCXnpxaMmtq5M43AA--.4935S2;
	Thu, 30 Jul 2026 19:15:39 +0800 (CST)
From: dongxuyang@eswincomputing.com
To: ukleinek@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ben-linux@fluff.org,
	ben.dooks@codethink.co.uk,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	p.zabel@pengutronix.de,
	daniel.lezcano@kernel.org,
	tglx@kernel.org
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	xuxiang@eswincomputing.com,
	wangguosheng@eswincomputing.com,
	pinkesh.vaghela@einfochips.com,
	Xuyang Dong <dongxuyang@eswincomputing.com>
Subject: [PATCH v14 2/5] dt-bindings: pwm: dwc: Add eswin compatible
Date: Thu, 30 Jul 2026 19:15:34 +0800
Message-Id: <20260730111534.1834-1-dongxuyang@eswincomputing.com>
X-Mailer: git-send-email 2.31.1.windows.1
In-Reply-To: <20260730111425.1680-1-dongxuyang@eswincomputing.com>
References: <20260730111425.1680-1-dongxuyang@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TQJkCgCXnpxaMmtq5M43AA--.4935S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww43uw4fXrW5XF1xJr1kKrg_yoW8tFWDpF
	4fCrWvqw1fXr17Zws5XF18C3Waqan5AF43Kr1xtr4UCa90qFWjqFW3Krn8ZFW7Zr4xZrW3
	Wan3ur13A3Wj9r7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBm14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r4a6rW5MxkIecxEwVCm-wCF04
	k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
	MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr4
	1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1U
	MIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I
	8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRNSdgDUUUU
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
 .../bindings/pwm/snps,dw-apb-timers-pwm2.yaml | 40 +++++++++++++++++--
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml b/Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml
index 1f9d72f9f359..87a56ffed09d 100644
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
@@ -64,6 +64,29 @@ required:
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
+          items:
+            - description: Combined APB interface and timer logic reset
+        reset-names: false
+      required:
+        - resets
+    else:
+      properties:
+        resets:
+          minItems: 2
+        reset-names:
+          minItems: 2
+
 additionalProperties: false
 
 examples:
@@ -75,3 +98,12 @@ examples:
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

