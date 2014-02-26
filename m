From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 6/9] pwm: tegra: Remove unnecessary OOM messages
Date: Wed, 26 Feb 2014 10:10:53 +0900
Message-ID: <001901cf328f$981dddc0$c8599940$%han@samsung.com>
References: <000701cf328e$00ed24c0$02c76e40$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:38757 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751705AbaBZBK4 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 25 Feb 2014 20:10:56 -0500
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N1K00107WM53EC0@mailout3.samsung.com> for
 linux-pwm@vger.kernel.org; Wed, 26 Feb 2014 10:10:53 +0900 (KST)
In-reply-to: <000701cf328e$00ed24c0$02c76e40$%han@samsung.com>
Content-language: ko
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: 'Thierry Reding' <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>, 'Stephen Warren' <swarren@wwwdotorg.org>

The site-specific OOM messages are unnecessary, because they
duplicate the MM subsystem generic OOM message.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/pwm/pwm-tegra.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index 74298c5..61d86b9 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -173,10 +173,8 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 	int ret;
 
 	pwm = devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
-	if (!pwm) {
-		dev_err(&pdev->dev, "failed to allocate memory\n");
+	if (!pwm)
 		return -ENOMEM;
-	}
 
 	pwm->dev = &pdev->dev;
 
-- 
1.7.10.4


