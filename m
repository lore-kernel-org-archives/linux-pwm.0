From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v6 3/4] ARM: mvebu: Enable SENSORS_PWM_FAN in defconfig
Date: Mon, 24 Apr 2017 11:20:02 +0200
Message-ID: <CACRpkda6P026U4pBXPuEJ=cYu+Hz9N_-snXcOXr5c0Q9g4jBig@mail.gmail.com>
References: <20170414154056.32055-1-ralph.sennhauser@gmail.com> <20170414154056.32055-4-ralph.sennhauser@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:34821 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1167792AbdDXJUE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Apr 2017 05:20:04 -0400
Received: by mail-io0-f180.google.com with SMTP id r16so179055955ioi.2
        for <linux-pwm@vger.kernel.org>; Mon, 24 Apr 2017 02:20:04 -0700 (PDT)
In-Reply-To: <20170414154056.32055-4-ralph.sennhauser@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Ralph Sennhauser <ralph.sennhauser@gmail.com>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Russell King <linux@armlinux.org.uk>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Apr 14, 2017 at 5:40 PM, Ralph Sennhauser
<ralph.sennhauser@gmail.com> wrote:

> From: Andrew Lunn <andrew@lunn.ch>
>
> Now that the GPIO driver also supports PWM operation, enable the PWM
> framework and fan driver in mvebu_v7_defconfig.
>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> URL: https://patchwork.ozlabs.org/patch/427297/
> [Ralph Sennhauser: add fan driver to defconfig]
> Signed-off-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>
> Tested-by: Andrew Lunn <andrew@lunn.ch>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Please funnel this through ARM SoC.

Yours,
Linus Walleij
