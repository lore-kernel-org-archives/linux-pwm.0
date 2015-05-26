From: Jonathan Richardson <jonathar@broadcom.com>
Subject: [PATCH v8 5/5] pwm: core: Set enable state properly on failed call to enable
Date: Tue, 26 May 2015 13:08:20 -0700
Message-ID: <1432670900-27687-6-git-send-email-jonathar@broadcom.com>
References: <1432670900-27687-1-git-send-email-jonathar@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1432670900-27687-1-git-send-email-jonathar@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tim Kryger <tim.kryger@gmail.com>, Dmitry Torokhov <dtor@google.com>, Anatol Pomazau <anatol@google.com>, Arun Ramamurthy <arun.ramamurthy@broadcom.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: Scott Branden <sbranden@broadcom.com>, Jonathan Richardson <jonathar@broadcom.com>, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

The pwm_enable function didn't clear the enabled bit if a call to a
clients enable function returned an error. The result was that the state
of the pwm core was wrong. Clearing the bit when enable returns an error
ensures the state is properly set.

Tested-by: Jonathan Richardson <jonathar@broadcom.com>
Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Jonathan Richardson <jonathar@broadcom.com>
---
 drivers/pwm/core.c |   16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 224645f..18f5ac4 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -477,10 +477,20 @@ EXPORT_SYMBOL_GPL(pwm_set_polarity);
  */
 int pwm_enable(struct pwm_device *pwm)
 {
-	if (pwm && !test_and_set_bit(PWMF_ENABLED, &pwm->flags))
-		return pwm->chip->ops->enable(pwm->chip, pwm);
+	int err;
+
+	if (!pwm)
+		return -EINVAL;
+
+	if (!test_and_set_bit(PWMF_ENABLED, &pwm->flags)) {
+		err = pwm->chip->ops->enable(pwm->chip, pwm);
+		if (err) {
+			clear_bit(PWMF_ENABLED, &pwm->flags);
+			return err;
+		}
+	}
 
-	return pwm ? 0 : -EINVAL;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(pwm_enable);
 
-- 
1.7.9.5
