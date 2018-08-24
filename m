Return-Path: <enric.balletbo@collabora.com>
Subject: Re: [BUG] linux-next: kernel hangs at pwm bl probe
References: <87tvnl8ud7.fsf@belgarion.home>
 <f2b1dd39-7c1c-a07a-7438-6046ccd42909@collabora.com>
 <87lg8w986r.fsf@belgarion.home>
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <131f2c7b-4a2c-b8a7-51c9-94b3eeed5e2d@collabora.com>
Date: Fri, 24 Aug 2018 12:27:44 +0200
MIME-Version: 1.0
In-Reply-To: <87lg8w986r.fsf@belgarion.home>
Content-Type: multipart/mixed;
 boundary="------------6E11362C260B03A07B4FC654"
Content-Language: en-GB
List-ID: <linux-pwm.vger.kernel.org>
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org

This is a multi-part message in MIME format.
--------------6E11362C260B03A07B4FC654
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi Robert,

On 23/08/18 21:47, Robert Jarzmik wrote:
> Enric Balletbo i Serra <enric.balletbo@collabora.com> writes:
> 
>> Hi Robert,
>> Heiko reported me a similar issue yesterday, can you try if this patch fixes the
>> issue?
> Kind of ...
> 
> The good news : the kernel doesn't hang anymore.
> The bad news :
>  - userspace compatibility is broken : from former 100 max brightness, now the
>  max brightness is 682666 (see arch/arm/mach-pxa/mioa701.c:191)
>  - the brightness setting is eratic : a brightness of 300000 is brighter than a
>  brightness of 600000
> 

So, looks like I broke the non-dt case, sorry my bad. Could you test the
attached patch? (note: applies with the patch applied before reverted)

I'll work on this and send a proper fix probably this afternoon.

> So in the current state, the backlight pwm is broken for my platforms, let's see
> what happens next.
> 
> Cheers.
> 

Thanks in advance,
 Enric

--------------6E11362C260B03A07B4FC654
Content-Type: text/x-patch;
 name="non-dt-case.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="non-dt-case.patch"

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index bdfcc0a71db1..b2e38b66ab14 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -539,7 +539,20 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 
 	dev_dbg(&pdev->dev, "got pwm for backlight\n");
 
-	if (!data->levels) {
+	/*
+	 * FIXME: pwm_apply_args() should be removed when switching to
+	 * the atomic PWM API.
+	 */
+	pwm_apply_args(pb->pwm);
+
+	if (data->levels) {
+		for (i = 0; i <= data->max_brightness; i++) {
+			if (data->levels[i] > pb->scale)
+				pb->scale = data->levels[i];
+
+			pb->levels = data->levels;
+		}
+	} else if (!data->levels && !data->max_brightness) {
 		/* Get the PWM period (in nanoseconds) */
 		pwm_get_state(pb->pwm, &state);
 
@@ -550,21 +563,17 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 				"failed to setup default brightness table\n");
 			goto err_alloc;
 		}
-	}
 
-	for (i = 0; i <= data->max_brightness; i++) {
-		if (data->levels[i] > pb->scale)
-			pb->scale = data->levels[i];
+		for (i = 0; i <= data->max_brightness; i++) {
+			if (data->levels[i] > pb->scale)
+				pb->scale = data->levels[i];
 
-		pb->levels = data->levels;
+			pb->levels = data->levels;
+		}
+	} else {
+		pb->scale = data->max_brightness;
 	}
 
-	/*
-	 * FIXME: pwm_apply_args() should be removed when switching to
-	 * the atomic PWM API.
-	 */
-	pwm_apply_args(pb->pwm);
-
 	/*
 	 * The DT case will set the pwm_period_ns field to 0 and store the
 	 * period, parsed from the DT, in the PWM device. For the non-DT case,

--------------6E11362C260B03A07B4FC654--
