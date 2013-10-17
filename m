Return-Path: <nvmarkzhang@gmail.com>
Return-Path: <nvmarkzhang@gmail.com>
Message-ID: <525F8895.5010806@gmail.com>
Date: Thu, 17 Oct 2013 14:49:57 +0800
From: Mark Zhang <nvmarkzhang@gmail.com>
MIME-Version: 1.0
Subject: How to set fops in "struct platform_pwm_backlight_data"?
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-ID: <linux-pwm.vger.kernel.org>
To: thierry.reding@gmail.com, rpurdie@rpsys.net, jg1.han@samsung.com, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, tomi.valkeinen@ti.com
Cc: linux-pwm@vger.kernel.org, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi,

This is the first time I send mail to linux-pwm, I didn't read through
the mails in this list, so if somebody already asked this question, I'm
sorry about that.

I wanna set some fops in "struct platform_pwm_backlight_data". But the
currrent probe function in pwm_bl.c says:

-------
if (!data) {
	ret = pwm_backlight_parse_dt(&pdev->dev, &defdata);
	if (ret < 0) {
		dev_err(&pdev->dev, "failed to find platform data\n");
		return ret;
	}

	data = &defdata;
}
-------

This looks like if we set the platform data for pwm backlight device,
"pwm_backlight_parse_dt" will never have a chance to be called, which
means the stuffs I defined in backlight DT node will be ignored.

If I don't set the platform data for pwm backlight device, according to
the pwm_backlight_probe, I will never have a chance to set some fops
which I need(like "notify", "check_fb"...).

So, what I suppose to do now? Maybe there is a way to set function
pointers in DT?

Mark
