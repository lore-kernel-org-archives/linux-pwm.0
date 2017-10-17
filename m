From: Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [RFC PATCH v3 4/5] pwm: Add dummy pwmchip for orphan pwms
Date: Tue, 17 Oct 2017 16:09:24 +0800
Message-ID: <20171017080925.23763-5-jeffy.chen@rock-chips.com>
References: <20171017080925.23763-1-jeffy.chen@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171017080925.23763-1-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, heiko@sntech.de, briannorris@chromium.org, rjw@rjwysocki.net, dianders@chromium.org, tfiga@chromium.org, broonie@kernel.org, seanpaul@chromium.org, Jeffy Chen <jeffy.chen@rock-chips.com>, linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>
List-Id: linux-pwm@vger.kernel.org

When the pwm driver is unbound while the pwm is still requested, the
pwm core would not actually remove the pwmchip(return -EBUSY instead).

So it would hold some references to the invalid resources(e.g. pwmchip).

And the customer who requested the pwm would have those references too,
and may crash the kernel when trying to access them later.

Add a dummy pwmchip, and assign orphan pwms to it to avoid that.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v3:
Assign orphan pwms to dummy pwmchip instead of adding device link in the
customer driver.

Changes in v2: None

 drivers/pwm/core.c | 84 +++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 77 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 1581f6ab1b1f..4d8504b90a98 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -41,6 +41,21 @@ static LIST_HEAD(pwm_chips);
 static DECLARE_BITMAP(allocated_pwms, MAX_PWMS);
 static RADIX_TREE(pwm_tree, GFP_KERNEL);
 
+static int dummy_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			   struct pwm_state *state)
+{
+	return -ENOTSUPP;
+}
+
+static const struct pwm_ops dummy_pwm_ops = {
+	.apply = dummy_pwm_apply,
+	.owner = THIS_MODULE,
+};
+
+static struct device dummy_pwm_dev = {
+	.init_name = "dummy-pwm",
+};
+
 static struct pwm_device *pwm_to_device(unsigned int pwm)
 {
 	return radix_tree_lookup(&pwm_tree, pwm);
@@ -334,6 +349,33 @@ int pwmchip_add(struct pwm_chip *chip)
 }
 EXPORT_SYMBOL_GPL(pwmchip_add);
 
+static int pwmchip_convert_dummy(struct pwm_chip *chip)
+{
+	struct pwm_chip *dummy;
+	unsigned int i;
+
+	dummy = kzalloc(sizeof(*dummy), GFP_KERNEL);
+	if (!dummy)
+		return -ENOMEM;
+
+	dummy->dev = &dummy_pwm_dev;
+	dummy->ops = &dummy_pwm_ops;
+	dummy->npwm = chip->npwm;
+	dummy->pwms = chip->pwms;
+
+	INIT_LIST_HEAD(&dummy->list);
+	list_add(&dummy->list, &pwm_chips);
+
+	for (i = 0; i < dummy->npwm; i++) {
+		struct pwm_device *pwm = &dummy->pwms[i];
+
+		pwm->chip = dummy;
+		pwm->state.enabled = false;
+	}
+
+	return 0;
+}
+
 /**
  * pwmchip_remove() - remove a PWM chip
  * @chip: the PWM chip to remove
@@ -346,7 +388,7 @@ EXPORT_SYMBOL_GPL(pwmchip_add);
 int pwmchip_remove(struct pwm_chip *chip)
 {
 	unsigned int i;
-	int ret = 0;
+	int ret = 0, requested = 0;
 
 	pwmchip_sysfs_unexport_children(chip);
 
@@ -356,21 +398,28 @@ int pwmchip_remove(struct pwm_chip *chip)
 		struct pwm_device *pwm = &chip->pwms[i];
 
 		if (test_bit(PWMF_REQUESTED, &pwm->flags)) {
-			ret = -EBUSY;
-			goto out;
+			requested = 1;
+
+			if (pwm->chip->ops->free)
+				pwm->chip->ops->free(pwm->chip, pwm);
+
+			module_put(pwm->chip->ops->owner);
 		}
 	}
 
+	if (requested)
+		pwmchip_convert_dummy(chip);
+	else
+		free_pwms(chip);
+
+out:
 	list_del_init(&chip->list);
 
 	if (IS_ENABLED(CONFIG_OF))
 		of_pwmchip_remove(chip);
 
-	free_pwms(chip);
-
 	pwmchip_sysfs_unexport(chip);
 
-out:
 	mutex_unlock(&pwm_lock);
 	return ret;
 }
@@ -855,6 +904,24 @@ struct pwm_device *pwm_get(struct device *dev, const char *con_id)
 }
 EXPORT_SYMBOL_GPL(pwm_get);
 
+static int pwmchip_remove_dummy(struct pwm_chip *dummy)
+{
+	unsigned int i;
+
+	for (i = 0; i < dummy->npwm; i++) {
+		struct pwm_device *pwm = &dummy->pwms[i];
+
+		if (test_bit(PWMF_REQUESTED, &pwm->flags))
+			return -EBUSY;
+	}
+
+	free_pwms(dummy);
+	list_del_init(&dummy->list);
+	kfree(dummy);
+
+	return 0;
+}
+
 /**
  * pwm_put() - release a PWM device
  * @pwm: PWM device
@@ -876,7 +943,10 @@ void pwm_put(struct pwm_device *pwm)
 
 	pwm->label = NULL;
 
-	module_put(pwm->chip->ops->owner);
+	if (pwm->chip->ops == &dummy_pwm_ops)
+		pwmchip_remove_dummy(pwm->chip);
+	else
+		module_put(pwm->chip->ops->owner);
 out:
 	mutex_unlock(&pwm_lock);
 }
-- 
2.11.0
