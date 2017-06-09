From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] gpio: mvebu: change compatible string for PWM support
Date: Fri, 9 Jun 2017 09:42:26 +0200
Message-ID: <CACRpkdY7yy=U1DgFHXGd06UXg0hh5eC7mBKHLr7hq01hR__q8g@mail.gmail.com>
References: <20170601200820.22396-1-ralph.sennhauser@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-it0-f50.google.com ([209.85.214.50]:37959 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751596AbdFIHm2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 9 Jun 2017 03:42:28 -0400
Received: by mail-it0-f50.google.com with SMTP id r63so28863325itc.1
        for <linux-pwm@vger.kernel.org>; Fri, 09 Jun 2017 00:42:28 -0700 (PDT)
In-Reply-To: <20170601200820.22396-1-ralph.sennhauser@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Ralph Sennhauser <ralph.sennhauser@gmail.com>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Russell King <linux@armlinux.org.uk>, Richard Genoud <richard.genoud@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, Jun 1, 2017 at 10:08 PM, Ralph Sennhauser
<ralph.sennhauser@gmail.com> wrote:

> As it turns out more than just Armada 370 and XP support using GPIO
> lines as PWM lines. For example the Armada 38x family has the same
> hardware support. As such "marvell,armada-370-xp-gpio" for the
> compatible string is a misnomer.
>
> Change the compatible string to "marvell,armada-370-gpio" before the
> driver makes it out of the -rc stage. This also follows the practice of
> using only the first device family supported as part of the name.
>
> Also update the documentation and comments in the code accordingly.
>
> Fixes: 757642f9a584 ("gpio: mvebu: Add limited PWM support")
> Signed-off-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>

Patch applied for next with the tags.

Yours,
Linus Walleij
