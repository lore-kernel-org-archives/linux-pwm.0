From: Aurelio Colosimo <aurelio.colosimo@gmail.com>
Subject: [PATCH 1/2] pwm: new field name added to pwm_device
Date: Tue,  5 Aug 2014 17:12:17 +0200
Message-ID: <1407251538-17566-2-git-send-email-aurelio@aureliocolosimo.it>
References: <1407251538-17566-1-git-send-email-aurelio@aureliocolosimo.it>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1407251538-17566-1-git-send-email-aurelio@aureliocolosimo.it>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Randy Dunlap <rdunlap@infradead.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Aurelio Colosimo <aurelio@aureliocolosimo.it>
List-Id: linux-pwm@vger.kernel.org

Since label is used dinamically, I added one more optional field,
which statically defines the name of a pwm output, in a similar way
as gpio framework does.

Signed-off-by: Aurelio Colosimo <aurelio@aureliocolosimo.it>
---
 drivers/pwm/sysfs.c | 7 ++++++-
 include/linux/pwm.h | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
index 4bd0c63..c1d6064 100644
--- a/drivers/pwm/sysfs.c
+++ b/drivers/pwm/sysfs.c
@@ -198,7 +198,12 @@ static int pwm_export_child(struct device *parent, struct pwm_device *pwm)
 	export->child.parent = parent;
 	export->child.devt = MKDEV(0, 0);
 	export->child.groups = pwm_groups;
-	dev_set_name(&export->child, "pwm%u", pwm->hwpwm);
+
+	if (pwm->name)
+		dev_set_name(&export->child, pwm->name, pwm->hwpwm);
+	else
+		dev_set_name(&export->child, "pwm%u", pwm->hwpwm);
+
 
 	ret = device_register(&export->child);
 	if (ret) {
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index e90628c..9bacf35 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -86,6 +86,7 @@ struct pwm_device {
 	unsigned int		pwm;
 	struct pwm_chip		*chip;
 	void			*chip_data;
+	const char		*name; /* optional static name for pwm device */
 
 	unsigned int		period; 	/* in nanoseconds */
 	unsigned int		duty_cycle;	/* in nanoseconds */
-- 
1.9.1
