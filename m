From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] pwm-pca9685: Allow any of the 16 PWMs to be used as a GPIO
Date: Tue, 20 Sep 2016 23:46:11 +0200
Message-ID: <CACRpkdYGTF_QbrOL46gw3=NJyq6LBNywEiyPwpO-ZO9iYq9Uzw@mail.gmail.com>
References: <20160920144056.130104-1-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:35508 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755347AbcITVqM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 20 Sep 2016 17:46:12 -0400
Received: by mail-oi0-f48.google.com with SMTP id w11so38602046oia.2
        for <linux-pwm@vger.kernel.org>; Tue, 20 Sep 2016 14:46:12 -0700 (PDT)
In-Reply-To: <20160920144056.130104-1-mika.westerberg@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>

On Tue, Sep 20, 2016 at 4:40 PM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:

> The PCA9685 controller has full on/off bit for each PWM channel. Setting
> this bit bypasses the PWM control and the line works just as it would be a
> GPIO. Furthermore in Intel Galileo it is actually used as GPIO output for
> discreet muxes on the board.
>
> This patch adds GPIO output only support for the driver so that we can
> control the muxes on Galileo using standard GPIO interfaces available in
> the kernel. GPIO and PWM functionality is exclusive so only one can be
> active at a time on a single PWM channel.
>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

I had bad feelings about the patch, but:
Actually, I have nothing against it.
I think it's a neat hack.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
