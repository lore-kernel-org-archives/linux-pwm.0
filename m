From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
Subject: Re: [PATCH 0/2] backlight: pwm_bl: prevent backlight flicker when
 switching PWM on
Date: Tue, 14 Nov 2017 08:56:16 +0100
Message-ID: <20171114085616.3dfe6f03@karo-electronics.de>
References: <1509022186-19636-1-git-send-email-LW@KARO-electronics.de>
        <1509022186-19636-2-git-send-email-LW@KARO-electronics.de>
        <cec1af21-8a6d-f9f3-eaf0-197ba68d87ee@linaro.org>
        <8682e9c4-518d-5dce-55c5-c221dddd5fd6@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from smtprelay02.ispgateway.de ([80.67.18.14]:63000 "EHLO
        smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751848AbdKNH4Y (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 14 Nov 2017 02:56:24 -0500
In-Reply-To: <8682e9c4-518d-5dce-55c5-c221dddd5fd6@collabora.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Pavel Machek <pavel@ucw.cz>, Richard Purdie <rpurdie@rpsys.net>, Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org

Hi,

On Fri, 10 Nov 2017 12:22:15 +0100 Enric Balletbo i Serra wrote:
> Hi all,
> 
> On 08/11/17 11:48, Daniel Thompson wrote:
> > On 26/10/17 13:49, Lothar Waßmann wrote:
> >> These patches implement some measures to prevent backlight flicker
> >> when the backlight is being switched on for a display with an active
> >> low brightness control pin.
> >> GIT: [PATCH 1/2] backlight: pwm_bl: Enable PWM before switching regulator
> >> GIT: [PATCH 2/2] backlight: pwm_bl: add configurable delay between
> > 
> > Other than hoisting the pwm_enable() even earlier in the setup sequence this
> > patchset seems to have a significant overlap with Enric's recent posting:
> > 
> >   https://lkml.org/lkml/2017/7/21/211
> > 
> > Any chance of a shared view on this, especially on the DT bindings?
> > 
> 
> The DT binding were discussed some time ago for the patch series I sent, though
> there isn't a final ack from DT maintainer.
> 
> Lothar, the series I sent have been reviewed and acked, can you test if the
> series fixes the problem for you too?
> 
I'll try to test it within the next couple of days and will report back.


Lothar Waßmann
