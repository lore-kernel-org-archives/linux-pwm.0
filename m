From: Christian Engelmayer <cengelma@gmx.at>
Subject: [PATCH] pwm: lp3943: Fix potential memory leak during request
Date: Thu, 23 Jan 2014 22:32:20 +0100
Message-ID: <20140123223220.7d68b5f6@spike>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:57067 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752564AbaAWVcW (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Thu, 23 Jan 2014 16:32:22 -0500
Received: from spike ([81.217.122.98]) by mail.gmx.com (mrgmx102) with ESMTPSA
 (Nemesis) id 0M2FhY-1VGgi10ofE-00s7sg for <linux-pwm@vger.kernel.org>; Thu,
 23 Jan 2014 22:32:21 +0100
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Milo Kim <milo.kim@ti.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org

Fix a memory leak in the lp3943_pwm_request_map() error handling path.
Make sure already allocated pwm map memory is freed correctly.
Detected by Coverity: CID 1162829.

Signed-off-by: Christian Engelmayer <cengelma@gmx.at>
---
 drivers/pwm/pwm-lp3943.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-lp3943.c b/drivers/pwm/pwm-lp3943.c
index 8a843a0..a40b9c3 100644
--- a/drivers/pwm/pwm-lp3943.c
+++ b/drivers/pwm/pwm-lp3943.c
@@ -52,8 +52,10 @@ lp3943_pwm_request_map(struct lp3943_pwm *lp3943_pwm, int hwpwm)
 		offset = pwm_map->output[i];
 
 		/* Return an error if the pin is already assigned */
-		if (test_and_set_bit(offset, &lp3943->pin_used))
+		if (test_and_set_bit(offset, &lp3943->pin_used)) {
+			kfree(pwm_map);
 			return ERR_PTR(-EBUSY);
+		}
 	}
 
 	return pwm_map;
-- 
1.8.3.2
