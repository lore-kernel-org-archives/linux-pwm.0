Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CB640DB3A;
	Thu, 30 Jul 2026 11:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785410122; cv=none; b=U7aR7gliaUHh2bo9TrtbxhyGhxkML4VKCGhLFJwley3U+RmpgL1axbQFK4teMWZFL7YcsBw23dox9h17XqS3x/Iw5IpCOddNwskDUou0UjFEFN+msfKlfrVsU90oE89WLcbty+x/pEFWRiuttSwZDK13RA6ohP5zkhXZokzMSHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785410122; c=relaxed/simple;
	bh=EQO6Eo7KZdEbs7LZyvLR5wt4HBp9yCVGCc4TxQla2Ms=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SCarz1YeFLGyfh1SiQ2W3LeMTqgauMbl1CZPDWn4vjBF/lipsyJgb/G5COLbiHNJxBvdowqqvnFpWSJLHVDsGHlsbxZuw4H1qX2k1YlLZKcVIGk+QP9ijuaiQq9GqEB70FaODmO2/COcGcjbCo8p9VNOzP0NyWx3Vhb8jy8K3KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0005152DT.eswin.cn (unknown [10.12.96.41])
	by app1 (Coremail) with SMTP id TAJkCgDXaW47MmtqWt43AA--.4667S2;
	Thu, 30 Jul 2026 19:15:09 +0800 (CST)
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
	Xuyang Dong <dongxuyang@eswincomputing.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v14 1/5] dt-bindings: pwm: dwc: Document optional resets property
Date: Thu, 30 Jul 2026 19:15:04 +0800
Message-Id: <20260730111504.1735-1-dongxuyang@eswincomputing.com>
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
X-CM-TRANSID:TAJkCgDXaW47MmtqWt43AA--.4667S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww4DAry8GFy7Cw1kuw1DGFg_yoW8Wr17pa
	yfuF92qr93JF13Ww4rXrn7Cr13XFnYyr43Kr18Xw42ya9xtayjqF4akw15JFW5ArWIvrW3
	WFWfuw13ZFWjyr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBv14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r4a6rW5MxkIecxEwVCm-wCF04
	k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
	MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr4
	1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l
	IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRuHqcUUUUU=
X-CM-SenderInfo: pgrqw5xx1d0w46hv4xpqfrz1xxwl0woofrz/

From: Xuyang Dong <dongxuyang@eswincomputing.com>

The DesignWare PWM IP has two active-low reset inputs: presetn resets
the register interface logic in the pclk (bus) domain, and
timer_N_resetn resets the counter/timer logic in the timer_N_clk
domain. The existing snps,dw-apb-timers-pwm2 binding does not
describe either of these lines.

Add the resets property and describe the function of each reset to
support future use of resets. Add the reset-names property to allow
independent control of the two reset signals.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Xuyang Dong <dongxuyang@eswincomputing.com>
---
 .../bindings/pwm/snps,dw-apb-timers-pwm2.yaml          | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml b/Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml
index 7523a89a1773..1f9d72f9f359 100644
--- a/Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml
+++ b/Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml
@@ -43,6 +43,16 @@ properties:
       - const: bus
       - const: timer
 
+  resets:
+    items:
+      - description: Interface bus (presetn) reset
+      - description: PWM timer logic (timer_N_resetn) reset
+
+  reset-names:
+    items:
+      - const: bus
+      - const: timer
+
   snps,pwm-number:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: The number of PWM channels configured for this instance
-- 
2.34.1

