Return-Path: <linux-pwm-owner@vger.kernel.org>
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:21258 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbeHWXTL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 23 Aug 2018 19:19:11 -0400
From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [BUG] linux-next: kernel hangs at pwm bl probe
References: <87tvnl8ud7.fsf@belgarion.home>
        <f2b1dd39-7c1c-a07a-7438-6046ccd42909@collabora.com>
Date: Thu, 23 Aug 2018 21:47:24 +0200
In-Reply-To: <f2b1dd39-7c1c-a07a-7438-6046ccd42909@collabora.com> (Enric
        Balletbo i. Serra's message of "Thu, 23 Aug 2018 09:51:17 +0200")
Message-ID: <87lg8w986r.fsf@belgarion.home>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org

Enric Balletbo i Serra <enric.balletbo@collabora.com> writes:

> Hi Robert,
> Heiko reported me a similar issue yesterday, can you try if this patch fixes the
> issue?
Kind of ...

The good news : the kernel doesn't hang anymore.
The bad news :
 - userspace compatibility is broken : from former 100 max brightness, now the
 max brightness is 682666 (see arch/arm/mach-pxa/mioa701.c:191)
 - the brightness setting is eratic : a brightness of 300000 is brighter than a
 brightness of 600000

So in the current state, the backlight pwm is broken for my platforms, let's see
what happens next.

Cheers.

-- 
Robert
