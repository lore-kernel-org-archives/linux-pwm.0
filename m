Return-Path: <axel.lin@ingics.com>
Return-Path: <axel.lin@ingics.com>
Message-ID: <1372177502.26044.1.camel@phoenix>
Subject: [PATCH] pwm: renesas-tpu: Add MODULE_ALIAS to make module auto
 loading work
From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 26 Jun 2013 00:25:02 +0800
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
List-ID: <linux-pwm.vger.kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Simon Horman <horms+renesas@verge.net.au>, linux-pwm@vger.kernel.org, linux-sh@vger.kernel.org

This driver can be built as module, add MODULE_ALIAS to make module auto loading
work.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/pwm/pwm-renesas-tpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pwm/pwm-renesas-tpu.c b/drivers/pwm/pwm-renesas-tpu.c
index 96e0cc4..ee53ca2 100644
--- a/drivers/pwm/pwm-renesas-tpu.c
+++ b/drivers/pwm/pwm-renesas-tpu.c
@@ -473,3 +473,4 @@ module_platform_driver(tpu_driver);
 MODULE_AUTHOR("Laurent Pinchart <laurent.pinchart@ideasonboard.com>");
 MODULE_DESCRIPTION("Renesas TPU PWM Driver");
 MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:renesas-tpu-pwm");
-- 
1.8.1.2
