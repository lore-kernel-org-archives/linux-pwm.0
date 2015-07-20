From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH v2 05/10] pwm: declare a default PWM state
Date: Mon, 20 Jul 2015 17:32:02 +0200
Message-ID: <1437406327-6207-6-git-send-email-boris.brezillon@free-electrons.com>
References: <1437406327-6207-1-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1437406327-6207-1-git-send-email-boris.brezillon@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, linux-fbdev@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>, Jingoo Han <jingoohan1@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Bryan Wu <cooloney@gmail.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, linux-rockchip@lists.infradead.org, Mark Brown <broonie@kernel.org>, Richard Purdie <rpurdie@rpsys.net>, linux-arm-kernel@lists.infradead.org, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Doug Anderson <dianders@google.com>, Lee Jones <lee.jones@linaro.org>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Prepare the addition of the PWM initial state retrieval by adding a default
state where all the parameters retrieved from DT, platform data or
statically forced by the hardware will be stored.
Once done we will be able to store the initial state in the ->state field
without risking to loose the default parameters.

Update the pwm_set/get_default_xxx helpers accordingly.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 include/linux/pwm.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index f4bc034..1e6e9d1 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -101,6 +101,7 @@ struct pwm_device {
 	void			*chip_data;
 
 	struct pwm_state	state;
+	struct pwm_state	default_state;
 };
 
 static inline bool pwm_is_enabled(const struct pwm_device *pwm)
@@ -117,7 +118,8 @@ static inline void pwm_set_period(struct pwm_device *pwm, unsigned int period)
 static inline void pwm_set_default_period(struct pwm_device *pwm,
 					  unsigned int period)
 {
-	pwm_set_period(pwm, period);
+	if (pwm)
+		pwm->default_state.period = period;
 }
 
 static inline unsigned int pwm_get_period(const struct pwm_device *pwm)
@@ -127,7 +129,7 @@ static inline unsigned int pwm_get_period(const struct pwm_device *pwm)
 
 static inline unsigned int pwm_get_default_period(const struct pwm_device *pwm)
 {
-	return pwm_get_period(pwm);
+	return pwm ? pwm->default_state.period : 0;
 }
 
 static inline void pwm_set_duty_cycle(struct pwm_device *pwm, unsigned int duty)
@@ -149,7 +151,8 @@ int pwm_set_polarity(struct pwm_device *pwm, enum pwm_polarity polarity);
 static inline void pwm_set_default_polarity(struct pwm_device *pwm,
 					    enum pwm_polarity polarity)
 {
-	pwm_set_polarity(pwm, polarity);
+	if (pwm)
+		pwm->default_state.polarity = polarity;
 }
 
 static inline enum pwm_polarity pwm_get_polarity(const struct pwm_device *pwm)
-- 
1.9.1
