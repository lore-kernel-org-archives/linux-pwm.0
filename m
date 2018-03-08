From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] pwm: sysfs: use put_device() instead of kfree()
Date: Thu,  8 Mar 2018 15:27:37 +0530
Message-ID: <416c89ec3cff87e842a0ff148df13bed35a44c46.1520502811.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Never directly free @dev after calling device_register(), even
if it returned an error! Always use put_device() to give up the
reference initialized.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/pwm/sysfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
index 83f2b0b..7c71cdb 100644
--- a/drivers/pwm/sysfs.c
+++ b/drivers/pwm/sysfs.c
@@ -273,7 +273,8 @@ static int pwm_export_child(struct device *parent, struct pwm_device *pwm)
 	ret = device_register(&export->child);
 	if (ret) {
 		clear_bit(PWMF_EXPORTED, &pwm->flags);
-		kfree(export);
+		put_device(&export->child);
+		export = NULL;
 		return ret;
 	}
 
-- 
1.9.1
