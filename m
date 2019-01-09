Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from userp2130.oracle.com ([156.151.31.86]:43404 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfAII2G (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 9 Jan 2019 03:28:06 -0500
Date: Wed, 9 Jan 2019 11:27:47 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
Message-ID: <20190109082747.GA5476@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: [PATCH] pwm: imx: Signedness bug in imx_pwm_get_state()
To: Thierry Reding <thierry.reding@gmail.com>, Anson Huang <anson.huang@nxp.com>
Cc: linux-pwm@vger.kernel.org, kernel-janitors@vger.kernel.org

"ret" only holds zero and negative error codes.  It needs to be signed
for the error handling to work.

Fixes: 9f4c8f9607c3 ("pwm: imx: Add ipg clock operation")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/pwm/pwm-imx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index 55a3a363d5be..b8452abe2392 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -128,8 +128,9 @@ static void imx_pwm_get_state(struct pwm_chip *chip,
 		struct pwm_device *pwm, struct pwm_state *state)
 {
 	struct imx_chip *imx = to_imx_chip(chip);
-	u32 period, prescaler, pwm_clk, ret, val;
+	u32 period, prescaler, pwm_clk, val;
 	u64 tmp;
+	int ret;
 
 	ret = imx_pwm_clk_prepare_enable(chip);
 	if (ret < 0)
-- 
2.17.1
