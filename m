Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631F63E8354;
	Fri, 24 Jul 2026 08:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784882678; cv=none; b=KWcXK6UoU97wr+QjwdIiGUFO6gevBLzP0FqJb+vevOXeEEIiXrT2avVrR8XliE4TcCf2g6c0isllSdW05yDSCXIa/DZItk62PJ+QZiSbbT7VrPMdZl19hTWb5njtP8jJpgXYSqXYSE8amd8TiQWNpkMRiw/qFjaECgpPWSY89iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784882678; c=relaxed/simple;
	bh=dh/du7Uk0Ql6cULT3pGKoKFY6MRS9Z9uv8V9RNL1qA8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H3nec8+6dRdbpiCGAyvrZLIez/grjEm/KJV6IZw9w9r7lF+40UVkf2nmV1VgN4qdzJbAwV8CNOJDfO7p5Eb7UHBVDiSijlaJr1qvcH6V9iTqV4a22dQS7owZacsa2DJUUj1wQKS0dKT57M6ZK14HQLkjXbwgVk0K5h+bESdfb8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0005152DT.eswin.cn (unknown [10.12.96.41])
	by app2 (Coremail) with SMTP id TQJkCgBXbaDmJWNqGe02AA--.20050S2;
	Fri, 24 Jul 2026 16:44:23 +0800 (CST)
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
Subject: [PATCH v13 4/5] dt-bindings: timer: dwc: Update resets property items
Date: Fri, 24 Jul 2026 16:44:19 +0800
Message-Id: <20260724084419.1795-1-dongxuyang@eswincomputing.com>
X-Mailer: git-send-email 2.31.1.windows.1
In-Reply-To: <20260724084153.1473-1-dongxuyang@eswincomputing.com>
References: <20260724084153.1473-1-dongxuyang@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TQJkCgBXbaDmJWNqGe02AA--.20050S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww43tF1kXF1rJr4rGFW8Xrb_yoW8Gr48pF
	WxCFs2qF93XF13Xw4kJFn2ka45Zas8Cr4xCF1IgwsFyFW7Ja1YqF4Fkr1jqFW3Ar4I9FW3
	WF4xuw4Yya4jyr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBm14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r4a6rW5MxkIecxEwVCm-wCF04
	k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
	MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr4
	1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1U
	MIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I
	8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRKtCzDUUUU
X-CM-SenderInfo: pgrqw5xx1d0w46hv4xpqfrz1xxwl0woofrz/

From: Xuyang Dong <dongxuyang@eswincomputing.com>

The DesignWare DW_apb_timers IP has two active-low reset inputs:
presetn resets the register interface logic in the pclk (bus) domain,
and timer_N_resetn resets the counter/timer logic in the timer_N_clk
domain. The existing snps,dw-apb-timer binding only describes one.

Update snps,dw-apb-timer binding to allow up to two reset lines,
matching the hardware capabilities of the DesignWare IP family.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Xuyang Dong <dongxuyang@eswincomputing.com>
---
 .../devicetree/bindings/timer/snps,dw-apb-timer.yaml         | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/timer/snps,dw-apb-timer.yaml b/Documentation/devicetree/bindings/timer/snps,dw-apb-timer.yaml
index d33c9205a909..4d30cd01ac65 100644
--- a/Documentation/devicetree/bindings/timer/snps,dw-apb-timer.yaml
+++ b/Documentation/devicetree/bindings/timer/snps,dw-apb-timer.yaml
@@ -25,7 +25,10 @@ properties:
     maxItems: 1

   resets:
-    maxItems: 1
+    minItems: 1
+    items:
+      - description: Timer ticks reference (timer_N_resetn) reset
+      - description: APB interface (presetn) reset

   clocks:
     minItems: 1
--
2.34.1

