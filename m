From: Johan Hovold <johan@kernel.org>
Subject: [PATCH] pwm: fix device reference leak
Date: Tue,  1 Nov 2016 11:46:39 +0100
Message-ID: <1477997199-29305-1-git-send-email-johan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
List-Id: linux-pwm@vger.kernel.org

Make sure to drop the reference to the parent device taken by
class_find_device() after "unexporting" any children when deregistering
a pwm chip.

Fixes: 0733424c9ba9 ("pwm: Unexport children before chip removal")
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/pwm/sysfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
index 0296d8178ae2..a813239300c3 100644
--- a/drivers/pwm/sysfs.c
+++ b/drivers/pwm/sysfs.c
@@ -425,6 +425,8 @@ void pwmchip_sysfs_unexport_children(struct pwm_chip *chip)
 		if (test_bit(PWMF_EXPORTED, &pwm->flags))
 			pwm_unexport_child(parent, pwm);
 	}
+
+	put_device(parent);
 }
 
 static int __init pwm_sysfs_init(void)
-- 
2.7.3
