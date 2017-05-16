From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] pwm-bfin: Delete an error message for a failed memory
 allocation in bfin_pwm_probe()
Date: Tue, 16 May 2017 11:46:37 +0200
Message-ID: <98188bf2-25b4-b784-6d98-21d51ba5c432@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.12]:53997 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751080AbdEPJqt (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 16 May 2017 05:46:49 -0400
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 16 May 2017 11:40:09 +0200

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/pwm/pwm-bfin.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-bfin.c b/drivers/pwm/pwm-bfin.c
index d2ed0a2a18e8..a9a88137f2cb 100644
--- a/drivers/pwm/pwm-bfin.c
+++ b/drivers/pwm/pwm-bfin.c
@@ -118,10 +118,8 @@ static int bfin_pwm_probe(struct platform_device *pdev)
 	int ret;
 
 	pwm = devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
-	if (!pwm) {
-		dev_err(&pdev->dev, "failed to allocate memory\n");
+	if (!pwm)
 		return -ENOMEM;
-	}
 
 	platform_set_drvdata(pdev, pwm);
 
-- 
2.13.0
