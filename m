Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35922 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfINR3f (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 14 Sep 2019 13:29:35 -0400
Received: by mail-oi1-f194.google.com with SMTP id k20so5212541oih.3
        for <linux-pwm@vger.kernel.org>; Sat, 14 Sep 2019 10:29:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190830182830.81627-1-andriy.shevchenko@linux.intel.com> <20190913125922.GH28281@lahna.fi.intel.com>
In-Reply-To: <20190913125922.GH28281@lahna.fi.intel.com>
From: Sven Van Asbroeck <thesven73@gmail.com>
Date: Sat, 14 Sep 2019 13:29:23 -0400
Message-ID: <CAGngYiUeKPkSgi8i3_Q09LKJko_D1RUGQYcE12rZ9J3q169gdA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH v2] pwm: pca9685: Fix regression for GPIO use
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>

Hi Andy,

On Fri, Sep 13, 2019 at 8:59 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> There was another patch from Sven (cc'd) fixing the same issue here:
>   https://lore.kernel.org/patchwork/patch/1084046/
>
> But I don't think it was ever merged anywhere. Maybe you can try it out
> and give your tested-by?

When the issue came up, Mika and I considered restoring the old synchronization.
But we suspect that the old synchronization is broken, or has become
broken over time.
See: https://lkml.org/lkml/2019/6/2/73

The patch above was reviewed by Mika, but could not be merged - there was no-one
available to test it out on actual h/w.

I did however successfully test the logic. I disconnected the driver
from its h/w by
giving it a dummy regmap.
See: https://lkml.org/lkml/2019/6/6/666

I am of course open to alternative solutions.

Sven
