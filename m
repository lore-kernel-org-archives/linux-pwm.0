From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: pwm-backlight: 3.13-rc1 regression for old arm machine
Date: Tue, 17 Dec 2013 19:31:21 +0100
Message-ID: <87iounuy6e.fsf@free.fr>
References: <87r49c6bea.fsf@free.fr> <20131217095658.GD13823@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from smtp6-g21.free.fr ([212.27.42.6]:54773 "EHLO smtp6-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932389Ab3LQSbj (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Tue, 17 Dec 2013 13:31:39 -0500
In-Reply-To: <20131217095658.GD13823@ulmo.nvidia.com> (Thierry Reding's
	message of "Tue, 17 Dec 2013 10:57:00 +0100")
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org

Thierry Reding <thierry.reding@gmail.com> writes:

> I hadn't anticipated that =(. In fact I had been holding this patch back
> for a release cycle because I was waiting for a specific regulator patch
> to land which provides a dummy regulator if one wasn't specified. It
> seems that that patch only works when booting from DT, though.
>
> The correct way to fix this would be to provide a lookup table with the
> dummy regulator in the board file. I've attached a patch (compile-tested
> only) that might work.
>
> If it does, please let me know and, if nobody else volunteers, I'll see
> if I can come up with a set of patches to fix this for any other boards
> that have the same issue.
Actually, it needs a very small "tweak" to work :
-	REGULATOR_SUPPLY("power", "pwm-backlight.0"),
+	REGULATOR_SUPPLY("power", "pwm-backlight"),

Without it regulator_dev_lookup() won't match the device.

Moreover, it requires a config option, CONFIG_REGULATOR_FIXED_VOLTAGE=y. That's
not a problem for my specific platform, but I haven't seen *any* PXA platform
with it activated, which means all defconfigs have to be patched, which is
unfortunate.

As for my specific mioa701, your change with the tweak is perfectly fine and
tested.

Cheers.

--
Robert
