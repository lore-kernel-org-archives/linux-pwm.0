From: Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v2 1/4] pwm: sun4i: drop unused .has_rdy member
Date: Sun, 18 Mar 2018 23:28:44 +0000
Message-ID: <20180318232847.14278-2-andre.przywara@arm.com>
References: <20180318232847.14278-1-andre.przywara@arm.com>
Reply-To: andre.przywara-5wv7dgnIgG8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBDNZNK75ZIKRBPXMXPKQKGQEAE23Y4Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20180318232847.14278-1-andre.przywara-5wv7dgnIgG8@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <rob.herring-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

Commit a054c4d68408 ("pwm: sun4i: Drop legacy callbacks") dropped the
only user of the .has_rdy member in our sun4i_pwm_data struct.
Consequently we don't need to store this anymore for the various SoCs,
which paves the way for further simplifications.

Signed-off-by: Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>
Acked-by: Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
---
 drivers/pwm/pwm-sun4i.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 334199c58f1d..b3e4a4b3774d 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -73,7 +73,6 @@ static const u32 prescaler_table[] = {
 
 struct sun4i_pwm_data {
 	bool has_prescaler_bypass;
-	bool has_rdy;
 	unsigned int npwm;
 };
 
@@ -313,31 +312,26 @@ static const struct pwm_ops sun4i_pwm_ops = {
 
 static const struct sun4i_pwm_data sun4i_pwm_data_a10 = {
 	.has_prescaler_bypass = false,
-	.has_rdy = false,
 	.npwm = 2,
 };
 
 static const struct sun4i_pwm_data sun4i_pwm_data_a10s = {
 	.has_prescaler_bypass = true,
-	.has_rdy = true,
 	.npwm = 2,
 };
 
 static const struct sun4i_pwm_data sun4i_pwm_data_a13 = {
 	.has_prescaler_bypass = true,
-	.has_rdy = true,
 	.npwm = 1,
 };
 
 static const struct sun4i_pwm_data sun4i_pwm_data_a20 = {
 	.has_prescaler_bypass = true,
-	.has_rdy = true,
 	.npwm = 2,
 };
 
 static const struct sun4i_pwm_data sun4i_pwm_data_h3 = {
 	.has_prescaler_bypass = true,
-	.has_rdy = true,
 	.npwm = 1,
 };
 
-- 
2.14.1
