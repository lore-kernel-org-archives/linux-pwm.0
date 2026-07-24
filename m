Received: from mail.eswincomputing.com (mail.eswincomputing.com [123.124.195.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279F33EB0F7;
	Fri, 24 Jul 2026 08:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.124.195.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784882738; cv=none; b=biJbYnlnlHKJclsTKXRqvYZIYypjpOYxQX7HrQn9/g8wuIy0P2rGGyDQsfzPUOMdxKh3VEvp3XRdh3uG1wVqhSaNtBWHwUO7zIrZcrVyDPRDq1DlVCxiRFPa0BzfZcvn1MU1Xsjd8yekx8TmPQh8MBRA0yDdY3ugz10SxDAMjqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784882738; c=relaxed/simple;
	bh=71xXZyo77HeZR+z7h3T5MQpAle6zFFn2lTgrSBG5SH4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z82qkWmc+N9by8pZ1VRNP33aQGjxx+KcUvs0E1eQwenvfo3UWKPmxYXPWIlYidrMndj/pFMJXFPsk3960vXylnBNjRm5ZkepzSszg6Q21ttnv/3czuLHPZIL1LhA0Zaj6pchIFcLUFndpjI9QJnKbT9ZnKxdKf6HeB+cCoquzVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=123.124.195.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0005152DT.eswin.cn (unknown [10.12.96.41])
	by app1 (Coremail) with SMTP id TAJkCgBH22_3JWNqjPs2AA--.3626S2;
	Fri, 24 Jul 2026 16:44:41 +0800 (CST)
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
Subject: [PATCH v13 5/5] clocksource: dw_apb_timer: Use reset array API to handle all resets
Date: Fri, 24 Jul 2026 16:44:37 +0800
Message-Id: <20260724084437.1850-1-dongxuyang@eswincomputing.com>
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
X-CM-TRANSID:TAJkCgBH22_3JWNqjPs2AA--.3626S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww4fuw4xGFWrAFyDGr43Awb_yoW8WFy3pa
	1fGry3GFy8uF45ua1vya4UuFyfZ3WrGFyUJrWFkws7Aw43JFy8JrW2kry5AFy7ArW0vrWa
	vF4S9w1ruFWjyF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBG14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r4a6rW5MxkIecxEwVCm-wCF04
	k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
	MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr4
	1lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4U
	JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRByxiUUUUU=
X-CM-SenderInfo: pgrqw5xx1d0w46hv4xpqfrz1xxwl0woofrz/

From: Xuyang Dong <dongxuyang@eswincomputing.com>

timer_get_base_and_rate() only ever fetched a single, index-0 reset
control via of_reset_control_get(np, NULL), which does not consult
reset-names and always resolves to the first entry. With the binding
now allowing a second entry, a device tree that lists both lines would
leave the second entry permanently unasserted, since the driver never
touches it.

Replace it with devm_reset_control_array_get_optional_exclusive() to
fetch and control all reset lines listed in the device tree, ensuring
every line is properly asserted and deasserted rather than only the first.

Signed-off-by: Xuyang Dong <dongxuyang@eswincomputing.com>
---
 drivers/clocksource/dw_apb_timer_of.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/dw_apb_timer_of.c b/drivers/clocksource/dw_apb_timer_of.c
index 3245eb0c602d..ffe495a8416a 100644
--- a/drivers/clocksource/dw_apb_timer_of.c
+++ b/drivers/clocksource/dw_apb_timer_of.c
@@ -29,9 +29,11 @@ static int __init timer_get_base_and_rate(struct device_node *np,

 	/*
 	 * Reset the timer if the reset control is available, wiping
-	 * out the state the firmware may have left it
+	 * out the state the firmware may have left it.
+	 * Use array variant to handle multiple resets (e.g., timer
+	 * and APB interface resets) if specified in the device tree.
 	 */
-	rstc = of_reset_control_get(np, NULL);
+	rstc = of_reset_control_array_get_optional_exclusive(np);
 	if (!IS_ERR(rstc)) {
 		reset_control_assert(rstc);
 		reset_control_deassert(rstc);
--
2.34.1

