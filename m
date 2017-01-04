From: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH 1/2] pwm: Remove pwm_can_sleep()
Date: Wed,  4 Jan 2017 10:13:47 +0100
Message-ID: <20170104091348.31277-1-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: devel@driverdev.osuosl.org, linux-pwm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

The last user of this function has been removed, so it is no longer
needed.

Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
---
 drivers/pwm/core.c  | 12 ------------
 include/linux/pwm.h |  7 -------
 2 files changed, 19 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 172ef8245811..78e114a11c4f 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -960,18 +960,6 @@ void devm_pwm_put(struct device *dev, struct pwm_device *pwm)
 }
 EXPORT_SYMBOL_GPL(devm_pwm_put);
 
-/**
-  * pwm_can_sleep() - report whether PWM access will sleep
-  * @pwm: PWM device
-  *
-  * Returns: True if accessing the PWM can sleep, false otherwise.
-  */
-bool pwm_can_sleep(struct pwm_device *pwm)
-{
-	return true;
-}
-EXPORT_SYMBOL_GPL(pwm_can_sleep);
-
 #ifdef CONFIG_DEBUG_FS
 static void pwm_dbg_show(struct pwm_chip *chip, struct seq_file *s)
 {
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 2c6c5114c089..e15fd3ce6502 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -451,8 +451,6 @@ struct pwm_device *devm_pwm_get(struct device *dev, const char *con_id);
 struct pwm_device *devm_of_pwm_get(struct device *dev, struct device_node *np,
 				   const char *con_id);
 void devm_pwm_put(struct device *dev, struct pwm_device *pwm);
-
-bool pwm_can_sleep(struct pwm_device *pwm);
 #else
 static inline struct pwm_device *pwm_request(int pwm_id, const char *label)
 {
@@ -566,11 +564,6 @@ static inline struct pwm_device *devm_of_pwm_get(struct device *dev,
 static inline void devm_pwm_put(struct device *dev, struct pwm_device *pwm)
 {
 }
-
-static inline bool pwm_can_sleep(struct pwm_device *pwm)
-{
-	return false;
-}
 #endif
 
 static inline void pwm_apply_args(struct pwm_device *pwm)
-- 
2.11.0
