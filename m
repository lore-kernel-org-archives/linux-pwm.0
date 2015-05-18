From: Tim Kryger <tim.kryger@gmail.com>
Subject: Re: [PATCH v7 3/5] pwm: kona: Fix incorrect config, disable, and
 polarity procedures
Date: Sun, 17 May 2015 21:53:30 -0700
Message-ID: <CAD7vxxLJzjE_yYOV+OtFgq34+Ryhu63YJvpY6Ryi8_=B5z5pLw@mail.gmail.com>
References: <1431473296-13683-1-git-send-email-jonathar@broadcom.com>
	<1431473296-13683-4-git-send-email-jonathar@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:35510 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000AbbERExf (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 18 May 2015 00:53:35 -0400
In-Reply-To: <1431473296-13683-4-git-send-email-jonathar@broadcom.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Jonathan Richardson <jonathar@broadcom.com>
Cc: Dmitry Torokhov <dtor@google.com>, Anatol Pomazau <anatol@google.com>, Arun Ramamurthy <arun.ramamurthy@broadcom.com>, Thierry Reding <thierry.reding@gmail.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PWM <linux-pwm@vger.kernel.org>

On Tue, May 12, 2015 at 4:28 PM, Jonathan Richardson
<jonathar@broadcom.com> wrote:

> The polarity procedure no longer applies the settings to change the
> output signal because it can't be called when the pwm is enabled anyway.
> The polarity is only updated in the control register. The correct
> polarity will be applied on enable. The old method of applying changes
> would result in no signal when the polarity was changed. The new
> apply_settings function would fix this problem but it isn't required
> anyway.

Thanks for incorporating some of my suggestions in your latest version.

I'm still concerned about delaying when polarity changes take effect.

Since backlight is a common use of PWM, consider the following situation.

backlight {
        compatible = "pwm-backlight";
        pwms = <&pwm 0 5000000 PWM_POLARITY_NORMAL>;
        brightness-levels = <0 4 8 16 32 64 128 255>;
        default-brightness-level = <0>;
};

The Kona PWM hardware starts in inversed mode so it will drive output high
once its clock is enabled during the probe.

Polarity is not adjusted during probe so it stays high and it registers with
the PWM core using the new pwmchip_add_inversed() function.

Next, the pwm-backlight driver probe executes and it calls devm_pwm_get()
which then calls pwm_set_period() and most importantly pwm_set_polarity().

The output would change to constant low at this point in the original driver
but with your proposed change it will remain high.

The driver sets bl->props.brightness and calls backlight_update_status() but,
since in this case the default brightness is zero, it assumes it doesn't need
to enable the PWM.

The backlight driver probe then returns and the PWM output is incorrect.
